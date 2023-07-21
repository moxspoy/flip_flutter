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
                      InkWell(
                        child: Text(
                          Localizations
                              .localeOf(context)
                              .languageCode
                              == LanguageProvider().languageIndonesia
                              ? 'EN' : 'ID',
                          style: Theme
                              .of(context)
                              .textTheme
                              .headlineSmall,
                        ),
                        onTap: () {
                          // Todo open slider
                          debugPrint("value of your text ${Localizations
                              .localeOf(context)
                              .languageCode}");
                        },
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 42),
                      Text(
                        getText(context)!.loginScreenTitle,
                        style: Theme
                            .of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                            fontWeight: FontWeight.w900
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        getText(context)!.loginScreenSubtitle,
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(
                            fontSize: 18
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                  const LoginForm(),
                ],
              ),
            )
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

  CountrySelectorNavigator selectorNavigator = const CountrySelectorNavigator
      .searchDelegate();
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
    return Container(
      child: Column(
        children: [
          AutofillGroup(
            child: PhoneFormField(
              controller: _phoneController,
              autofocus: true,
              autofillHints: const [AutofillHints.telephoneNumber],
              countrySelectorNavigator: const CountrySelectorNavigator
                  .bottomSheet(),
              defaultCountry: IsoCode.ID,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: getText(context)!.loginScreenFieldPhoneNumberHint,
              ),
              enabled: true,
              showFlagInInput: true,
              validator: _getValidator(),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              cursorColor: Theme
                  .of(context)
                  .colorScheme
                  .primary,
              // ignore: avoid_print
              onSaved: (p) => print('saved $p'),
              // ignore: avoid_print
              onChanged: (p) =>
              {
                setState(() {
                  _phoneNumber = '+${p?.countryCode}${p?.nsn}';
                })
              },
            ),
          ),
          const SizedBox(height: 100),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(40), // fromHeight use double.infinity as width and 40 is the height
            ),
              onPressed: () {
              debugPrint('requestAPI $_phoneNumber}');
              },
              child: Text(getText(context)!.loginButton),
          )
        ],
      ),
    );
  }
}
