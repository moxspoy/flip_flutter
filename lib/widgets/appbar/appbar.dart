import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:circle_flags/circle_flags.dart';
import 'package:flutter/material.dart';

import '../../constants/l10n.dart';
import '../bottomsheet/change_language.dart';

class OnboardingAppBar extends StatelessWidget implements PreferredSizeWidget {
  const OnboardingAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
            icon: Icon(AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark
                ? Icons.light_mode
                : Icons.dark_mode))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
