// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flip/constants/navigation.dart';
import 'package:flip/screens/home_screen.dart';
import 'package:flip/screens/login_screen.dart';
import 'package:flip/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

/// The route configuration.
final GoRouter _router = GoRouter(
  initialLocation: NavigationRouteName.getPath(NavigationRouteName.splash),
  routes: <RouteBase>[
    GoRoute(
      path: NavigationRouteName.getPath(NavigationRouteName.splash),
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      path: NavigationRouteName.getPath(NavigationRouteName.home),
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
    ),
    GoRoute(
      path: NavigationRouteName.getPath(NavigationRouteName.login),
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreen();
      },
    ),
  ],
);

class NavigationContainer extends StatefulWidget {
  final AdaptiveThemeMode? savedThemeMode;
  const NavigationContainer({super.key, this.savedThemeMode});

  @override
  State<NavigationContainer> createState() => _NavigationContainerState();

}

class _NavigationContainerState extends State<NavigationContainer> {

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
        light: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.red,
        ),
        dark: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.red,
        ),
        initial: widget.savedThemeMode ?? AdaptiveThemeMode.light,
        builder: (theme, darkTheme) => MaterialApp.router(
          routerConfig: _router,
          theme: _buildTheme(theme),
          darkTheme: darkTheme,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
        )
    );
  }

  ThemeData _buildTheme(ThemeData themeData) {
    return themeData.copyWith(
      textTheme: GoogleFonts.latoTextTheme(themeData.textTheme),
    );
  }
}

