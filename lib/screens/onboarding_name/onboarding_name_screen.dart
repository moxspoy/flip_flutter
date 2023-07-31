import 'package:flip/utils/l10n/localizations.dart';
import 'package:flip/widgets/text/text.dart';
import 'package:flutter/material.dart';

import 'widget/onboarding_name_form.dart';

class OnBoardingNameScreen extends StatelessWidget {
  const OnBoardingNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: AppBar(),
          body: Container(
            margin: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 42),
                    HeadlineText(getText(context)!.signUpNameTitle),
                    const SizedBox(height: 12),
                    Text(
                      getText(context)!.signUpNameSubTitle,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
                const Expanded(
                  child: OnboardingNameForm(),
                )
              ],
            ),
          )),
    );
  }
}
