// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flip/constants/navigation.dart';
import 'package:flip/feature/authentication/bloc/authentication_bloc.dart';
import 'package:flip/l10n/language_bloc.dart';
import 'package:flip/screens/home/home_screen.dart';
import 'package:flip/screens/login/login_screen.dart';
import 'package:flip/screens/splash/splash_screen.dart';
import 'package:flip/themes/colors/material_custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../l10n/language_state.dart';

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
                    builder: (context, child) {
                      return BlocListener<AuthenticationBloc,
                          AuthenticationState>(
                        listener: (context, state) {
                          switch (state.status) {
                            case AuthenticationStatus.authenticated:
                              Navigator.of(context).pushAndRemoveUntil<void>(
                                HomeScreen.route(),
                                (route) => false,
                              );
                            case AuthenticationStatus.unauthenticated:
                              Navigator.of(context).pushAndRemoveUntil<void>(
                                LoginScreen.route(),
                                (route) => false,
                              );
                            case AuthenticationStatus.unknown:
                              break;
                          }
                        },
                        child: child,
                      );
                    },
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
