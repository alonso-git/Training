import 'package:flutter/material.dart';

import 'number_field.dart';

/// Weight entry flanked by incremental +/- buttons.
///
/// The text portion is a [NumberField]: typing updates the value directly;
/// external changes to [weight] (steppers, suggestion pre-fill) are
/// reflected while the field is not focused.
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
                    child: NumberField(
                        value: widget.weight,
                        min: 0,
                        max: 1000,
                        onChanged: widget.onChanged,
                        fieldKey: const Key('session-weight-field'),
                        textStyle: theme.textTheme.headlineMedium,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                        ),
                    ),
                ),
                IconButton(
                    icon: const Icon(Icons.add_circle),
                    onPressed: widget.onIncrement,
                ),
            ],
        );
    }
}
