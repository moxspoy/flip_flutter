import 'package:flip/utils/l10n/localizations.dart';
import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';

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
                    style: Theme.of(context).textTheme.bodySmall,
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
