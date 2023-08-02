import 'package:flip/themes/text/custom_text_style.dart';
import 'package:flutter/material.dart';

class HeadlineText extends StatelessWidget {
  const HeadlineText(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: CustomTextStyle.headlineLarge(context));
  }
}

class ErrorText extends StatelessWidget {
  const ErrorText(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: CustomTextStyle.errorText(context));
  }
}
