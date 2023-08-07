// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flip/blocs/user/user_bloc.dart';
import 'package:flip/l10n/language_bloc.dart';
import 'package:flip/navigation/router.dart';
import 'package:flip/themes/colors/material_custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import '../l10n/language_state.dart';

class ApplicationContainer extends StatefulWidget {
  final AdaptiveThemeMode? savedThemeMode;

  const ApplicationContainer({
    super.key,
    this.savedThemeMode,
  });

  @override
  State<ApplicationContainer> createState() => _ApplicationContainerState();
}

class _ApplicationContainerState extends State<ApplicationContainer> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LanguageBloc()),
        BlocProvider(create: (context) => UserBloc()),
      ],
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          return AdaptiveTheme(
              light: ThemeData(
                brightness: Brightness.light,
                primarySwatch: CustomMaterialColor.orange,
              ),
              dark: ThemeData(
                brightness: Brightness.dark,
                primarySwatch: CustomMaterialColor.blue,
              ),
              initial: widget.savedThemeMode ?? AdaptiveThemeMode.light,
              builder: (theme, darkTheme) => MaterialApp.router(
                routerConfig: NavigationRouter().router,
                    theme: _buildTheme(theme),
                    debugShowCheckedModeBanner: false,
                    darkTheme: darkTheme,
                    localizationsDelegates: const [
                      AppLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    locale: state.selectedLanguage.value,
                    supportedLocales: AppLocalizations.supportedLocales,
                  ));
        },
      ),
    );
  }

  ThemeData _buildTheme(ThemeData themeData) {
    return themeData.copyWith(
      textTheme: GoogleFonts.latoTextTheme(themeData.textTheme),
    );
  }
}
