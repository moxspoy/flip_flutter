import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:circle_flags/circle_flags.dart';
import 'package:flip/constants/l10n.dart';
import 'package:flip/utils/l10n/localizations.dart';
import 'package:flip/widgets/bottomsheet/change_language.dart';
import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 90,
          backgroundColor:
              AdaptiveTheme.of(context).theme.primaryColor.withOpacity(0.8),
          leading: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Image.asset(
              'assets/images/icons/flip.png',
              height: 50,
              width: 50,
            ),
          ),
          actions: [
            Center(
              child: InkWell(
                child: CircleFlag(
                  Localizations.localeOf(context).languageCode ==
                          LanguageProvider().languageIndonesia
                      ? 'id'
                      : 'gb',
                  size: 24.0,
                ),
                onTap: () {
                  ChangeLanguageBottomSheet.show(context);
                },
              ),
            ),
            IconButton(
                onPressed: () {
                  AdaptiveTheme.of(context).toggleThemeMode();
                },
                icon: Icon(AdaptiveTheme.of(context).mode ==
                    AdaptiveThemeMode.dark
                    ? Icons.light_mode
                    : Icons.dark_mode
                )
            )
          ],
        ),
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
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    getText(context)!.loginScreenSubtitle,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontSize: 18),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
              const Expanded(
                child: LoginForm(),
              )
            ],
          ),
        )
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late PhoneController _phoneController;
  String _phoneNumber = '';
  bool _isTermChecked = false;

  CountrySelectorNavigator selectorNavigator =
      const CountrySelectorNavigator.searchDelegate();
  final formKey = GlobalKey<FormState>();
  final phoneKey = GlobalKey<FormFieldState<PhoneNumber>>();

  @override
  initState() {
    super.initState();
    _phoneController = PhoneController(null);
    _phoneController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    _phoneController.dispose();
  }

  PhoneNumberInputValidator? _getValidator() {
    List<PhoneNumberInputValidator> validators = [];
    validators.add(PhoneValidator.validMobile());
    return validators.isNotEmpty ? PhoneValidator.compose(validators) : null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AutofillGroup(
          child: PhoneFormField(
            controller: _phoneController,
            autofocus: true,
            autofillHints: const [AutofillHints.telephoneNumber],
            countrySelectorNavigator:
                const CountrySelectorNavigator.bottomSheet(),
            defaultCountry: IsoCode.ID,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: getText(context)!.loginScreenFieldPhoneNumberHint,
            ),
            enabled: true,
            showFlagInInput: true,
            validator: _getValidator(),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            cursorColor: Theme.of(context).colorScheme.primary,
            // ignore: avoid_print
            onSaved: (p) => print('saved $p'),
            // ignore: avoid_print
            onChanged: (p) => {
              setState(() {
                _phoneNumber = '+${p?.countryCode}${p?.nsn}';
              })
            },
          ),
        ),
        const Expanded(child: SizedBox()),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 5,
                  child: Text(
                    getText(context)!.loginScreenTerm,
                    style: AdaptiveTheme.of(context)
                        .theme
                        .textTheme
                        .bodySmall
                        ?.copyWith(
                          fontSize: 11,
                        ),
                  ),
                ),
                Checkbox(
                    value: _isTermChecked,
                    onChanged: (newValue) {
                      setState(() {
                        _isTermChecked = newValue!;
                      });
                    }),
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: () {
                debugPrint('requestAPI $_phoneNumber}');
              },
              child: Text(getText(context)!.loginButton),
            ),
            const SizedBox(height: 32)
          ],
        )
      ],
    );
  }
}
