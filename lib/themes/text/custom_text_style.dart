import 'package:flutter/material.dart';

class CustomTextStyle {
  static TextStyle? sliderTitle(BuildContext context) {
    TextTheme existingTextTheme = Theme.of(context).textTheme;

    return existingTextTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700);
  }

  static TextStyle? headlineLarge(BuildContext context) {
    TextTheme existingTextTheme = Theme.of(context).textTheme;

    return existingTextTheme.headlineLarge
        ?.copyWith(fontWeight: FontWeight.w700);
  }
}
