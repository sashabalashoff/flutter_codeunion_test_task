import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'src/res/theme.dart';
import 'src/res/utils/yaml_asset_loader.dart';
import 'src/router.dart';
import 'src/services/locator.dart';

void main() {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();
    setupLocator();

    runApp(MainApp());
  }, (error, stacktrace) {
    debugPrint("⬇ UNEXPECTED ERROR ⬇");
    debugPrint("error:\n$error");
    debugPrint("stacktrace:\n$stacktrace");
    debugPrint("⬆ ________________ ⬆");
  });
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final _router = locator<AppRouter>();

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: const [
        Locale('ru'),
        Locale('en'),
      ],
      path: 'assets/translations',
      assetLoader: YamlAssetLoader(),
      useOnlyLangCode: true,
      fallbackLocale: const Locale('ru'),
      useFallbackTranslations: true,
      child: Builder(
        builder: (context) => MaterialApp.router(
          builder: (_, child) => child ?? const SizedBox.shrink(),
          routerConfig: _router.config(),
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          themeMode: ThemeMode.light,
          theme: lightThemeData,
          darkTheme: darkThemeData,
        ),
      ),
    );
  }
}
