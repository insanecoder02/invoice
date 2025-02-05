import 'package:flutter/material.dart';
import 'package:invoice/config.dart';
import 'package:invoice/constans/typedefs.dart';
import 'package:invoice/functions/core_function.dart' show t;

class SearchBoxWidget extends StatefulWidget {

  final FocusNode focusNode;
  
  final OnChangeSearchBoxTypedef onChange;

  final Function? onClose;

  const SearchBoxWidget({
    super.key,
    required this.focusNode,
    required this.onChange,
    this.onClose
  });

  @override
  State<SearchBoxWidget> createState() => _SearchBoxWidgetState();
}

class _SearchBoxWidgetState extends State<SearchBoxWidget> {

  final TextEditingController controller = TextEditingController();

  void _onCloseHandler() {
    controller.clear();
    if(widget.onClose != null) {
      widget.onClose!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      alignment: Alignment.center,
      height: 40.0,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(Config.borderRadius)
      ),
      child: Theme(
        data: ThemeData(
          fontFamily: "Vazirmatn",
          inputDecorationTheme: InputDecorationTheme(
            border: InputBorder.none,
            hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary.withOpacity(.3)),
          )
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => widget.focusNode.requestFocus(),
              child: Icon(Icons.search, color: Theme.of(context).colorScheme.primary.withOpacity(.3)),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: TextField(
                controller: controller,
                textInputAction: TextInputAction.search,
                onChanged: (String value) => widget.onChange(value),
                focusNode: widget.focusNode,
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
                autofocus: true,
                decoration: InputDecoration.collapsed(
                  hintText: t(context).search,
                )
              )
            ),
            if(controller.text.isNotEmpty)
            GestureDetector(
              onTap: () => _onCloseHandler(),
              child: Icon(Icons.close, color: Theme.of(context).colorScheme.primary.withOpacity(.3)),
            ),
          ],
        ),
      )
    );
  }
}
