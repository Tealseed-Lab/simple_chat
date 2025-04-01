import 'package:simple_chat/simple_chat.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ModelUser extends ModelBaseUser {
  @override
  final String id;
  @override
  final String avatarUrl;

  @override
  final bool isCurrentUser;

  @override
  final String name;

  ModelUser({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.isCurrentUser,
  });
  // parsing

  factory ModelUser.fromJson(Map<String, dynamic> json) =>
      _$ModelUserFromJson(json);
  Map<String, dynamic> toJson() => _$ModelUserToJson(this);
}
