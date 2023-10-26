// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:manifest_downloader/core/progress/progress_bar_controller.dart';

class ProgressBar extends StatelessWidget {
  final double value;
  const ProgressBar({
    Key? key,
    required this.value,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      color: Colors.yellow,
      minHeight: 30,
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      value: value,
    );
  }
}
