import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Swatch {
  static final MaterialColor green = createMaterialColor(Color.fromRGBO(16, 150, 72,1));
  static final MaterialColor red = createMaterialColor(Color.fromRGBO(239, 91, 91, 1));
  static final MaterialColor light_blue = createMaterialColor(Color.fromRGBO(27, 152, 224, 1));
  static final MaterialColor dark_blue = createMaterialColor(Color.fromRGBO(8, 65, 92, 1));
  static final MaterialColor egg_shell = createMaterialColor(Color.fromRGBO(240, 234, 214, 1));
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}

Map<int, Color> toMaterial(int r, int g, int b) {
  return {
    50: Color.fromRGBO(r, g, b, .1),
    100: Color.fromRGBO(r, g, b, .2),
    200: Color.fromRGBO(r, g, b, .3),
    300: Color.fromRGBO(r, g, b, .4),
    400: Color.fromRGBO(r, g, b, .5),
    500: Color.fromRGBO(r, g, b, .6),
    600: Color.fromRGBO(r, g, b, .7),
    700: Color.fromRGBO(r, g, b, .8),
    800: Color.fromRGBO(r, g, b, .9),
    900: Color.fromRGBO(r, g, b, 1),
  };
}
