import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:my_app/presentation/widgets/weight_step_field.dart';

void main() {

    Widget wrap(WeightStepField field) {
        return MaterialApp(
            home: Scaffold(body: Center(child: field)),
        );
    }

    testWidgets('editing text calls onChanged with parsed weight',
        (tester) async {
        final changed = <double>[];
        await tester.pumpWidget(wrap(
            WeightStepField(
                weight: 60.0,
                onChanged: changed.add,
                onIncrement: () {},
                onDecrement: () {},
            ),
        ));
        await tester.enterText(
            find.byKey(const Key('session-weight-field')),
            '90',
        );
        expect(changed, [90.0]);
    });

    testWidgets('clamps out-of-range input to bounds', (tester) async {
        final changed = <double>[];
        await tester.pumpWidget(wrap(
            WeightStepField(
                weight: 60.0,
                onChanged: changed.add,
                onIncrement: () {},
                onDecrement: () {},
            ),
        ));
        await tester.enterText(
            find.byKey(const Key('session-weight-field')),
            '5000',
        );
        expect(changed.last, 1000.0);
        changed.clear();
        await tester.enterText(
            find.byKey(const Key('session-weight-field')),
            '-5',
        );
        // '-5' is rejected by the input formatter, so no change occurs.
        expect(changed, isEmpty);
    });

    testWidgets('external value updates text (stepper reflect)',
        (tester) async {
        var external = 60.0;
        late StateSetter setState;
        await tester.pumpWidget(
            MaterialApp(
                home: Scaffold(
                    body: StatefulBuilder(
                        builder: (context, setter) {
                            setState = setter;
                            return WeightStepField(
                                weight: external,
                                onChanged: (v) => external = v,
                                onIncrement: () {},
                                onDecrement: () {},
                            );
                        },
                    ),
                ),
            ),
        );
        expect(find.text('60'), findsOneWidget);
        setState(() => external = 62.5);
        await tester.pump();
        expect(find.text('62.5'), findsOneWidget);
    });

}
