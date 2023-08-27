import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../res/svg.dart' as svg;

class NavBar extends StatefulWidget {
  final int selectedIndex;
  final void Function(int) onItemTapped;

  const NavBar({
    Key? key,
    required this.onItemTapped,
    this.selectedIndex = 0,
  }) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  Widget _buildSvgIcon(String icon, [bool selected = false]) {
    final colorScheme = Theme.of(context).colorScheme;

    return SvgPicture.string(
      icon,
      width: 22,
      height: 22,
      colorFilter: ColorFilter.mode(
        selected ? colorScheme.primary : colorScheme.onSurface,
        BlendMode.srcIn,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CupertinoTabBar(
      backgroundColor: theme.colorScheme.surface,
      onTap: widget.onItemTapped,
      currentIndex: widget.selectedIndex,
      border: null,
      items: [
        BottomNavigationBarItem(
          icon: _buildSvgIcon(svg.navbarFeed),
          activeIcon: _buildSvgIcon(svg.navbarFeed, true),
          label: 'nav_bar.feed'.tr(),
        ),
        BottomNavigationBarItem(
          icon: _buildSvgIcon(svg.navbarMap),
          activeIcon: _buildSvgIcon(svg.navbarMap, true),
          label: 'nav_bar.map'.tr(),
        ),
        BottomNavigationBarItem(
          icon: _buildSvgIcon(svg.navbarFavorites),
          activeIcon: _buildSvgIcon(svg.navbarFavorites, true),
          label: 'nav_bar.favorites'.tr(),
        ),
        BottomNavigationBarItem(
          icon: _buildSvgIcon(svg.navbarProfile),
          activeIcon: _buildSvgIcon(svg.navbarProfile, true),
          label: 'nav_bar.profile'.tr(),
        ),
      ],
    );
  }
}
