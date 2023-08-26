import 'package:get_it/get_it.dart';

import '../router.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<AppRouter>(AppRouter());
}
