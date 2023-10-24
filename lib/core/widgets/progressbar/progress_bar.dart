import 'package:flutter/material.dart';

class ProgressBar extends StatefulWidget {
  const ProgressBar({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _ProgressBarState createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  double _progressValue = 0.5; // Initial progress value (from 0.0 to 1.0)

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
              width: MediaQuery.of(context).size.width - 32, // Set width according to your preference
              decoration: BoxDecoration(
                color: Colors.grey[300], // Background color of the progress bar
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Positioned(
              left: 0,
              child: Container(
                height: 20,
                width: (_progressValue * (MediaQuery.of(context).size.width - 32)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    image: AssetImage('assets/experience_orb.gif'), // Image to fill the progress blocks
                    fit: BoxFit.none,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _progressValue += 0.1;
              if (_progressValue > 1.0) {
                _progressValue = 0.0;
              }
            });
          },
          child: const Text('Increase Progress'),
        ),
      ],
    );
  }
}
