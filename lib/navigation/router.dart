import 'package:flip/constants/navigation.dart';
import 'package:flip/screens/home/home_screen.dart';
import 'package:flip/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/login/login_screen.dart';
import '../screens/otp/otp_screen.dart';

class NavigationRouter {
  static GoRoute generateRoute({
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
  GoRouter router = GoRouter(
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
}
