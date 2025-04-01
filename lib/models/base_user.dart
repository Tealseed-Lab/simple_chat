/// The base user for the chat.
abstract class ModelBaseUser {
  /// The id of the user.
  String get id;

  /// The name of the user.
  String get name;

  /// The avatar url of the user.
  String? get avatarUrl;

  /// The flag for the current user.
  bool get isCurrentUser;
}
