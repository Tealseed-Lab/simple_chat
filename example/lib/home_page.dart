import 'package:easy_chat/easy_chat.dart';
import 'package:flutter/material.dart';
import 'dart:math'; // Added import for Random

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

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> setupTests() async {
    await injectUsers();
  }

  Future<void> injectUsers() async {
    await controller.store.addUsers(users: [
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

  Future<void> injectMessages({required bool withDelay}) async {
    final random = Random();
    for (var i = 0; i < 100; i++) {
      if (withDelay) {
        await Future.delayed(const Duration(milliseconds: 1000));
      }
      final userId = random.nextBool() ? '1' : '2';
      final textLength = random.nextInt(50) + 10; // Random length between 10 and 59
      await controller.store.addMessage(
        isInitial: !withDelay,
        message: ModelTextMessage(
          id: '$i',
          text: generateRandomText(textLength),
          userId: userId,
          sequence: i,
          displayDatetime: DateTime.now(),
        ),
      );
    }
  }

  String generateRandomText(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789 ';
    final random = Random();
    return String.fromCharCodes(Iterable.generate(length, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
  }

  @override
  Widget build(BuildContext context) {
    final coloredThemeData = EasyChatColorThemeData();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              switch (value) {
                case 'scroll_top':
                  controller.chatScrollController.scrollToTop();
                  break;
                case 'scroll_bottom':
                  controller.chatScrollController.scrollToBottom();
                  break;
                case 'inject_messages':
                  injectMessages(withDelay: false);
                  break;
                case 'inject_messages_delay':
                  injectMessages(withDelay: true);
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'scroll_top',
                child: ListTile(
                  leading: Icon(Icons.arrow_upward),
                  title: Text('Scroll to Top'),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'scroll_bottom',
                child: ListTile(
                  leading: Icon(Icons.arrow_downward),
                  title: Text('Scroll to Bottom'),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'inject_messages',
                child: ListTile(
                  leading: Icon(Icons.message),
                  title: Text('Inject Messages'),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'inject_messages_delay',
                child: ListTile(
                  leading: Icon(Icons.auto_awesome),
                  title: Text('Inject Messages with Delay'),
                ),
              ),
            ],
          ),
        ],
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
