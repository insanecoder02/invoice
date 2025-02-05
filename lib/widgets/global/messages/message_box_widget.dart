import 'package:flutter/material.dart';

class MessageBoxWidget extends StatelessWidget {

  final String message;
  final Color? backgoundColor;
  final Color? foregroundColor;

  const MessageBoxWidget(this.message, {
    super.key,
    this.backgoundColor,
    this.foregroundColor
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: backgoundColor ?? Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(15.0)
      ),
      padding: const EdgeInsets.all(20.0),
      child: Text(message, style: TextStyle(color: foregroundColor))
    );
  }
}
