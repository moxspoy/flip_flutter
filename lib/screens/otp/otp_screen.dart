import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip/constants/navigation.dart';
import 'package:flip/utils/l10n/localizations.dart';
import 'package:flip/widgets/appbar/appbar.dart';
import 'package:flip/widgets/button/button.dart';
import 'package:flip/widgets/text/text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quiver/async.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({
    required this.phoneNumber,
    required this.verificationId,
    Key? key,
  }) : super(key: key);

  final String phoneNumber;
  final String verificationId;

  @override
  State<OtpScreen> createState() => _OtpState();
}

class _OtpState extends State<OtpScreen> {
  String _otp = '';
  bool _isLoading = false;

  // countdown
  final int _start = 59;
  int _current = 59;

  StreamSubscription<CountdownTimer> sub = CountdownTimer(
    const Duration(seconds: 59),
    const Duration(seconds: 1),
  ).listen(null);

  void startTimer() {
    CountdownTimer countDownTimer = CountdownTimer(
      Duration(seconds: _start),
      const Duration(seconds: 1),
    );

    sub = countDownTimer.listen(null);
    sub.onData((duration) {
      setState(() {
        _current = _start - duration.elapsed.inSeconds;
      });
    });

    sub.onDone(() {
      sub.cancel();
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    sub.cancel();
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
                    HeadlineText(
                      getText(context)!.otpScreenTitle,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '${getText(context)!.otpScreenSubtitle} ${widget.phoneNumber}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 32),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
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
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        SizedBox(
                          height: 42,
                          width: 50,
                          child: _current > 0
                              ? Text(
                                  "0:${_current.toString()}",
                                )
                              : InkWell(
                                  highlightColor: Colors.transparent,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  onTap: startTimer,
                                  child:
                                      Text(getText(context)!.otpScreenResend),
                                ),
                        ),
                      ],
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

  void onButtonPressed() async {
    if (_otp.isEmpty) {
      return;
    }
    if (_otp.length < 6) {
      return;
    }
    setState(() {
      _isLoading = true;
    });

    // Create a PhoneAuthCredential with the code
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId, smsCode: _otp);
    // Sign the user in (or link) with the credential
    await FirebaseAuth.instance.signInWithCredential(credential);
    setState(() {
      _isLoading = false;
    });
    if (context.mounted) {
      context.push(NavigationRouteName.onBoardingName);
    }
  }
}
