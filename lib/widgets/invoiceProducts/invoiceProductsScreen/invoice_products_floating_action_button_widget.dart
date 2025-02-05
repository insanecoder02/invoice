import 'package:flutter/material.dart';
import 'package:invoice/constans/enums.dart';
import 'package:invoice/functions/core_function.dart';
import 'package:invoice/states/global_form_state.dart';

class InvoiceProductsFloatingActionButtonWidget extends StatelessWidget {
  
  const InvoiceProductsFloatingActionButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: DateTime.now().microsecondsSinceEpoch,
      child: const Icon(Icons.add),
      onPressed: () {
        GlobalFormState globalFormState =  getGlobalFormState(context, listen: false);
        globalFormState.setFormMode(FormMode.create);
        globalFormState.setFormData({...globalFormState.invoiceProductsInitialValues});
        navigatorByPushNamed(context, '/invoice/products/form');
      }
    );
  }
}
