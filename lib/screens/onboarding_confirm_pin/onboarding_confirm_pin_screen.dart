import 'package:flip/constants/navigation.dart';
import 'package:flip/utils/l10n/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../blocs/user/user_bloc.dart';
import '../../widgets/pin/pin_form.dart';

class OnBoardingConfirmPinScreen extends StatefulWidget {
  const OnBoardingConfirmPinScreen({super.key, this.previousPin = ''});

  final String? previousPin;

  @override
  State<OnBoardingConfirmPinScreen> createState() =>
      _OnBoardingConfirmPinScreenState();
}

class _OnBoardingConfirmPinScreenState
    extends State<OnBoardingConfirmPinScreen> {
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text(getText(context)!.confirmPinTitle),
          ),
          body: Container(
            margin: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 42),
                    Text(getText(context)!.confirmPinSubtitle),
                    const SizedBox(height: 32),
                  ],
                ),
                Expanded(
                    child: PinForm(
                  onComplete: (String pin) => onPinComplete(context, pin),
                  onButtonPressed: (String pin) =>
                      onButtonPinPressed(context, pin),
                  errorMessage: _errorMessage,
                ))
              ],
            ),
          )),
    );
  }

  void onPinComplete(BuildContext context, String pin) {
    // TODO handle pin complete
  }

  void onButtonPinPressed(BuildContext context, String pin) {
    if (widget.previousPin == pin) {
      handleValidPin(context, pin);
    } else {
      setState(() {
        _errorMessage = getText(context)!.confirmPinDifferentError;
      });
    }
  }

  void handleValidPin(BuildContext context, String pin) {
    context.read<UserBloc>().add(UserUpdatePIN(int.parse(pin)));
    context.go('${NavigationRouteName.home}?pin=$pin');
  }
}
