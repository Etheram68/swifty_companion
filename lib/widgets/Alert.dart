import 'package:flutter/material.dart';

class Alert {
  static void showError(BuildContext context, String message) {
    final content = Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.cancel_outlined, color: Colors.white),
        const Text(" Error: "),
        Text(message)
      ],
    );
    final snackbar = SnackBar(
      content: content,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  static void showInfo(BuildContext context, String message) {
    final content = Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.announcement_outlined, color: Colors.white),
        const Text("Info: "),
        Text(message)
      ],
    );
    final snackbar = SnackBar(
      content: content,
      backgroundColor: Colors.blue,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}