import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/authentication/authentication_bloc.dart';
import '../widgets/default_app_bar.dart';
import '../widgets/menu_button.dart';
import '../widgets/profile_avatar.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: DefaultAppBar(
        title: 'profile.title'.tr(),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            const SizedBox(height: 38),
            const ProfileAvatar(),
            const SizedBox(height: 15),
            Builder(
              builder: (context) {
                final authData = context.select((AuthenticationBloc bloc) => bloc.state.authData);

                if (authData == null) {
                  return const SizedBox();
                }

                return Column(
                  children: [
                    Text(
                      authData.user.nickname,
                      style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                        height: 40 / 24,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      authData.user.email,
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.secondary,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        height: 22 / 16,
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 27),
            MenuButton(
              text: 'profile.sign_out_button'.tr(),
              color: colorScheme.error,
              onPressed: () {
                context.read<AuthenticationBloc>().add(AuthenticationSignOutRequested());
              },
            ),
          ],
        ),
      ),
    );
  }
}
