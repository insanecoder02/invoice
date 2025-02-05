import 'package:flutter/material.dart';
import 'package:invoice/widgets/global/bottomNavigationBar/bottom_navigation_bar_item_widget.dart';

class BottomNavigationBarWidget extends StatelessWidget {

  final List<BottomNavigationBarItemWidget> items;

  const BottomNavigationBarWidget({
    super.key,
    required this.items
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.0,
      color: Theme.of(context).colorScheme.background,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: items,
      ),
    );
  }
}
