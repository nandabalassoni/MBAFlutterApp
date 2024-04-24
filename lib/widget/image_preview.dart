import 'dart:io';

import 'package:flutter/material.dart';

class ImagePreview extends StatelessWidget {
  String path;

  ImagePreview(this.path, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Image.file(
        File(
          path,
        ),
      ),
    );
  }
}
