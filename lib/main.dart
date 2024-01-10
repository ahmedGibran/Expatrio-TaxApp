import 'package:expatrio_tax_task/core/core.dart';
import 'package:expatrio_tax_task/features/features.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  initDIC();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => getIt<AuthState>(),
        ),
        ChangeNotifierProvider(
          create: (context) => getIt<TaxState>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        localizationsDelegates: const [
          // custom delegate for specific lang
          AppLocalization.delegate,
          // provides localized strings and other values for the Material Components library.
          GlobalMaterialLocalizations.delegate,
          // defines the default text direction, either left-to-right or right-to-left, for the widgets library.
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', 'US'), // English, USA country code
          Locale('de', 'DE'), // German
        ],
        localeResolutionCallback: (deviceLocal, supportedLocales) {
          for (var locale in supportedLocales) {
            if (locale.languageCode == deviceLocal?.languageCode && locale.countryCode == deviceLocal?.countryCode) {
              return locale;
            }
          }
          return supportedLocales.first;
        },
        theme: ThemeData(
            brightness: Brightness.light,
            textSelectionTheme: const TextSelectionThemeData()
                .copyWith(selectionColor: Theme.of(context).colors.primary.withOpacity(0.2)),
            inputDecorationTheme: const InputDecorationTheme().copyWith(focusColor: Theme.of(context).colors.primary),

        ),
        home: const LoginScreen(),
      ),
    );
  }
}
