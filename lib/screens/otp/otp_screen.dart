import 'package:flip/constants/navigation.dart';
import 'package:flip/utils/l10n/localizations.dart';
import 'package:flip/widgets/appbar/appbar.dart';
import 'package:flip/widgets/button/button.dart';
import 'package:flip/widgets/text/text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
  String _otp = '';
  bool _isLoading = false;

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
                    HeadlineText(
                      getText(context)!.otpScreenTitle,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '${getText(context)!.otpScreenSubtitle} ${widget.phoneNumber}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 32),
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          _otp = value;
                        });
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'OTP',
                      ),
                      keyboardType: TextInputType.number,
                      autofocus: true,
                      maxLength: 6,
                    )
                  ],
                ),
                Expanded(
                  child: Container(),
                ),
                CustomButton(
                    onPressed: onButtonPressed,
                    isLoading: _isLoading,
                    child: Text(getText(context)!.otpButton)),
                const SizedBox(
                  height: 24,
                ),
              ],
            ),
          )),
    );
  }

  void onButtonPressed() {
    if (_otp.isEmpty) {
      return;
    }
    if (_otp.length < 6) {
      return;
    }
    setState(() {
      _isLoading = true;
    });

    // TODO request to API
    Future.delayed(const Duration(seconds: 2)).then((value) {
      context.go(NavigationRouteName.home);
    });
  }
}
