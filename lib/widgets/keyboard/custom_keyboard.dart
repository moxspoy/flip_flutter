import 'package:flip/themes/text/custom_text_style.dart';
import 'package:flutter/material.dart';

class CustomKeyboard extends StatelessWidget {
  const CustomKeyboard({super.key, this.onPressKey});

  final void Function(String key)? onPressKey;

  static const String deleteKey = 'DEL';
  static const String noneKey = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(child: PressableItem(value: '1', onPress: onPressKey)),
            Expanded(child: PressableItem(value: '2', onPress: onPressKey)),
            Expanded(child: PressableItem(value: '3', onPress: onPressKey)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(child: PressableItem(value: '4', onPress: onPressKey)),
            Expanded(child: PressableItem(value: '5', onPress: onPressKey)),
            Expanded(child: PressableItem(value: '6', onPress: onPressKey)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(child: PressableItem(value: '7', onPress: onPressKey)),
            Expanded(child: PressableItem(value: '8', onPress: onPressKey)),
            Expanded(child: PressableItem(value: '9', onPress: onPressKey)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(child: PressableItem(value: noneKey, onPress: onPressKey)),
            Expanded(child: PressableItem(value: '0', onPress: onPressKey)),
            Expanded(
                child: PressableItem(value: deleteKey, onPress: onPressKey)),
          ],
        ),
      ],
    );
  }
}

class PressableItem extends StatelessWidget {
  const PressableItem({super.key, this.value = '', this.onPress});

  final String value;
  final void Function(String key)? onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPress!(value),
      child: Container(
        color: Colors.transparent,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 24, bottom: 24),
            child: value == CustomKeyboard.deleteKey
                ? const Icon(Icons.backspace_outlined)
                : Text(
                    value,
                    style: CustomTextStyle.pinText(context),
                  ),
          ),
        ),
      ),
    );
  }
}
