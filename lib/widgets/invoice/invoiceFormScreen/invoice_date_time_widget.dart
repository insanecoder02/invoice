import 'package:flutter/material.dart';
import 'package:invoice/config.dart';
import 'package:invoice/functions/core_function.dart' show t, isRTL, switchColor;
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:intl/intl.dart';
import 'package:invoice/states/global_form_state.dart';

class InvoiceDateTimeWidget extends StatelessWidget {

  const InvoiceDateTimeWidget({super.key});

  _changeDateTimeHandler(context) async {
    DateTime? dateTime = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(DateTime.now().year - 1, 1, 1), lastDate: DateTime.now());
    if(dateTime != null) {
      getGlobalFormState(context, listen: false).changeFormData('createdAt', dateTime.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    GlobalFormState globalFormState = getGlobalFormState(context);
    Map<String, dynamic> formData = globalFormState.formData;

    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(left: isRTL(context) ? 0 : 10.0, right: isRTL(context) ? 10.0 : 0, top: 6.0, bottom: 6.0),
          margin: const EdgeInsets.only(top: 7.0, bottom: 32.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Config.borderRadius),
            border: Border.all(
              color: switchColor(context, light: Theme.of(context).colorScheme.primary.withOpacity(.3), dark: Theme.of(context).colorScheme.primary.withOpacity(.2)),
              width: Config.widthBorder
            )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isRTL(context)
                ? DateTime.parse(formData.containsKey('createdAt') ? formData['createdAt'] : DateTime.now().toString()).toPersianDateStr()
                : DateFormat("dd MMM y").format(DateTime.parse(formData.containsKey('createdAt') ? formData['createdAt'] : DateTime.now().toString())),
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w500),
              ),
              IconButton(
                icon: const Icon(Icons.edit_calendar),
                onPressed: () => _changeDateTimeHandler(context)
              )
            ]
          ),
        ),
        Container(
          color: Theme.of(context).colorScheme.background,
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Text(t(context).invoiceDate, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 12.0, fontWeight: FontWeight.normal))
        )
      ],
    );
  }
}
