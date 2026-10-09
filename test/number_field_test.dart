import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:my_app/presentation/widgets/number_field.dart';

void main() {
    testWidgets('changing text calls onChanged with clamped value',
        (tester) async {
        final changed = <double>[];
        await tester.pumpWidget(wrap(
            NumberField(
                value: 8,
                min: 1,
                max: 50,
                onChanged: changed.add,
            ),
        ));
        await tester.enterText(find.byType(TextField), '12');
        expect(changed, [12.0]);
        expect(find.text('12'), findsOneWidget);
    });

    testWidgets('does NOT rewrite text while focused (no cursor jumps)',
        (tester) async {
        final changed = <double>[];
        var value = 8.0;
        late StateSetter setter;
        await tester.pumpWidget(
            MaterialApp(
                home: Scaffold(
                    body: StatefulBuilder(
                        builder: (context, s) {
                            setter = s;
                            return NumberField(
                                value: value,
                                min: 1,
                                max: 50,
                                onChanged: (v) {
                                    changed.add(v);
                                },
                            );
                        },
                    ),
                ),
            ),
        );
        final field = find.byType(TextField);
        await tester.tap(field);
        await tester.pump();
        // User deletes "8" and types "2." — mid-edit the canonical value
        // would be 2.0; the field must keep "2." under the cursor.
        await tester.enterText(field, '2.');
        setter(() => value = 2.0);
        await tester.pump();
        expect(find.text('2.'), findsOneWidget);
        expect(find.text('2.0'), findsNothing);
    });

    testWidgets('canonicalizes text on blur', (tester) async {
        final changed = <double>[];
        await tester.pumpWidget(wrap(
            NumberField(
                value: 8.0,
                min: 1,
                max: 50,
                onChanged: changed.add,
            ),
        ));
        final field = find.byType(TextField);
        await tester.tap(field);
        await tester.pump();
        await tester.enterText(field, '8.');
        changed.clear();
        // Explicit unfocus (simulates tapping outside the dialog field).
        await tester.tap(find.byKey(const Key('unfocus-button')));
        await tester.pump();
        await tester.pump();
        expect(find.text('8'), findsOneWidget);
        expect(find.text('8.'), findsNothing);
    });

    testWidgets('clamps values above max', (tester) async {
        final changed = <double>[];
        await tester.pumpWidget(wrap(
            NumberField(
                value: 8,
                min: 1,
                max: 50,
                onChanged: changed.add,
            ),
        ));
        await tester.enterText(find.byType(TextField), '500');
        expect(changed.single, 50.0);
    });
}

Widget wrap(NumberField child) {
    return MaterialApp(
        home: Scaffold(
            body: Builder(
                builder: (context) {
                    return Column(
                        children: [
                            child,
                            FilledButton(
                                key: const Key('unfocus-button'),
                                onPressed: () {
                                    FocusScope.of(context).unfocus();
                                },
                                child: const Text('unfocus'),
                            ),
                        ],
                    );
                },
            ),
        ),
    );
}
