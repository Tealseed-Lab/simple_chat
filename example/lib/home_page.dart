import 'package:easy_chat/easy_chat.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });
  @override
  State<HomePage> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  final controller = EasyChatController();
  @override
  void initState() {
    super.initState();
    setupTests();
  }

  Future<void> setupTests() async {
    await injectUsers();
    await injectMessages();
  }

  Future<void> injectUsers() async {
    await controller.store.addUsers([
      ModelUser(
        id: '1',
        name: 'Lawrence',
        avatarUrl: 'https://lh3.googleusercontent.com/ogw/AF2bZyj1OQs6QwRQMGfY0H5g_VOdijzbC7Ea3XE3Z8eDYTrOZQ=s64-c-mo',
        isCurrentUser: true,
      ),
      ModelUser(
        id: '2',
        name: 'Ciel',
        avatarUrl: 'https://media.karousell.com/media/photos/profiles/2018/01/09/imwithye_1515485479.jpg',
        isCurrentUser: false,
      ),
    ]);
  }

  Future<void> injectMessages() async {
    for (var i = 0; i < 10; i++) {
      await Future.delayed(const Duration(seconds: 1));
      await controller.store.addMessages([
        ModelTextMessage(
          id: '$i',
          text: 'Hello, how are you? $i',
          userId: i % 2 == 0 ? '1' : '2',
          sequence: i,
          displayDatetime: DateTime.now(),
        ),
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final coloredThemeData = EasyChatColorThemeData();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: EasyChatView(
        controller: controller,
        theme: EasyChatThemeData(
          dark: coloredThemeData,
          light: coloredThemeData,
        ),
      ),
    );
  }
}
