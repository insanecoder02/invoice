import 'package:flutter/material.dart';
import 'package:invoice/config.dart';

class ScrollTopWidget extends StatefulWidget {

  final ScrollController controller;

  const ScrollTopWidget(this.controller, {super.key});

  @override
  State<ScrollTopWidget> createState() => _ScrollTopWidgetState();
}

class _ScrollTopWidgetState extends State<ScrollTopWidget> {

  bool _isVisible = false;

  int _lastTime = 0;

  @override
  void initState() {
    super.initState();

    widget.controller.addListener(() {
      // double maxScroll = widget.controller.position.maxScrollExtent;
      // maxScroll - currentScroll <= 200 && !isLoading

      _lastTime = DateTime.now().second;
      
      double currentScroll = widget.controller.position.pixels;
      currentScroll > 300
        ? setState(() => _isVisible = true)
        : setState(() => _isVisible = false);

      Future.delayed(const Duration(seconds: 2), () {
        if(DateTime.now().second - 2 == _lastTime && currentScroll > 300) {
          setState(() => _isVisible = false);
        }
      });
    });
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void _scrollTopHandler() {
    widget.controller.animateTo(0, duration: const Duration(microseconds: 500), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: Config.brandColor.withOpacity(1))),
      child: Visibility(
        visible: _isVisible,
        child: FloatingActionButton.small(
          heroTag: DateTime.now().microsecondsSinceEpoch,
          onPressed: _scrollTopHandler,
          child: const Icon(Icons.keyboard_arrow_up),
        )
      )
    );
  }
}
