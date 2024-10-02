import 'package:flutter/material.dart';

extension ThemedContextExtension on BuildContext {
  EasyChatColorThemeData get coloredTheme {
    final brightness = MediaQuery.of(this).platformBrightness;
    final chatTheme = EasyChatTheme.of(this);
    return brightness == Brightness.light ? chatTheme.light : chatTheme.dark;
  }

  EasyChatLayoutThemeData get layoutTheme {
    final chatTheme = EasyChatTheme.of(this);
    return chatTheme.layout;
  }
}

class EasyChatTheme extends InheritedWidget {
  const EasyChatTheme({
    super.key,
    required this.data,
    required super.child,
  });

  final EasyChatThemeData data;

  static EasyChatThemeData of(BuildContext context) {
    final EasyChatTheme? theme = context.dependOnInheritedWidgetOfExactType<EasyChatTheme>();
    return theme?.data ??
        EasyChatThemeData(
          light: EasyChatColorThemeData.light,
          dark: EasyChatColorThemeData.dark,
        );
  }

  @override
  bool updateShouldNotify(EasyChatTheme oldWidget) {
    return data != oldWidget.data;
  }
}

class EasyChatThemeData {
  EasyChatThemeData({
    required this.light,
    required this.dark,
    this.layout = const EasyChatLayoutThemeData(),
  });
  EasyChatColorThemeData light;
  EasyChatColorThemeData dark;
  EasyChatLayoutThemeData layout;
}

class EasyChatColorThemeData {
  static EasyChatColorThemeData get light => EasyChatColorThemeData();
  static EasyChatColorThemeData get dark => EasyChatColorThemeData();

  final Color backgroundColor;
  final Color inputBoxColor;
  final Color myMessageColor;
  final Color otherMessageColor;
  final Color primary;
  EasyChatColorThemeData({
    this.backgroundColor = const Color(0xFFF5F5F5),
    this.inputBoxColor = Colors.white,
    this.myMessageColor = const Color(0xFFE5E5EA),
    this.otherMessageColor = Colors.white,
    this.primary = const Color(0xFFF86526),
  });

  EasyChatColorThemeData copyWith({
    Color? backgroundColor,
  }) {
    return EasyChatColorThemeData(
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }
}

class EasyChatLayoutThemeData {
  const EasyChatLayoutThemeData({
    this.chatViewPadding = const EdgeInsets.all(16),
    this.userAvatarSize = 36,
    this.avatarAndMessageSpacing = 8,
  });
  final EdgeInsets chatViewPadding;
  final double userAvatarSize;
  final double avatarAndMessageSpacing;
}
