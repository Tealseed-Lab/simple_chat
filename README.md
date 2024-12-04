# Easy Chat

A simple UI solution for quick integration of IM chat.

Suuports customised Message Cell, message grouping, image preview and more.

[<image src="https://i0.wp.com/tealseed.com/wp-content/uploads/2024/08/header.png?resize=2048%2C683&ssl=1" />](https://tealseed.com)

## Supported Platforms

- iOS
- Android

## Example Usage

```dart

final controller = EasyChatController(
    actionHandler: EasyChatActionHandler(
        onSendMessage: (output) async {},
    ),
);

EasyChatView(
    controller: controller,
    theme: EasyChatThemeData(
        dark: coloredThemeData,
        light: coloredThemeData,
    ),
)
```
