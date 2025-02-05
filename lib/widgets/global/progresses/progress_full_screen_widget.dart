import 'package:flutter/material.dart';

class ProgressFullScreenWidget extends StatelessWidget {
  
  final double width;
  final Color? color;
  final bool center;
  final bool expanded;

  const ProgressFullScreenWidget({
    super.key,
    this.width = 4.0,
    this.color,
    this.center = false,
    this.expanded = false
  });

  const ProgressFullScreenWidget.center({
    super.key,
    this.width = 4.0,
    this.color,
    this.center = true,
    this.expanded = false
  });

  Widget progress(BuildContext context) => CircularProgressIndicator(
    color: color ?? Theme.of(context).indicatorColor,
    strokeWidth: width
  );

  @override
  Widget build(BuildContext context) {
    return center && expanded
      ? Expanded(child: Center(child: progress(context)))
      : center
        ? Center(child: progress(context))
        : progress(context);
  }
}
