import 'package:get_it/get_it.dart';

import '../router.dart';
import 'api_service.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<ApiService>(ApiServiceImpl());
  locator.registerSingleton<AppRouter>(AppRouter());
}
