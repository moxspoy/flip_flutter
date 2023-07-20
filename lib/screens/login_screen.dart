import 'package:flip/utils/l10n/localizations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: ElevatedButton(
          onPressed: () => context.push('/home'),
          child: Text(getText(context)!.loginButton),
        ),
      ),
    );
  }
}
