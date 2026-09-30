import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/constants/app_constants.dart';
import '../../core/utils/format_utils.dart';

/// Editable weight field flanked by incremental +/- buttons.
///
/// Typing updates the value directly through [onChanged]; external changes
/// to [weight] (steppers, suggestion pre-fill) are reflected in the text.
class WeightStepField extends StatefulWidget {
    const WeightStepField({
        required this.weight,
        required this.onChanged,
        required this.onIncrement,
        required this.onDecrement,
        super.key,
    });

    final double weight;
    final ValueChanged<double> onChanged;
    final VoidCallback onIncrement;
    final VoidCallback onDecrement;

    @override
    State<WeightStepField> createState() => _WeightStepFieldState();
}

class _WeightStepFieldState extends State<WeightStepField> {
    late final TextEditingController _controller =
        TextEditingController(text: formatWeight(widget.weight));

    /// Digits with an optional 2-decimal fraction; comma normalized to dot.
    static final TextInputFormatter _weightInputFormatter =
        TextInputFormatter.withFunction(
            (oldValue, newValue) {
                final normalized = newValue.text.replaceAll(',', '.');
                if (normalized.isEmpty) {
                    return newValue;
                }
                final valid = RegExp(r'^\d{0,4}(\.\d{0,2})?$')
                    .hasMatch(normalized);
                if (!valid) {
                    return oldValue;
                }
                return newValue.copyWith(text: normalized);
            },
        );

    void _onChanged(String text) {
        final parsed = double.tryParse(text.trim());
        if (parsed == null) {
            return;
        }
        widget.onChanged(
            parsed.clamp(
                AppConstants.minWeightKg,
                AppConstants.maxWeightKg,
            ).toDouble(),
        );
    }

    @override
    void didUpdateWidget(covariant WeightStepField oldWidget) {
        super.didUpdateWidget(oldWidget);
        final parsed = double.tryParse(_controller.text.trim());
        if (parsed == null || (parsed - widget.weight).abs() > 0.0001) {
            _controller.text = formatWeight(widget.weight);
        }
    }

    @override
    Widget build(BuildContext context) {
        final theme = Theme.of(context);
        return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                IconButton(
                    icon: const Icon(Icons.remove_circle),
                    onPressed: widget.onDecrement,
                ),
                SizedBox(
                    width: 160,
                    child: TextField(
                        key: const Key('session-weight-field'),
                        controller: _controller,
                        keyboardType:
                            const TextInputType.numberWithOptions(
                                decimal: true,
                            ),
                        inputFormatters: [_weightInputFormatter],
                        textAlign: TextAlign.center,
                        style: theme.textTheme.headlineMedium,
                        onChanged: _onChanged,
                    ),
                ),
                IconButton(
                    icon: const Icon(Icons.add_circle),
                    onPressed: widget.onIncrement,
                ),
            ],
        );
    }

    @override
    void dispose() {
        _controller.dispose();
        super.dispose();
    }
}
