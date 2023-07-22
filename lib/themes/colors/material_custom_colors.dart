import 'package:flip/themes/colors/custom_colors.dart';
import 'package:flutter/material.dart';

class CustomMaterialColor {
  static const Map<int, Color> orangeSwatch = {
    50: Color.fromRGBO(250, 100, 66, .1),
    100: Color.fromRGBO(250, 100, 66, .2),
    200: Color.fromRGBO(250, 100, 66, .3),
    300: Color.fromRGBO(250, 100, 66, .4),
    400: Color.fromRGBO(250, 100, 66, .5),
    500: Color.fromRGBO(250, 100, 66, .6),
    600: Color.fromRGBO(250, 100, 66, .7),
    700: Color.fromRGBO(250, 100, 66, .8),
    800: Color.fromRGBO(250, 100, 66, .9),
    900: Color.fromRGBO(250, 100, 66, 1.0),
  };

  static const Map<int, Color> blueSwatch = {
    50: Color.fromRGBO(85, 135, 205, .1),
    100: Color.fromRGBO(85, 135, 205, .2),
    200: Color.fromRGBO(85, 135, 205, .3),
    300: Color.fromRGBO(85, 135, 205, .4),
    400: Color.fromRGBO(85, 135, 205, .5),
    500: Color.fromRGBO(85, 135, 205, .6),
    600: Color.fromRGBO(85, 135, 205, .7),
    700: Color.fromRGBO(85, 135, 205, .8),
    800: Color.fromRGBO(85, 135, 205, .9),
    900: Color.fromRGBO(11, 65, 141, 1.0),
  };

  static MaterialColor blue =
      MaterialColor(CustomColor.bluePlus2.value, blueSwatch);
  static MaterialColor orange =
      MaterialColor(CustomColor.flipOrange.value, orangeSwatch);
}
