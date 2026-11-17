import 'package:material_ui/material_ui.dart';

/// The seed colour, a raw umber. Used with the neutral scheme variant, so
/// the chrome is warm greys and the only saturated colour is the artworks'.
const Color _seed = Color(0xFF6A6238);

final ThemeData appTheme = _themeFor(Brightness.light);
final ThemeData appThemeDark = _themeFor(Brightness.dark);

ThemeData _themeFor(Brightness brightness) {
  final scheme = ColorScheme.fromSeed(
    seedColor: _seed,
    brightness: brightness,
    dynamicSchemeVariant: DynamicSchemeVariant.neutral,
  );

  final fields = InputDecorationTheme(
    filled: true,
    fillColor: scheme.surfaceContainerHigh,
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 16.0,
      vertical: 16.0,
    ),
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      borderSide: BorderSide.none,
    ),
    // The fill alone would leave a keyboard user guessing where focus is.
    focusedBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(12.0)),
      borderSide: BorderSide(color: scheme.primary, width: 2.0),
    ),
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    fontFamily: 'Spectral',
    textTheme: textTheme,
    scaffoldBackgroundColor: scheme.surface,
    cardTheme: const CardThemeData(elevation: 0.0),
    dialogTheme: DialogThemeData(
      elevation: 0.0,
      backgroundColor: scheme.surfaceContainerLow,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
    ),
    inputDecorationTheme: fields,
    // A DropdownMenu does not read the theme above, so it is given the
    // same field style.
    dropdownMenuTheme: DropdownMenuThemeData(inputDecorationTheme: fields),
    chipTheme: const ChipThemeData(
      elevation: 0.0,
      pressElevation: 0.0,
      showCheckmark: false,
    ),
  );
}

/// The Material 3 type scale, set in Spectral. The two emphasised titles
/// use 600, the heaviest weight bundled.
const textTheme = TextTheme(
  displayLarge: TextStyle(fontSize: 57, height: 64 / 57),
  displayMedium: TextStyle(fontSize: 45, height: 52 / 45),
  displaySmall: TextStyle(fontSize: 36, height: 44 / 36),
  headlineLarge: TextStyle(fontSize: 32, height: 40 / 32),
  headlineMedium: TextStyle(fontSize: 28, height: 36 / 28),
  headlineSmall: TextStyle(fontSize: 24, height: 32 / 24),
  titleLarge: TextStyle(fontSize: 22, height: 28 / 22),
  titleMedium: TextStyle(
    fontSize: 16,
    height: 24 / 16,
    letterSpacing: 0.1,
    fontWeight: FontWeight.w600,
  ),
  titleSmall: TextStyle(
    fontSize: 14,
    height: 20 / 14,
    letterSpacing: 0.1,
    fontWeight: FontWeight.w600,
  ),
  labelLarge: TextStyle(fontSize: 14, height: 20 / 14, letterSpacing: 0.1),
  labelMedium: TextStyle(fontSize: 12, height: 16 / 12, letterSpacing: 0.5),
  labelSmall: TextStyle(fontSize: 11, height: 16 / 11, letterSpacing: 0.5),
  bodyLarge: TextStyle(fontSize: 16, height: 24 / 16),
  bodyMedium: TextStyle(fontSize: 14, height: 20 / 14),
  bodySmall: TextStyle(fontSize: 12, height: 16 / 12),
);
