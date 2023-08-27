part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.authData,
  });

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(AuthData authData)
      : this._(status: AuthenticationStatus.authenticated, authData: authData);

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  final AuthenticationStatus status;
  final AuthData? authData;

  @override
  List<Object?> get props => [status, authData];
}
