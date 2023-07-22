import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flip/constants/l10n.dart';
import 'package:flip/utils/l10n/localizations.dart';
import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';

class LoginScreen extends StatelessWidget {
  
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/images/icons/flip.png',
                height: 50,
                width: 50,
              ),
              Row(
                children: [
                  InkWell(
                    child: Text(
                      Localizations.localeOf(context).languageCode ==
                              LanguageProvider().languageIndonesia
                          ? 'EN'
                          : 'ID',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    onTap: () {
                      showModalBottomSheet<dynamic>(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        builder: (BuildContext context) {
                          debugPrint(
                              "value of your text ${Localizations.localeOf(context).languageCode}");
                          return Wrap(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text(
                                      getText(context)!.changeLanguageTitle,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.copyWith(
                                              fontWeight: FontWeight.w900),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Text(getText(context)!
                                        .changeLanguageSubTitle),
                                    const SizedBox(height: 16),
                                    OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        minimumSize: const Size.fromHeight(50),
                                      ),
                                      onPressed: () {},
                                      child: const Text('Bahasa Indonesia'),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        minimumSize: const Size.fromHeight(50),
                                      ),
                                      onPressed: () {},
                                      child: const Text('English'),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          );
                        },
                      );
                    },
                  ),
                  IconButton(
                      onPressed: () {
                        AdaptiveTheme.of(context).toggleThemeMode();
                      },
                      icon: Icon(AdaptiveTheme.of(context).mode ==
                              AdaptiveThemeMode.dark
                          ? Icons.light_mode
                          : Icons.dark_mode))
                ],
              )
            ],
          ),
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
    )));
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
                Text(getText(context)!.loginScreenTerm),
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
