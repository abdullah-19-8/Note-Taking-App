import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message,
    {bool isError = false}) {
  ScaffoldMessenger.of(context).clearSnackBars();
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
