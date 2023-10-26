import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,
    required this.label,
    this.onPressed,
  }) : super(key: key);

  final String label;

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 150, // Set the width according to your button size
        height: 50, // Set the height according to your button size
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/mine_button.png'), // Your Minecraft-style button image
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Text(
            label, // Button text
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );

    // return Column(children: [
    //   ElevatedButton(
    //     onPressed: onPressed,
    //     child: Text(
    //       label,
    //       style: const TextStyle(color: Colors.white),
    //     ),
    //   ),
    // ]);
  }
}
