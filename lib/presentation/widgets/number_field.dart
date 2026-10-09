import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/utils/format_utils.dart';

/// Editable numeric field with a persistent controller and focus node.
///
/// While the field is focused the text is never rewritten, so typing and
/// deleting never move the cursor or steal focus. On blur the value is
/// committed, clamped to [min]-[max], and the text is canonicalized
/// (integers without decimals, fractions trimmed via [formatWeight]).
class NumberField extends StatefulWidget {
    const NumberField({
        required this.value,
        required this.onChanged,
        this.min = 0,
        this.max = 1000000,
        this.decoration = const InputDecoration(),
        this.textStyle,
        this.textAlign = TextAlign.start,
        this.fieldKey,
        super.key,
    });

    final num value;
    final ValueChanged<double> onChanged;
    final num min;
    final num max;
    final InputDecoration decoration;
    final TextStyle? textStyle;
    final TextAlign textAlign;
    final Key? fieldKey;

    @override
    State<NumberField> createState() => _NumberFieldState();
}

class _NumberFieldState extends State<NumberField> {    late final TextEditingController _controller =
        TextEditingController(text: _canonical(widget.value));

    late final FocusNode _focus = FocusNode()
        ..addListener(() {
            if (_focus.hasFocus) {
                return;
            }
            final parsed = _parse(_controller.text);
            if (parsed == null) {
                _rewriteText();
                return;
            }
            final commit = _clamp(parsed);
            widget.onChanged(commit);
            final text = _canonicalValue(commit);
            if (_controller.text != text) {
                _controller.text = text;
            }
        });

    static double? _parse(String text) {
        return double.tryParse(text.trim().replaceAll(',', '.'));
    }

    double _clamp(double value) {
        return value.clamp(widget.min.toDouble(), widget.max.toDouble())
            .toDouble();
    }

    String _canonical(num value) {
        final d = value.toDouble();
        if (d.truncateToDouble() == d) {
            return d.truncate().toString();
        }
        return formatWeight(d);
    }

    /// Scheduled after blur so the caller's setState lands in the same
    /// frame: widget.value is up to date when this runs.
    void _rewriteText() {
        WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!mounted || _focus.hasFocus) {
                return;
            }
            final text = _canonical(widget.value);
            if (_controller.text != text) {
                _controller.text = text;
            }
        });
    }

    /// Digits with an optional 2-decimal fraction; comma normalized to dot.
    static final TextInputFormatter _inputFormatter =
        TextInputFormatter.withFunction((oldValue, newValue) {
            final normalized = newValue.text.replaceAll(',', '.');
            if (normalized.isEmpty) {
                return newValue;
            }
            if (!RegExp(r'^\d{0,5}(\.\d{0,2})?$').hasMatch(normalized)) {
                return oldValue;
            }
            return newValue.copyWith(text: normalized);
        });

    @override
    void didUpdateWidget(covariant NumberField oldWidget) {
        super.didUpdateWidget(oldWidget);
        final text = _canonical(widget.value);
        if (!_focus.hasFocus && _controller.text != text) {
            _controller.text = text;
        }
    }

    @override
    Widget build(BuildContext context) {
        return TextField(
            key: widget.fieldKey,
            controller: _controller,
            focusNode: _focus,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [_inputFormatter],
            style: widget.textStyle,
            textAlign: widget.textAlign,
            decoration: widget.decoration,
            onChanged: (text) {
                final parsed = _parse(text);
                if (parsed != null) {
                    widget.onChanged(_clamp(parsed));
                }
            },
        );
    }

    String _canonicalValue(double value) => _canonical(value);

    @override
    void dispose() {
        _focus.dispose();
        _controller.dispose();
        super.dispose();
    }
}
