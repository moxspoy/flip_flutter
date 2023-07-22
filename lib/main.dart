import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flip/navigation/navigation_container.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load(fileName: '.env.domestic');

  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('assets/google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  WidgetsFlutterBinding.ensureInitialized();

  final savedThemeMode = await AdaptiveTheme.getThemeMode();

  runApp(MyApp(savedThemeMode: savedThemeMode));
}

class MyApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;
  const MyApp({super.key, this.savedThemeMode});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return NavigationContainer(
      savedThemeMode: savedThemeMode,
    );
  }
}
