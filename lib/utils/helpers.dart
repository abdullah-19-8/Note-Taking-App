import 'package:flutter/material.dart';

/// Displays a temporary notification at the bottom of the screen, typically used
/// for feedback, messages, or alerts. Clears any existing snack bars before
/// showing the new one to avoid overlapping messages.
void showSnackBar(BuildContext context, String message,
    {bool isError = false}) {
  ScaffoldMessenger.of(context).clearSnackBars(); // Clear existing snack bars
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      message,
      style: TextStyle(
        fontSize: 18,
        color: isError ? Colors.white : Colors.black,
      ),
    ),
    backgroundColor: isError ? Colors.red : Colors.green,
  ));
}
