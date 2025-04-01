import 'package:flutter/material.dart';

extension ThemedContextExtension on BuildContext {
  ChatColorThemeData get coloredTheme {
    final brightness = MediaQuery.of(this).platformBrightness;
    final chatTheme = ChatTheme.of(this);
    return brightness == Brightness.light ? chatTheme.light : chatTheme.dark;
  }

  ChatLayoutThemeData get layoutTheme {
    final chatTheme = ChatTheme.of(this);
    return chatTheme.layout;
  }
}

class ChatTheme extends InheritedWidget {
  const ChatTheme({
    super.key,
    required this.data,
    required super.child,
  });

  final ChatThemeData data;

  static ChatThemeData of(BuildContext context) {
    final ChatTheme? theme =
        context.dependOnInheritedWidgetOfExactType<ChatTheme>();
    return theme?.data ??
        ChatThemeData(
          light: ChatColorThemeData.light,
          dark: ChatColorThemeData.dark,
        );
  }

  @override
  bool updateShouldNotify(ChatTheme oldWidget) {
    return data != oldWidget.data;
  }
}

class ChatThemeData {
  ChatThemeData({
    required this.light,
    required this.dark,
    this.layout = const ChatLayoutThemeData(),
  });
  ChatColorThemeData light;
  ChatColorThemeData dark;
  ChatLayoutThemeData layout;
}

class ChatColorThemeData {
  static ChatColorThemeData get light => ChatColorThemeData();
  static ChatColorThemeData get dark => ChatColorThemeData();

  final Color backgroundColor;
  final Color inputBoxColor;
  final Color myMessageColor;
  final Color otherMessageColor;
  final Color primary;
  final Color unreadIndicatorBackgroundColor;
  final Color sendingIndicatorColor;
  ChatColorThemeData({
    this.backgroundColor = const Color(0xFFF5F5F5),
    this.inputBoxColor = Colors.white,
    this.myMessageColor = const Color(0xFFE5E5EA),
    this.otherMessageColor = Colors.white,
    this.primary = const Color(0xFFF86526),
    this.unreadIndicatorBackgroundColor = Colors.white,
    this.sendingIndicatorColor = const Color(0xFFF86526),
  });

  ChatColorThemeData copyWith({
    Color? backgroundColor,
  }) {
    return ChatColorThemeData(
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }
}

class ChatLayoutThemeData {
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
  final EdgeInsets chatViewPadding;
  final double userAvatarSize;
  final double avatarAndMessageSpacing;
  final TextStyle failedToSendTextStyle;
}
