import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class HeartAnimation extends StatelessWidget {

  final Animation<double> controller;
  final Animation<Alignment> _alignment;
  final Animation<double> _opacity;

  HeartAnimation({Key? key, required this.controller}):
    _alignment = Tween(begin: Alignment.topCenter, end: Alignment.bottomCenter).animate(CurvedAnimation(parent: controller, curve: const Interval(0, 1.0, curve: Curves.linear))),
    _opacity = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(parent: controller, curve: const Interval(.5, 1.0, curve: Curves.linear))),
    super(key: key);

  Widget _animationBuilder(BuildContext context, Widget? child) {
    return Container(
      alignment: _alignment.value,
      child: Icon(Icons.favorite, size: 130.0, color: Colors.red.shade500.withOpacity(_opacity.value))
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
