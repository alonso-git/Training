import 'package:flutter/material.dart';

class AppTheme {
    /// Volt green - the app-wide accent.
    static const Color _accent = Color(0xFFC6FF00);

    /// Darker companion for containers/ink on light backgrounds.
    static const Color _accentDeep = Color(0xFF9CCC00);

    static ThemeData light() {
        final base = ThemeData(
            useMaterial3: true,
            brightness: Brightness.light,
            colorSchemeSeed: _accentDeep,
        );
        return _applyWidgetStyle(
            base.copyWith(
                cardTheme: _cardTheme(base.cardTheme, base.colorScheme),
                inputDecorationTheme: _inputTheme(base.colorScheme),
            ),
            base.colorScheme,
        );
    }

    /// [amoled] forces an all-black palette: pure #000000 backgrounds,
    /// hairline borders and lifted accent surfaces (no elevation glow).
    static ThemeData dark({bool amoled = false}) {
        final seed = ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            colorSchemeSeed: _accent,
        );
        var scheme = seed.colorScheme.copyWith(
            primary: _accent,
            onPrimary: Colors.black,
            primaryContainer: const Color(0xFF3A4A00),
            onPrimaryContainer: const Color(0xFFE9FF7A),
            secondary: const Color(0xFFAEEA00),
            onSecondary: Colors.black,
            tertiary: const Color(0xFF69F0AE),
            onTertiary: Colors.black,
        );

        late final ColorScheme adjusted;
        if (amoled) {
            adjusted = scheme.copyWith(
                surface: Colors.black,
                surfaceContainerLowest: Colors.black,
                surfaceContainerLow: const Color(0xFF0A0A0A),
                surfaceContainer: const Color(0xFF0F0F0F),
                surfaceContainerHigh: const Color(0xFF141414),
                surfaceContainerHighest: const Color(0xFF1C1C1C),
                surfaceTint: Colors.transparent,
                onSurface: Colors.white,
                onSurfaceVariant: const Color(0xFFB8B8B8),
                outline: const Color(0xFF2C2C2C),
                outlineVariant: const Color(0xFF1F1F1F),
            );
        } else {
            adjusted = scheme;
        }

        final base = seed.copyWith(colorScheme: adjusted);
        final themed = base.copyWith(
            scaffoldBackgroundColor: amoled ? Colors.black : null,
            canvasColor: amoled ? Colors.black : null,
            dialogTheme: DialogThemeData(
                backgroundColor:
                    amoled ? const Color(0xFF141414) : null,
            ),
            navigationBarTheme: NavigationBarThemeData(
                backgroundColor: amoled ? Colors.black : null,
                indicatorColor:
                    amoled ? scheme.primaryContainer : null,
            ),
            appBarTheme: AppBarTheme(
                backgroundColor:
                    amoled ? Colors.black : null,
                elevation: 0,
                scrolledUnderElevation: 0,
            ),
            cardTheme: _cardTheme(base.cardTheme, adjusted),
            inputDecorationTheme: _inputTheme(adjusted),
            dividerTheme: DividerThemeData(
                color: adjusted.outlineVariant,
                thickness: 1,
            ),
            chipTheme: _chipTheme(adjusted),
        );
        return _applyWidgetStyle(themed, adjusted);
    }

    /// Widget-like visual language: rounded tiles with hairline borders on
    /// the dark surface, used whenever floating content shows up.
    static ThemeData _applyWidgetStyle(ThemeData theme, ColorScheme scheme) {
        return theme.copyWith(
            cardTheme: theme.cardTheme.copyWith(
                elevation: 0,
                color: theme.brightness == Brightness.dark
                    ? (scheme.surfaceContainerHigh)
                    : scheme.surfaceContainerLowest,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(color: scheme.outlineVariant),
                ),
                clipBehavior: Clip.antiAlias,
                margin: EdgeInsets.zero,
            ),
            inputDecorationTheme: theme.inputDecorationTheme.copyWith(
                filled: true,
                fillColor: theme.brightness == Brightness.dark
                    ? scheme.surfaceContainerHigh
                    : scheme.surfaceContainerLowest,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: scheme.outlineVariant),
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: scheme.outlineVariant),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: scheme.primary, width: 1.5),
                ),
            ),
            filledButtonTheme: FilledButtonThemeData(
                style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                    ),
                ),
            ),
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

    static ChipThemeData _chipTheme(ColorScheme scheme) {
        return ChipThemeData(
            backgroundColor: scheme.surfaceContainerHigh,
            selectedColor: scheme.primaryContainer,
            side: BorderSide(color: scheme.outlineVariant),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
            ),
        );
    }
}
