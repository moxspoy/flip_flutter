import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flip/utils/l10n/localizations.dart';
import 'package:flip/utils/validation/validation.dart';
import 'package:flip/widgets/animation/shake.dart';
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
  bool _isButtonLoading = false;

  late GlobalKey<CustomShakeWidgetState> _termConditionText;

  CountrySelectorNavigator selectorNavigator =
      const CountrySelectorNavigator.searchDelegate();
  final formKey = GlobalKey<FormState>();
  final phoneKey = GlobalKey<FormFieldState<PhoneNumber>>();

  @override
  initState() {
    super.initState();
    _termConditionText = GlobalKey();
    _phoneController = PhoneController(null);
    _phoneController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    _termConditionText.currentState?.dispose();
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
                  child: CustomShakeWidget(
                    key: _termConditionText,
                    duration: const Duration(milliseconds: 500),
                    shakeCount: 4,
                    shakeOffset: 8,
                    child: Text(
                      getText(context)!.loginScreenTerm,
                      style: Theme.of(context).textTheme.bodySmall,
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
                if (!_isTermChecked) {
                  _termConditionText.currentState?.shake();
                  return;
                }
                String validationMessage = validateMobile(_phoneNumber);
                if (validationMessage.isEmpty) {
                  setState(() {
                    _isButtonLoading = true;
                  });
                  Future.delayed(const Duration(milliseconds: 3000), () {
                    setState(() {
                      _isButtonLoading = false;
                    });
                  });
                  return;
                }
                SnackBar snackBar = SnackBar(
                  content: Text(
                    validationMessage,
                    style: AdaptiveTheme.of(context).theme.textTheme.bodyMedium,
                  ),
                  backgroundColor:
                      AdaptiveTheme.of(context).theme.colorScheme.background,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                return;
              },
              child: _isButtonLoading
                  ? SizedBox(
                      height: 16,
                      width: 16,
                      child: Center(
                          child: CircularProgressIndicator(
                        color: Theme.of(context).hintColor,
                        strokeWidth: 1.5,
                      )))
                  : Text(getText(context)!.loginButton),
            ),
            const SizedBox(height: 32)
          ],
        )
      ],
    );
  }
}
