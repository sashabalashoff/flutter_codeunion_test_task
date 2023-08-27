import 'package:json_annotation/json_annotation.dart';

part 'server_error.g.dart';

@JsonSerializable()
class ServerError {
  ServerError({
    required this.message,
  });

  final String message;

  factory ServerError.fromJson(Map<String, dynamic> json) => _$ServerErrorFromJson(json);
}
