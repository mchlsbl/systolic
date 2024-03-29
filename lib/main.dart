import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:system_theme/system_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:ui';

import 'package:systolic/models/entry/entry_db.dart';
import 'package:systolic/models/medication/medication_db.dart';
import 'package:systolic/pages/entries_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EntryDB.initialize();
  await MedicationDB.initialize();

  SystemTheme.fallbackColor = Colors.grey;
  await SystemTheme.accentColor.load();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => EntryDB(),
        ),
        ChangeNotifierProvider(
          create: (context) => MedicationDB(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

String? getFont(bool serif) {
  if (serif) {
    switch (PlatformDispatcher.instance.locale.countryCode) {
      case "CN":
        return 'NotoSerifSC';
      case "TW":
        return 'NotoSerifTC';
      case "JP":
        return 'NotoSerifJP';
      case "KR":
        return 'NotoSerifKR';
    }
  }
  return serif ? 'PlayfairDisplay' : 'InterTight';
}

Widget centerText(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30),
    child: Center(
      child: Transform.translate(
        offset: const Offset(0, -50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    var statusBarText =
        brightness == Brightness.dark ? Brightness.light : Brightness.dark;

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
      ),
    );

    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const EntriesPage(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: SystemTheme.accentColor.accent,
          brightness: brightness,
        ),
        fontFamily: getFont(false),
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: statusBarText,
            statusBarIconBrightness: statusBarText,
          ),
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }
}
