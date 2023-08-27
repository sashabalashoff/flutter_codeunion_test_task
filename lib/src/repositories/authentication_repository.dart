import 'dart:async';

import '../data/models/auth_data.dart';
import '../services/api_service.dart';
import '../services/locator.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  AuthData? authData;

  Future<void> logIn({
    required String email,
    required String password,
  }) async {
    final loginData = await locator<ApiService>().authLogin(email: email, password: password);

    if (loginData.tokens.accessToken.isNotEmpty) {
      _controller.add(AuthenticationStatus.authenticated);
      authData = loginData;
    }
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
