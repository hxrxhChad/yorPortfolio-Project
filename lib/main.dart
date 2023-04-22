// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:p/constant/colorsize.dart';
import 'package:p/constant/responsive.dart';
import 'package:p/desktop/page/d-log-in.dart';
import 'package:p/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString("email");
  final savedTheme = await AdaptiveTheme.getThemeMode();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ProviderScope(
      child: MainApp(
        savedThemeMode: savedTheme,
        email: email,
      ),
    ),
  );
}

class MainApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;
  final String? email;
  const MainApp({
    Key? key,
    this.savedThemeMode,
    this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        scaffoldBackgroundColor: greyC,
        primaryColor: purpleC,
        canvasColor: purpleC,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: purpleC),
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: darkC)
            .copyWith(
              bodyLarge: const TextStyle(
                color: darkC,
              ),
              bodyMedium: const TextStyle(
                color: darkC,
              ),
            ),
      ),
      dark: ThemeData(
        scaffoldBackgroundColor: greyC,
        primaryColor: purpleC,
        canvasColor: purpleC,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: purpleC),
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white)
            .copyWith(
              bodyLarge: const TextStyle(
                color: Colors.white,
              ),
              bodyMedium: const TextStyle(
                color: Colors.white,
              ),
            ),
      ),
      initial: savedThemeMode ?? AdaptiveThemeMode.light,
      builder: (theme, dark) {
        return MaterialApp(
            title: 'yorPortfolio',
            theme: theme,
            darkTheme: dark,
            debugShowCheckedModeBanner: false,
            home: email == null ? const DLogin() : const Responsive());
      },
    );
  }
}
