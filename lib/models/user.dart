import 'package:json_annotation/json_annotation.dart';
import 'package:simple_chat/simple_chat.dart';

part 'user.g.dart';

/// The user for the chat.
@JsonSerializable(fieldRename: FieldRename.snake)
class ModelUser extends ModelBaseUser {
  /// The id of the user.
  @override
  final String id;

  /// The avatar url of the user.
  @override
  final String avatarUrl;

  /// The flag for the current user.
  @override
  final bool isCurrentUser;

  /// The name of the user.
  @override
  final String name;

  /// The constructor of the user.
  ModelUser({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.isCurrentUser,
  });

  // parsing

  /// The factory method for the user from the json.
  factory ModelUser.fromJson(Map<String, dynamic> json) =>
      _$ModelUserFromJson(json);

  /// The method for the to json.
  Map<String, dynamic> toJson() => _$ModelUserToJson(this);
}
