import 'package:flutter/material.dart';

class AppTheme {
    static ThemeData light() {
        final base = ThemeData(
            useMaterial3: true,
            brightness: Brightness.light,
            colorSchemeSeed: Colors.deepOrange,
        );
        return base.copyWith(
            cardTheme: _cardTheme(base.cardTheme, base.colorScheme),
            inputDecorationTheme: _inputTheme(base.colorScheme),
        );
    }

    static ThemeData dark() {
        final base = ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            colorSchemeSeed: Colors.deepOrange,
        );
        return base.copyWith(
            cardTheme: _cardTheme(base.cardTheme, base.colorScheme),
            inputDecorationTheme: _inputTheme(base.colorScheme),
        );
    }

    static CardThemeData _cardTheme(
        CardThemeData fallback,
        ColorScheme scheme,
    ) {
        return fallback.copyWith(
            elevation: 1,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
            ),
            clipBehavior: Clip.antiAlias,
        );
    }

    static InputDecorationTheme _inputTheme(ColorScheme scheme) {
        return const InputDecorationTheme(
            border: OutlineInputBorder(),
            isDense: true,
        );
    }
}
