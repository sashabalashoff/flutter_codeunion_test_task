import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../blocs/login/login_bloc.dart';
import '../repositories/authentication_repository.dart';
import '../widgets/button_group.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_input.dart';
import '../widgets/default_app_bar.dart';

@RoutePage()
class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: DefaultAppBar(
        title: 'sign_in.title'.tr(),
      ),
      body: BlocProvider(
        create: (context) => LoginBloc(
          authenticationRepository: RepositoryProvider.of<AuthenticationRepository>(context),
        ),
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.status.isFailure) {
              if (state.errorMessage != null) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text((state.errorMessage!).tr()),
                      backgroundColor: colorScheme.error,
                    ),
                  );
              }
            }
          },
          child: Column(
            children: [
              const Spacer(),
              ColoredBox(
                color: colorScheme.surface,
                child: Column(
                  children: [
                    _UsernameInput(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Divider(
                        height: 1,
                        color: theme.brightness == Brightness.light
                            ? const Color(0xFFE0E6ED)
                            : const Color(0xFFE0E6ED),
                      ),
                    ),
                    _PasswordInput(),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              ButtonGroup(
                buttons: [
                  _LoginButton(),
                  CustomButton(
                    text: 'sign_in.sign_up_button'.tr(),
                    onPressed: () {},
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return CustomInput(
          key: const Key('username_input'),
          onChanged: (username) => context.read<LoginBloc>().add(LoginUsernameChanged(username)),
          hintText: 'sign_in.login_or_email'.tr(),
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return CustomInput(
          key: const Key('password_input'),
          onChanged: (password) => context.read<LoginBloc>().add(LoginPasswordChanged(password)),
          obscureText: true,
          hintText: 'sign_in.password'.tr(),
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.done,
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return CustomButton(
          key: const Key('sign_in_button'),
          text: 'sign_in.sign_in_button'.tr(),
          isActive: state.isValid,
          onPressed: state.isValid
              ? () {
                  context.read<LoginBloc>().add(const LoginSubmitted());
                }
              : null,
        );
      },
    );
  }
}
