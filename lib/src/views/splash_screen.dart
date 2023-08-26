import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../router.dart';
import '../services/locator.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    locator<AppRouter>().push(const SignInScreenRoute());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Material(
      color: colorScheme.background,
      child: const SafeArea(
        child: Center(child: Text('Test task')),
      ),
    );
  }
}
