import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/blocs/authentication/authentication_bloc.dart';
import 'src/repositories/authentication_repository.dart';
import 'src/res/theme.dart';
import 'src/res/utils/yaml_asset_loader.dart';
import 'src/router.dart';
import 'src/services/locator.dart';

void main() {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();
    setupLocator();

    runApp(const MainApp());
  }, (error, stacktrace) {
    debugPrint("⬇ UNEXPECTED ERROR ⬇");
    debugPrint("error:\n$error");
    debugPrint("stacktrace:\n$stacktrace");
    debugPrint("⬆ ________________ ⬆");
  });
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late final AuthenticationRepository _authenticationRepository;

  final _router = locator<AppRouter>();

  @override
  void initState() {
    super.initState();
    _authenticationRepository = AuthenticationRepository();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
          authenticationRepository: _authenticationRepository,
        ),
        child: EasyLocalization(
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
              builder: (_, child) {
                return BlocListener<AuthenticationBloc, AuthenticationState>(
                  listener: (context, state) {
                    switch (state.status) {
                      case AuthenticationStatus.authenticated:
                        _router.pushAndPopUntil(
                          const HomeScreenRoute(
                            children: [
                              ProfileScreenRoute(),
                            ],
                          ),
                          predicate: (_) => false,
                        );
                        break;
                      default:
                        _router.pushAndPopUntil(
                          const SignInScreenRoute(),
                          predicate: (_) => false,
                        );
                        break;
                    }
                  },
                  child: child ?? const SizedBox.shrink(),
                );
              },
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
        ),
      ),
    );
  }
}
