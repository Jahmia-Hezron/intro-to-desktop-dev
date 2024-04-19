import 'package:flutter/material.dart';

import '../utils_export.dart';

class SnackBarUtils {
  static void showSnackbar(
      BuildContext context, IconData icon, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Row(
      children: [
        Icon(icon, color: AppTheme.tertiary),
        const SizedBox(
          width: 10.0,
        ),
        Text(message)
      ],
    )));
  }
}
