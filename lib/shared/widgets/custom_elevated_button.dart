import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {Key? key,
      required this.onPressed,
      required this.textButton,
      required this.textColor,
      required this.buttonColor,
      required this.width,
      required this.height})
      : super(key: key);

  final VoidCallback onPressed;
  final String textButton;
  final Color textColor;
  final Color buttonColor;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: Size(width, height),
        primary: buttonColor,
      ),
      child: Text(textButton, style: TextStyle(color: textColor)),
    );
  }
}
