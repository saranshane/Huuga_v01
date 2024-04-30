import 'package:flutter/material.dart';

class OnboardContent extends StatelessWidget {
  const OnboardContent({
    Key? key,
    required this.image,
    required this.title,
    required this.text,
  }) : super(key: key);

  final String? image, title, text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: AspectRatio(
            aspectRatio: 1,
            child:
                Image.asset(image!), // Corrected to access the image property
          ),
        ),
        const SizedBox(height: 16),
        Text(
          title!,
          style: TextStyle(
            fontSize: 24, // Example font size
            fontWeight: FontWeight.bold, // Example font weight
            // You can add more properties such as color, etc.
          ),
        ),
        const SizedBox(height: 8),
        Text(
          text!,
          style: TextStyle(
            fontSize: 16, // Example font size
            // You can add more properties such as color, etc.
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
