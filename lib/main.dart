import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flip/navigation/navigation_container.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:user_repository/user_repository.dart';

import 'feature/authentication/bloc/authentication_bloc.dart';

Future main() async {
  await dotenv.load(fileName: '.env.domestic');

  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('assets/google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  WidgetsFlutterBinding.ensureInitialized();

  final savedThemeMode = await AdaptiveTheme.getThemeMode();

  runApp(App(savedThemeMode: savedThemeMode));
}

class App extends StatefulWidget {
  final AdaptiveThemeMode? savedThemeMode;

  const App({super.key, this.savedThemeMode});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AuthenticationRepository _authenticationRepository;
  late final UserRepository _userRepository;

  @override
  void initState() {
    super.initState();
    _authenticationRepository = AuthenticationRepository();
    _userRepository = UserRepository();
  }

  @override
  void dispose() {
    _authenticationRepository.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
          authenticationRepository: _authenticationRepository,
          userRepository: _userRepository,
        ),
        child: AppView(
          savedThemeMode: widget.savedThemeMode,
        ),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  final AdaptiveThemeMode? savedThemeMode;

  const AppView({super.key, this.savedThemeMode});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  @override
  Widget build(BuildContext context) {
    return NavigationContainer(
      savedThemeMode: widget.savedThemeMode,
    );
  }
}
