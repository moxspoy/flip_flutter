import 'package:flutter/material.dart';

class CustomTextStyle {
  static TextStyle? sliderTitle(BuildContext context) {
    TextTheme existingTextTheme = Theme.of(context).textTheme;

    return existingTextTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900);
  }
}
