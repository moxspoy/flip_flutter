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
    Key? key,
  }) : super(key: key);

  final String phoneNumber;

  @override
  State<OtpScreen> createState() => _OtpState();
}

class _OtpState extends State<OtpScreen> {
  String _otp = '';
  bool _isLoading = false;

  // countdown
  final int _start = 59;
  int _current = 59;

  void startTimer() {
    CountdownTimer countDownTimer = CountdownTimer(
      Duration(seconds: _start),
      const Duration(seconds: 1),
    );

    var sub = countDownTimer.listen(null);
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
