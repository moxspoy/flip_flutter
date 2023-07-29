import 'package:flip/themes/text/custom_text_style.dart';
import 'package:flip/utils/l10n/localizations.dart';
import 'package:flip/widgets/appbar/appbar.dart';
import 'package:flip/widgets/button/button.dart';
import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({
    required this.phoneNumber,
    Key? key,
  }) : super(key: key);

  final String phoneNumber;

  @override
  State<OtpScreen> createState() => _OtpState();
}

class _OtpState extends State<OtpScreen> {
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
                      getText(context)!.otpScreenTitle,
                      style: CustomTextStyle.headlineLarge(context),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      getText(context)!.otpScreenSubtitle,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      widget.phoneNumber,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
                Expanded(
                  child: Container(),
                ),
                CustomButton(
                    onPressed: () {}, child: Text(getText(context)!.otpButton)),
                const SizedBox(
                  height: 24,
                )
              ],
            ),
          )),
    );
  }
}
