import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color? disabledColor;
  final Color splashColor;
  final Function()? onPressed;

  const ActionButton(
      {super.key,
      required this.icon,
      required this.iconColor,
      this.disabledColor,
      required this.splashColor,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        disabledColor: disabledColor,
        onPressed: onPressed,
        splashRadius: 20.0,
        splashColor: splashColor,
        icon: Icon(
          icon,
          color: iconColor,
        ));
  }
}
