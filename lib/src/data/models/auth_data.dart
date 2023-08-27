import 'package:json_annotation/json_annotation.dart';

import 'tokens.dart';
import 'user.dart';

part 'auth_data.g.dart';

@JsonSerializable()
class AuthData {
  AuthData({
    required this.tokens,
    required this.user,
  });

  final Tokens tokens;
  final User user;

  factory AuthData.fromJson(Map<String, dynamic> json) => _$AuthDataFromJson(json);
}
