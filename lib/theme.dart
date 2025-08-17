import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color.fromARGB(255, 226, 127, 73),
      surfaceTint: Color.fromARGB(255, 218, 109, 50),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffcd4800),
      onPrimaryContainer: Color(0xfffffbff),
      secondary: Color(0xff994624),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xfffe956c),
      onSecondaryContainer: Color(0xff762c0b),
      tertiary: Color(0xff71594e),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffa78c7f),
      onTertiaryContainer: Color(0xff39261d),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfffff8f6),
      onSurface: Color(0xff261813),
      onSurfaceVariant: Color(0xff5a4138),
      outline: Color.fromARGB(255, 82, 79, 79),
      outlineVariant: Color(0xffe3bfb2),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff3d2d27),
      inversePrimary: Color(0xffffb59a),
      primaryFixed: Color(0xffffdbce),
      onPrimaryFixed: Color(0xff370e00),
      primaryFixedDim: Color(0xffffb59a),
      onPrimaryFixedVariant: Color(0xff802a00),
      secondaryFixed: Color(0xffffdbce),
      onSecondaryFixed: Color(0xff370e00),
      secondaryFixedDim: Color(0xffffb59a),
      onSecondaryFixedVariant: Color(0xff7a2f0e),
      tertiaryFixed: Color(0xfffcdccd),
      onTertiaryFixed: Color(0xff28180f),
      tertiaryFixedDim: Color(0xffdfc0b2),
      onTertiaryFixedVariant: Color(0xff574237),
      surfaceDim: Color(0xffefd4cb),
      surfaceBright: Color(0xfffff8f6),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff1ec),
      surfaceContainer: Color(0xffffe9e2),
      surfaceContainerHigh: Color(0xfffee2d9),
      surfaceContainerHighest: Color(0xfff8ddd3),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff641f00),
      surfaceTint: Color(0xffa73a00),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffc04300),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff641f00),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffab5431),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff453228),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff80685c),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff8f6),
      onSurface: Color(0xff1b0e09),
      onSurfaceVariant: Color(0xff483128),
      outline: Color(0xff674c43),
      outlineVariant: Color(0xff84675c),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff3d2d27),
      inversePrimary: Color(0xffffb59a),
      primaryFixed: Color(0xffef5806),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff973300),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xffab5431),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff8c3d1b),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff80685c),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff665045),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffdbc1b8),
      surfaceBright: Color(0xfffff8f6),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff1ec),
      surfaceContainer: Color(0xfffee2d9),
      surfaceContainerHigh: Color(0xfff2d7ce),
      surfaceContainerHighest: Color(0xffe7ccc3),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff531900),
      surfaceTint: Color(0xffa73a00),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff842c00),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff531900),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff7d3211),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff3a281e),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff5a453a),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff8f6),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff3d271f),
      outlineVariant: Color(0xff5d433a),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff3d2d27),
      inversePrimary: Color(0xffffb59a),
      primaryFixed: Color(0xff842c00),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff5e1d00),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff7d3211),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff5e1d00),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff5a453a),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff422e24),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffcdb3ab),
      surfaceBright: Color(0xfffff8f6),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffffede7),
      surfaceContainer: Color(0xfff8ddd3),
      surfaceContainerHigh: Color(0xffeacfc6),
      surfaceContainerHighest: Color(0xffdbc1b8),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffb59a),
      surfaceTint: Color(0xffffb59a),
      onPrimary: Color(0xff5a1b00),
      primaryContainer: Color(0xfff85f15),
      onPrimaryContainer: Color(0xff481400),
      secondary: Color(0xffffb59a),
      onSecondary: Color(0xff5a1b00),
      secondaryContainer: Color(0xff7a2f0e),
      onSecondaryContainer: Color(0xffff9c75),
      tertiary: Color(0xffdfc0b2),
      onTertiary: Color(0xff3f2c22),
      tertiaryContainer: Color(0xffa78c7f),
      onTertiaryContainer: Color(0xff39261d),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff1d100b),
      onSurface: Color(0xfff8ddd3),
      onSurfaceVariant: Color(0xffe3bfb2),
      outline: Color(0xffaa8a7e),
      outlineVariant: Color(0xff5a4138),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfff8ddd3),
      inversePrimary: Color(0xffa73a00),
      primaryFixed: Color(0xffffdbce),
      onPrimaryFixed: Color(0xff370e00),
      primaryFixedDim: Color(0xffffb59a),
      onPrimaryFixedVariant: Color(0xff802a00),
      secondaryFixed: Color(0xffffdbce),
      onSecondaryFixed: Color(0xff370e00),
      secondaryFixedDim: Color(0xffffb59a),
      onSecondaryFixedVariant: Color(0xff7a2f0e),
      tertiaryFixed: Color(0xfffcdccd),
      onTertiaryFixed: Color(0xff28180f),
      tertiaryFixedDim: Color(0xffdfc0b2),
      onTertiaryFixedVariant: Color(0xff574237),
      surfaceDim: Color(0xff1d100b),
      surfaceBright: Color(0xff47352f),
      surfaceContainerLowest: Color(0xff180b07),
      surfaceContainerLow: Color(0xff261813),
      surfaceContainer: Color(0xff2b1c17),
      surfaceContainerHigh: Color(0xff362621),
      surfaceContainerHighest: Color(0xff42312b),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffd3c3),
      surfaceTint: Color(0xffffb59a),
      onPrimary: Color(0xff481400),
      primaryContainer: Color(0xffef4806),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffffd3c3),
      onSecondary: Color(0xff481400),
      secondaryContainer: Color(0xffd77650),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfff5d6c7),
      onTertiary: Color(0xff332218),
      tertiaryContainer: Color(0xffa78c7f),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff1d100b),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xfffad4c7),
      outline: Color(0xffcdaa9e),
      outlineVariant: Color(0xffa9897e),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfff8ddd3),
      inversePrimary: Color(0xff822b00),
      primaryFixed: Color(0xffffdbce),
      onPrimaryFixed: Color(0xff260700),
      primaryFixedDim: Color(0xffffb59a),
      onPrimaryFixedVariant: Color(0xff641f00),
      secondaryFixed: Color(0xffffdbce),
      onSecondaryFixed: Color(0xff260700),
      secondaryFixedDim: Color(0xffffb59a),
      onSecondaryFixedVariant: Color(0xff641f00),
      tertiaryFixed: Color(0xfffcdccd),
      onTertiaryFixed: Color(0xff1c0d06),
      tertiaryFixedDim: Color(0xffdfc0b2),
      onTertiaryFixedVariant: Color(0xff453228),
      surfaceDim: Color(0xff1d100b),
      surfaceBright: Color(0xff53403a),
      surfaceContainerLowest: Color(0xff100503),
      surfaceContainerLow: Color(0xff291a15),
      surfaceContainer: Color(0xff34241f),
      surfaceContainerHigh: Color(0xff3f2f29),
      surfaceContainerHighest: Color(0xff4b3a33),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffece6),
      surfaceTint: Color(0xffffb59a),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffffb092),
      onPrimaryContainer: Color(0xff1c0400),
      secondary: Color(0xffffece6),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffffb092),
      onSecondaryContainer: Color(0xff1c0400),
      tertiary: Color(0xffffece4),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffdbbcae),
      onTertiaryContainer: Color(0xff150803),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff1d100b),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffffece6),
      outlineVariant: Color(0xffdfbbaf),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfff8ddd3),
      inversePrimary: Color(0xff822b00),
      primaryFixed: Color(0xffffdbce),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffffb59a),
      onPrimaryFixedVariant: Color(0xff260700),
      secondaryFixed: Color(0xffffdbce),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffffb59a),
      onSecondaryFixedVariant: Color(0xff260700),
      tertiaryFixed: Color(0xfffcdccd),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffdfc0b2),
      onTertiaryFixedVariant: Color(0xff1c0d06),
      surfaceDim: Color(0xff1d100b),
      surfaceBright: Color(0xff5f4c45),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff2b1c17),
      surfaceContainer: Color(0xff3d2d27),
      surfaceContainerHigh: Color(0xff493731),
      surfaceContainerHighest: Color(0xff55433c),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    textTheme: textTheme.apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    ),
    scaffoldBackgroundColor: colorScheme.surface,
    canvasColor: colorScheme.surface,
  );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
