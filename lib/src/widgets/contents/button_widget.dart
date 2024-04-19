import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button(
      {super.key,
      required this.buttonText,
      required this.onPressed,
      required this.textColor,
      required this.backgroundColor,
      required this.disabledBackgroundColor});

  final String buttonText;
  final Color textColor;
  final Color backgroundColor;
  final Color disabledBackgroundColor;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          elevation: 6.0,
          backgroundColor: backgroundColor,
          disabledBackgroundColor: disabledBackgroundColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0))),
      child: Text(
        buttonText,
        style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
      ),
    );
  }
}
