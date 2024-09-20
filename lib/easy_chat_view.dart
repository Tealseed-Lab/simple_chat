import 'package:flutter/material.dart';

class EasyChatView extends StatefulWidget {
  const EasyChatView({
    super.key,
  });
  @override
  State<StatefulWidget> createState() {
    return _EasyChatViewState();
  }
}

class _EasyChatViewState extends State<EasyChatView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: MediaQuery.of(context).platformBrightness == Brightness.light ? Colors.red : Colors.blue,
    );
    //   return EasyChatTheme(
    //     data: EasyChatThemeData(
    //       light: EasyChatColorThemeData.light.copyWith(
    //         backgroundColor: Colors.black,
    //       ),
    //       dark: EasyChatColorThemeData.dark.copyWith(
    //         backgroundColor: Colors.white,
    //       ),
    //     ),
    //     child: Builder(
    //       builder: (context) => Container(
    //         color: context.coloredTheme.backgroundColor,
    //       ),
    //     ),
    //   );
  }
}
