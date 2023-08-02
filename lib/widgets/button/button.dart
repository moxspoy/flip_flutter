import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    this.child,
    this.isLoading = false,
    this.isDisabled = false,
    this.text = '',
    this.customStyle,
  });

  final VoidCallback? onPressed;
  final Widget? child;
  final bool? isLoading;
  final bool? isDisabled;
  final ButtonStyle? customStyle;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: customStyle ??
          ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
      child: isLoading == true
          ? const SizedBox(
              height: 16,
              width: 16,
              child: Center(
                  child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 1.5,
              )))
          : child ?? (text != '' ? Text(text!) : child),
    );
  }
}
