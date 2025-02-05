import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class SplashAppAnimation extends StatelessWidget {

  final Animation<double> controller;
  final String title;
  final Color? color;
  final Animation<double> _letterSpacing;
  final Animation<double> _opacity;

  SplashAppAnimation({Key? key, required this.controller, required this.title, this.color}):
    _letterSpacing = Tween(begin: 10.0, end: -7.0).animate(CurvedAnimation(parent: controller, curve: const Interval(.5, 1.0, curve: Curves.linear))),
    _opacity = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(parent: controller, curve: const Interval(.5, 1.0, curve: Curves.linear))),
    super(key: key);

  Widget _animationBuilder(BuildContext context, Widget? child) {
    return Text(
      title.toUpperCase(),
      style: TextStyle(
        color: color != null ? color?.withOpacity(_opacity.value) : Theme.of(context).colorScheme.primary.withOpacity(_opacity.value),
        letterSpacing: _letterSpacing.value,
        fontWeight: FontWeight.bold,
        fontSize: 20.0
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = .5;
    return AnimatedBuilder(
      animation: controller,
      builder: _animationBuilder
    );
  }
}
