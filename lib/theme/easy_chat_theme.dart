import 'package:flutter/material.dart';

extension ThemedContextExtension on BuildContext {
  EasyChatColorThemeData get coloredTheme {
    final brightness = MediaQuery.of(this).platformBrightness;
    final chatTheme = EasyChatTheme.of(this);
    return brightness == Brightness.light ? chatTheme.light : chatTheme.dark;
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
  });
  EasyChatColorThemeData light;
  EasyChatColorThemeData dark;
}

class EasyChatColorThemeData {
  static EasyChatColorThemeData get light => EasyChatColorThemeData();
  static EasyChatColorThemeData get dark => EasyChatColorThemeData();

  final Color backgroundColor;
  EasyChatColorThemeData({
    this.backgroundColor = Colors.white,
  });

  EasyChatColorThemeData copyWith({
    Color? backgroundColor,
  }) {
    return EasyChatColorThemeData(
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }
}
