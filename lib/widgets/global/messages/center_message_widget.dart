import 'package:flutter/material.dart';

class CenterMessageWidget extends StatelessWidget {

  final String message;
  final String subMessage;
  final bool expanded;

  const CenterMessageWidget({
    super.key,
    required this.message,
    this.subMessage = '',
    this.expanded = false
  });

  Center centerMessageWidget(BuildContext context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(message, style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 5.0),
        Text(subMessage, style: Theme.of(context).textTheme.headlineSmall)
      ],
    )
  );

  @override
  Widget build(BuildContext context) {
    return expanded 
      ? Expanded(child: centerMessageWidget(context)) 
      : centerMessageWidget(context);
  }
}
