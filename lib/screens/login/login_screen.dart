import 'package:flip/themes/text/custom_text_style.dart';
import 'package:flip/utils/l10n/localizations.dart';
import 'package:flip/widgets/appbar/appbar.dart';
import 'package:flutter/material.dart';

import 'widget/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: const OnboardingAppBar(),
          body: Container(
            margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 42),
                    Text(
                      getText(context)!.loginScreenTitle,
                      style: CustomTextStyle.headlineLarge(context),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      getText(context)!.loginScreenSubtitle,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
                const Expanded(
                  child: LoginForm(),
                )
              ],
            ),
          )),
    );
  }
}
