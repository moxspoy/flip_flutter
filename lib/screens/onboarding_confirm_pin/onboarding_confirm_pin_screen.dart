import 'package:flip/constants/navigation.dart';
import 'package:flip/utils/l10n/localizations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/pin/pin_form.dart';

class OnBoardingConfirmPinScreen extends StatelessWidget {
  const OnBoardingConfirmPinScreen({super.key, this.previousPin = ''});

  final String? previousPin;

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
    // TODO request to API
    context.go('${NavigationRouteName.home}?pin=$pin');
  }
}
