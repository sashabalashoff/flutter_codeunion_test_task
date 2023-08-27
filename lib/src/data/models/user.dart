import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  User({
    required this.email,
    required this.nickname,
  });

  final String email;
  final String nickname;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
