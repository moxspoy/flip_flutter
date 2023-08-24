import 'package:flip/blocs/user/user_bloc.dart';
import 'package:flip/utils/l10n/localizations.dart';
import 'package:flip/widgets/keyboard/custom_keyboard.dart';
import 'package:flip/widgets/pin/pin_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../button/button.dart';
import '../text/text.dart';

class PinForm extends StatefulWidget {
  const PinForm(
      {super.key,
      this.onComplete,
      this.onButtonPressed,
      this.errorMessage = ''});

  final void Function(String pin)? onComplete;
  final void Function(String pin)? onButtonPressed;
  final String errorMessage;

  @override
  State<PinForm> createState() => _PinFormState();
}

class _PinFormState extends State<PinForm> {
  String _pin = '';

  @override
  initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      return Column(
        children: [
          PinView(
            pin: _pin,
          ),
          const SizedBox(
            height: 8,
          ),
          widget.errorMessage.length > 1
              ? ErrorText(widget.errorMessage)
              : Container(),
          const Expanded(child: SizedBox()),
          CustomButton(
            onPressed: onButtonPressed,
            text: getText(context)!.continueButton,
          ),
          const SizedBox(
            height: 24,
          ),
          CustomKeyboard(
            onPressKey: onPressKeyBoard,
          ),
        ],
      );
    });
  }

  void onPressKeyBoard(String key) {
    String newPin = _pin;
    if (key == CustomKeyboard.noneKey) {
      return;
    }
    if (key == CustomKeyboard.deleteKey) {
      debugPrint(_pin);
      if (_pin.isNotEmpty) {
        newPin = _pin.substring(0, _pin.length - 1);
        setState(() {
          _pin = newPin;
        });
        return;
      }
      return;
    }
    if (_pin.length < 6) {
      newPin = '$_pin$key';
    }
    setState(() {
      _pin = newPin;
    });
    if (newPin.length == 6 && widget.onComplete != null) {
      widget.onComplete!(newPin);
    }
  }

  void onButtonPressed() {
    if (_pin.isEmpty) {
      return;
    }
    if (_pin.length < 6) {
      return;
    }

    widget.onButtonPressed!(_pin);
  }
}
