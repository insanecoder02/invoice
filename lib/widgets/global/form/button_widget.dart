import 'package:flutter/material.dart';
import 'package:invoice/config.dart';

class ButtonWidget extends StatelessWidget {

  final Widget child;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? borderRadius;
  final bool isLoading;
  final Function onPressed;
  
  const ButtonWidget({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.backgroundColor,
    this.foregroundColor,
    this.borderRadius,
    this.isLoading = false,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isLoading ? .5 : 1,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          maximumSize: Size(width ?? double.infinity, height ?? Config.heightButton)
        ),
        onPressed: () => !isLoading ? onPressed() : null,
        child: ! isLoading ? child : CircularProgressIndicator(color: Config.foregroundDark, strokeAlign: -1),
      )
    );
  }
}
