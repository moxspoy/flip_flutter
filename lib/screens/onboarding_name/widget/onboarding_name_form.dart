import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flip/constants/navigation.dart';
import 'package:flip/utils/l10n/localizations.dart';
import 'package:flip/utils/validation/validation.dart';
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
    String validationMessage = validateMobile(_name);
    if (validationMessage.isEmpty) {
      setState(() {
        _isButtonLoading = true;
      });
      Future.delayed(const Duration(milliseconds: 2000), () {
        setState(() {
          _isButtonLoading = false;
        });
        context.push('${NavigationRouteName.otp}?phoneNumber=$_name');
      });
      return;
    }
    SnackBar snackBar = SnackBar(
      content: Text(
        validationMessage,
        style: AdaptiveTheme.of(context).theme.textTheme.bodyMedium,
      ),
      backgroundColor: AdaptiveTheme.of(context).theme.colorScheme.background,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
