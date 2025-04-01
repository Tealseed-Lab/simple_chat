import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:simple_chat/simple_chat.dart';

/// The user avatar for the chat.
class UserAvatar extends StatelessWidget {
  /// The constructor for the user avatar.
  const UserAvatar({
    super.key,
    required this.user,
    this.onTap,
  });

  /// The user.
  final ModelBaseUser? user;

  /// The on tap callback.
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final avatarUrl = user?.avatarUrl;
    Widget child;
    if (avatarUrl == null) {
      child = _EmptyProfileAvatar(
          size: context.layoutTheme.userAvatarSize, name: user?.name);
    } else if (avatarUrl.contains('http')) {
      child = Image.network(
        avatarUrl,
        width: context.layoutTheme.userAvatarSize,
        height: context.layoutTheme.userAvatarSize,
        fit: BoxFit.cover,
      );
    } else if (avatarUrl.contains('svg')) {
      child = SvgPicture.asset(
        avatarUrl,
        width: context.layoutTheme.userAvatarSize,
        height: context.layoutTheme.userAvatarSize,
        fit: BoxFit.cover,
      );
    } else {
      child = Image.asset(
        avatarUrl,
        width: context.layoutTheme.userAvatarSize,
        height: context.layoutTheme.userAvatarSize,
        fit: BoxFit.cover,
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius:
            BorderRadius.circular(context.layoutTheme.userAvatarSize / 2),
        child: child,
      ),
    );
  }
}

class _EmptyProfileAvatar extends StatelessWidget {
  final double size;
  final String? name;
  const _EmptyProfileAvatar({
    required this.size,
    this.name,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size / 2),
        color: context.coloredTheme.primary,
      ),
      child: Text(
        name == null || name!.isEmpty ? '' : name!.substring(0, 1),
        style: TextStyle(
          fontSize: 20 * size / 46,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
