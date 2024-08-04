import 'package:flutter/material.dart';

class MyAlertDialogue extends StatelessWidget {
  final String title;
  final String content;
  final String buttonText;
  final VoidCallback? onButtonPressed;

  const MyAlertDialogue({
    super.key,
    required this.title,
    required this.content,
    required this.buttonText,
    this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        ElevatedButton(
          onPressed: onButtonPressed ?? () => Navigator.of(context).pop(),
          child: Text(buttonText,
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary
          )
          ),
        ),
      ],
    );
  }
}
