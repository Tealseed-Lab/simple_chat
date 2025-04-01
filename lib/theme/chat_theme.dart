import 'package:flutter/material.dart';

/// The extension for the themed context.
extension ThemedContextExtension on BuildContext {
  /// The method for the get the colored theme.
  ChatColorThemeData get coloredTheme {
    final brightness = MediaQuery.of(this).platformBrightness;
    final chatTheme = ChatTheme.of(this);
    return brightness == Brightness.light ? chatTheme.light : chatTheme.dark;
  }

  /// The method for the get the layout theme.
  ChatLayoutThemeData get layoutTheme {
    final chatTheme = ChatTheme.of(this);
    return chatTheme.layout;
  }
}

/// The theme for the chat.
class ChatTheme extends InheritedWidget {
  /// The constructor for the chat theme.
  const ChatTheme({
    super.key,
    required this.data,
    required super.child,
  });

  /// The data for the chat theme.
  final ChatThemeData data;

  /// The method for the of.
  static ChatThemeData of(BuildContext context) {
    final ChatTheme? theme =
        context.dependOnInheritedWidgetOfExactType<ChatTheme>();
    return theme?.data ??
        ChatThemeData(
          light: ChatColorThemeData.light,
          dark: ChatColorThemeData.dark,
        );
  }

  /// The method for the update should notify.
  @override
  bool updateShouldNotify(ChatTheme oldWidget) {
    return data != oldWidget.data;
  }
}

/// The data for the chat theme.
class ChatThemeData {
  /// The constructor for the chat theme data.
  ChatThemeData({
    required this.light,
    required this.dark,
    this.layout = const ChatLayoutThemeData(),
  });

  /// The light color theme data.
  ChatColorThemeData light;

  /// The dark color theme data.
  ChatColorThemeData dark;

  /// The layout theme data.
  ChatLayoutThemeData layout;
}

/// The color theme data for the chat.
class ChatColorThemeData {
  /// The light color theme data.
  static ChatColorThemeData get light => ChatColorThemeData();

  /// The dark color theme data.
  static ChatColorThemeData get dark => ChatColorThemeData();

  /// The background color.
  final Color backgroundColor;

  /// The input box color.
  final Color inputBoxColor;

  /// The my message color.
  final Color myMessageColor;

  /// The other message color.
  final Color otherMessageColor;

  /// The primary color.
  final Color primary;

  /// The unread indicator background color.
  final Color unreadIndicatorBackgroundColor;

  /// The sending indicator color.
  final Color sendingIndicatorColor;

  /// The constructor for the chat color theme data.
  ChatColorThemeData({
    this.backgroundColor = const Color(0xFFF5F5F5),
    this.inputBoxColor = Colors.white,
    this.myMessageColor = const Color(0xFFE5E5EA),
    this.otherMessageColor = Colors.white,
    this.primary = const Color(0xFFF86526),
    this.unreadIndicatorBackgroundColor = Colors.white,
    this.sendingIndicatorColor = const Color(0xFFF86526),
  });

  /// The method for the copy with.
  ChatColorThemeData copyWith({
    Color? backgroundColor,
  }) {
    return ChatColorThemeData(
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }
}

/// The layout theme data for the chat.
class ChatLayoutThemeData {
  /// The constructor for the chat layout theme data.
  const ChatLayoutThemeData({
    this.chatViewPadding = const EdgeInsets.all(16),
    this.userAvatarSize = 36,
    this.avatarAndMessageSpacing = 8,
    this.failedToSendTextStyle = const TextStyle(
      fontSize: 11,
      color: Color(0xFFFF3B30),
      fontWeight: FontWeight.w400,
      height: 1.545,
    ),
  });

  /// The chat view padding.
  final EdgeInsets chatViewPadding;

  /// The user avatar size.
  final double userAvatarSize;

  /// The avatar and message spacing.
  final double avatarAndMessageSpacing;

  /// The failed to send text style.
  final TextStyle failedToSendTextStyle;
}
