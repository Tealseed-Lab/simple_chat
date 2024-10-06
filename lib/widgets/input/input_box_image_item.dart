import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class InputBoxImageItem extends StatelessWidget {
  final XFile imageFile;
  final double size;
  final bool disabled;
  final void Function(XFile) onTap;
  final void Function(XFile) onRemove;
  const InputBoxImageItem({
    super.key,
    required this.imageFile,
    this.size = 60,
    required this.onTap,
    required this.onRemove,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: GestureDetector(
        onTap: () => onTap(imageFile),
        child: SizedBox(
          width: size,
          height: size,
          child: Stack(
            children: [
              Image.file(
                File(imageFile.path),
                fit: BoxFit.cover,
                width: size,
                height: size,
              ),
              if (!disabled)
                Positioned(
                  top: 3,
                  right: 3,
                  child: GestureDetector(
                    onTap: () => onRemove(imageFile),
                    child: Container(
                      width: 18,
                      height: 18,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
