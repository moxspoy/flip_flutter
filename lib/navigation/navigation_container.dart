// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flip/constants/navigation.dart';
import 'package:flip/l10n/language_bloc.dart';
import 'package:flip/screens/home/home_screen.dart';
import 'package:flip/screens/login/login_screen.dart';
import 'package:flip/screens/otp/otp_screen.dart';
import 'package:flip/screens/splash/splash_screen.dart';
import 'package:flip/themes/colors/material_custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../l10n/language_state.dart';

GoRoute generateRoute({
  required String name,
  Widget? child,
  GoRouterWidgetBuilder? builder,
}) {
  return GoRoute(
    path: name,
    name: name,
    builder: builder ??
        (BuildContext context, GoRouterState state) {
          if (child != null) {
            return child;
          }
          return Container();
        },
  );
}

/// The route configuration.
final GoRouter _router = GoRouter(
  initialLocation: NavigationRouteName.splash,
  routes: <RouteBase>[
    generateRoute(
      name: NavigationRouteName.splash,
      child: const SplashScreen(),
    ),
    generateRoute(
      name: NavigationRouteName.home,
      child: const HomeScreen(),
    ),
    generateRoute(
      name: NavigationRouteName.login,
      child: const LoginScreen(),
    ),
    generateRoute(
        name: NavigationRouteName.otp,
        builder: (BuildContext context, GoRouterState state) {
          final phoneNumber = state.queryParameters['phoneNumber']!;
          return OtpScreen(phoneNumber: phoneNumber);
        }),
  ],
);

class NavigationContainer extends StatefulWidget {
  final AdaptiveThemeMode? savedThemeMode;

  const NavigationContainer({
    super.key,
    this.savedThemeMode,
  });

  @override
  State<NavigationContainer> createState() => _NavigationContainerState();
}

class _NavigationContainerState extends State<NavigationContainer> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LanguageBloc(),
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
                    routerConfig: _router,
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
