import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../router.dart';
import '../widgets/button_group.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_input.dart';
import '../widgets/default_app_bar.dart';

@RoutePage()
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: DefaultAppBar(
        title: 'sign_in.title'.tr(),
      ),
      body: Column(
        children: [
          const Spacer(),
          ColoredBox(
            color: colorScheme.surface,
            child: Column(
              children: [
                CustomInput(
                  controller: _emailController,
                  hintText: 'sign_in.login_or_email'.tr(),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(
                    height: 1,
                    color: theme.brightness == Brightness.light
                        ? const Color(0xFFE0E6ED)
                        : const Color(0xFFE0E6ED),
                  ),
                ),
                CustomInput(
                  controller: _passwordController,
                  hintText: 'sign_in.password'.tr(),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          ButtonGroup(
            buttons: [
              CustomButton(
                text: 'sign_in.sign_in_button'.tr(),
                onPressed: () {
                  context.pushRoute(const ProfileScreenRoute());
                },
              ),
              CustomButton(
                text: 'sign_in.sign_up_button'.tr(),
                onPressed: () {},
              ),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
