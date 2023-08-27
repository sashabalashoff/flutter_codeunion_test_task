import 'package:auto_route/auto_route.dart';

import 'views/favorites_screen.dart';
import 'views/feed_screen.dart';
import 'views/home_screen.dart';
import 'views/map_screen.dart';
import 'views/profile_screen.dart';
import 'views/sign_in_screen.dart';
import 'views/splash_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Screen,Page,Route',
)
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

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
      page: HomeScreenRoute.page,
      children: [
        AutoRoute(
          page: FeedScreenRoute.page,
        ),
        AutoRoute(
          page: MapScreenRoute.page,
        ),
        AutoRoute(
          page: FavoritesScreenRoute.page,
        ),
        AutoRoute(
          page: ProfileScreenRoute.page,
        ),
      ],
    ),
    AutoRoute(
      page: SignInScreenRoute.page,
    ),
    AutoRoute(
      page: ProfileScreenRoute.page,
    ),
  ];
}
