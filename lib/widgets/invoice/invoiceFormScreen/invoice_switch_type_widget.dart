import 'package:flutter/material.dart';
import 'package:invoice/functions/core_function.dart' show t;
import 'package:invoice/states/global_form_state.dart';
import 'package:invoice/widgets/global/form/switch_widget.dart';

class InvoiceSwitchTypeWidget extends StatelessWidget {

  const InvoiceSwitchTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    bool type = getGlobalFormState(context).formData['type'] == 1;

    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
      child: Row(
        children: [
          SwitchWidget(
            value: type,
            onChanged: (bool value) => getGlobalFormState(context, listen: false).changeFormData('type', value ? 1 : 0)
          ),
          const SizedBox(width: 20),
          Text(type ? t(context).invoice : t(context).preinvoice, style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w500))
        ],
      )
    );
  }
}
