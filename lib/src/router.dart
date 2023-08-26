import 'package:auto_route/auto_route.dart';

import 'views/profile_screen.dart';
import 'views/sign_in_screen.dart';
import 'views/splash_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Screen,Page,Route',
)
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        ...AppRouter.rootRoutes,
      ];

  static final rootRoutes = [
    AutoRoute(
      path: '/',
      page: SplashScreenRoute.page,
    ),
    AutoRoute(
      page: SignInScreenRoute.page,
    ),
    AutoRoute(
      page: ProfileScreenRoute.page,
    ),
  ];
}
