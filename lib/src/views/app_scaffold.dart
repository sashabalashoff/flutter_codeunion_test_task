import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../router.dart';
import '../widgets/nav_bar.dart';

class AppScaffold extends StatefulWidget {
  const AppScaffold({super.key});

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  static final _routes = <PageRouteInfo>[
    const FeedScreenRoute(),
    const MapScreenRoute(),
    const FavoritesScreenRoute(),
    const ProfileScreenRoute(),
  ];

  void _onItemTapped(int index, TabsRouter tabsRouter) {
    if (index != tabsRouter.activeIndex) {
      tabsRouter.setActiveIndex(index);
    } else {
      Future<void>(() async {
        while (tabsRouter.canPop()) {
          await tabsRouter.popTop();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: _routes,
      bottomNavigationBuilder: (context, tabsRouter) => NavBar(
        selectedIndex: tabsRouter.activeIndex,
        onItemTapped: (index) {
          _onItemTapped(index, tabsRouter);
        },
      ),
    );
  }
}
