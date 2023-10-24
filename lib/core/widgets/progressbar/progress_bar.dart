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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Stack(
          alignment: Alignment.centerLeft,
          children: <Widget>[
            Container(
              height: 20,
              width: MediaQuery.of(context).size.width -
                  32, // Set width according to your preference
              decoration: BoxDecoration(
                color: Colors.grey[300], // Background color of the progress bar
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Positioned(
              left: 0,
              child: Container(
                height: 20,
                width: (widget.progressBarController.value *
                    (MediaQuery.of(context).size.width - 32)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    image: AssetImage('assets/background.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
