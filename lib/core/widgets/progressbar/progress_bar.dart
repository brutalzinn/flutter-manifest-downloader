// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:manifest_downloader/core/widgets/progressbar/progress_bar_controller.dart';

class ProgressBar extends StatefulWidget {
  final ProgressBarController progressBarController;
  const ProgressBar({
    Key? key,
    required this.progressBarController,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProgressBarState createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  @override
  void initState() {
    widget.progressBarController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      color: Colors.yellow,
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      value: widget.progressBarController.value,
    );
  }
}
