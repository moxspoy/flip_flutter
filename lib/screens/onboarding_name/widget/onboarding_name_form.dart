import 'package:flip/constants/navigation.dart';
import 'package:flip/utils/l10n/localizations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../widgets/button/button.dart';

class OnboardingNameForm extends StatefulWidget {
  const OnboardingNameForm({super.key});

  @override
  State<OnboardingNameForm> createState() => _OnboardingNameFormState();
}

class _OnboardingNameFormState extends State<OnboardingNameForm> {
  String _name = '';
  bool _isButtonLoading = false;

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
    return Column(
      children: [
        SizedBox(
          height: 180,
          child: TextField(
            onChanged: (value) {
              setState(() {
                _name = value;
              });
            },
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: getText(context)!.signUpNameHint,
            ),
          ),
        ),
        const Expanded(child: SizedBox()),
        CustomButton(
          onPressed: onButtonPressed,
          isLoading: _isButtonLoading,
          text: getText(context)!.continueButton,
        ),
      ],
    );
  }

  void onButtonPressed() {
    if (_name.isEmpty) {
      return;
    }
    if (_name.length < 3) {
      return;
    }
    setState(() {
      _isButtonLoading = true;
    });

    // TODO request to API
    Future.delayed(const Duration(seconds: 2)).then((value) {
      context.go(NavigationRouteName.home);
    });
  }
}
