import 'package:flutter/material.dart';
import 'package:invoice/functions/core_function.dart' show t;
import 'package:invoice/config.dart';
import 'package:invoice/constans/enums.dart';

Widget featuresAppWidget({required FeaturesApp feature, required Widget child}) => Config.features.contains(feature) ? child : const SizedBox();

dynamic showSnackBarWidget(
    BuildContext context, {
      required Widget content,
      Duration duration = const Duration(minutes: 3),
      String? actionLabel,
      Function? onPressed,
      EdgeInsets? margin
    }
  ) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      margin: margin ?? const EdgeInsets.only(bottom: 20.0, right: 20.0, left: 20.0),
      duration: duration,
      content: content,
      dismissDirection: DismissDirection.horizontal,
      action: SnackBarAction(
        label: (actionLabel != null) ? actionLabel : t(context).iUnderstand,
        onPressed: () => (onPressed != null) ? onPressed() : ScaffoldMessenger.of(context).hideCurrentSnackBar(),
      ),
    )
  );
}

Future<bool> showDialogWidget(
  BuildContext context, {
    Alignment alignment = Alignment.bottomCenter,
    MainAxisAlignment actionAlignment = MainAxisAlignment.center,
    Widget? title,
    Widget? content,
    List<Widget>? actions
  }
) async {
  return await showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      alignment: alignment,
      actionsAlignment: actionAlignment,
      title: title,
      content: content,
      actions: actions,
    )
  ) ?? false;
}

dynamic showModalBottomSheetWidget(
  BuildContext context,
  {
    double initialChildSize = .5,
    double? maxChildSize,
    double? minChildSize,
    Function? setState,
    required Widget content
  }
) {
  showModalBottomSheet(
    useSafeArea: true,
    isScrollControlled: true,
    context: context,
    backgroundColor: Colors.transparent,
    /*constraints: const BoxConstraints(
      minWidth: double.infinity,
      maxWidth: double.infinity,
    ),*/
    builder: (BuildContext context) => Container(
      height: initialChildSize == 1 ? MediaQuery.of(context).size.height - 85 : null,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0))
      ),
      child: DraggableScrollableSheet(
        expand: false,
        key: UniqueKey(),
        initialChildSize: initialChildSize ,
        maxChildSize: maxChildSize ?? initialChildSize,
        minChildSize: minChildSize ?? initialChildSize,
        builder: (context, controller) => Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 30.0,
              child: Container(
                height: 4.0, width: 30.0,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(1.0)
                ),
              )
            ),
            Expanded(
              child: content
            ),
          ],
        ),
      )
    ),
  );
}
