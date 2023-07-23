import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flip/l10n/language.dart';
import 'package:flip/l10n/language_bloc.dart';
import 'package:flip/l10n/language_event.dart';
import 'package:flip/l10n/language_state.dart';
import 'package:flip/utils/l10n/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeLanguageBottomSheet {
  static show(BuildContext context) {
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
                child: BlocBuilder<LanguageBloc, LanguageState>(
                  builder: (context, state) {
                    void changeLanguage(Language language) {
                      context.read<LanguageBloc>().add(
                            ChangeLanguage(
                              selectedLanguage: language,
                            ),
                          );
                      Future.delayed(const Duration(milliseconds: 300))
                          .then((value) => Navigator.of(context).pop());
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          getText(context)!.changeLanguageTitle,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(fontWeight: FontWeight.w900),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(getText(context)!.changeLanguageSubTitle),
                        const SizedBox(height: 16),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                          ),
                          onPressed: () {
                            if (state.selectedLanguage == Language.indonesia) {
                              Navigator.of(context).pop();
                            } else {
                              changeLanguage(Language.indonesia);
                            }
                          },
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text('Bahasa Indonesia',
                                      style: AdaptiveTheme.of(context)
                                          .theme
                                          .textTheme
                                          .bodyMedium)),
                              state.selectedLanguage == Language.indonesia
                                  ? const SizedBox(
                                      width: 20,
                                      child: Icon(Icons.check),
                                    )
                                  : Container()
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                          ),
                          onPressed: () {
                            if (state.selectedLanguage == Language.english) {
                              Navigator.of(context).pop();
                            } else {
                              changeLanguage(Language.english);
                            }
                          },
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text('English',
                                      style: AdaptiveTheme.of(context)
                                          .theme
                                          .textTheme
                                          .bodyMedium)),
                              state.selectedLanguage == Language.english
                                  ? const SizedBox(
                                      width: 20,
                                      child: Icon(Icons.check),
                                    )
                                  : Container()
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ))
          ],
        );
      },
    );
  }
}
