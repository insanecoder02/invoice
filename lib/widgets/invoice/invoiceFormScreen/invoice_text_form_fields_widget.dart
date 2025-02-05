import 'package:flutter/material.dart';
import 'package:invoice/constans/enums.dart';
import 'package:invoice/functions/core_function.dart' show t;
import 'package:invoice/states/global_form_state.dart';
import 'package:invoice/widgets/global/form/text_form_field_widget.dart';
import 'package:invoice/widgets/invoice/invoiceFormScreen/invoice_date_time_widget.dart';

class InvoiceTextFormFieldsWidget extends StatelessWidget {
  
  const InvoiceTextFormFieldsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalFormState globalFormState = getGlobalFormState(context, listen: false);
    Map<String, dynamic> formData = globalFormState.formData;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          color: Theme.of(context).cardColor,
          child: Text(t(context).discountDescription, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.normal)),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 27.0, right: 20.0),
          child: Column(
            children: [
              TextFormFieldWidget(
                initialValue: formData['cashDiscount'] != 0 ? formData['cashDiscount'].toString() : '',
                label: t(context).cashDiscount,
                counter: const Offstage(),
                maxLength: 2,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.left,
                onSaved: (String? value) => globalFormState.changeFormData('cashDiscount', value),
              ),
              const SizedBox(height: 5.0),
              TextFormFieldWidget(
                initialValue: formData['volumeDiscount'] != 0 ? formData['volumeDiscount'].toString() : '',
                label: t(context).volumeDiscount,
                counter: const Offstage(),
                maxLength: 2,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.left,
                onSaved: (String? value) => globalFormState.changeFormData('volumeDiscount', value),
              ),
              if(globalFormState.formMode == FormMode.update)
              Column(
                children: [
                  const InvoiceDateTimeWidget(),
                  TextFormFieldWidget(
                    initialValue: formData['description'],
                    label: t(context).description,
                    textInputAction: TextInputAction.newline,
                    keyboardType: TextInputType.multiline,
                    minLines: 4,
                    maxLines: 6,
                    maxLength: 512,
                    onSaved: (String? value) => globalFormState.changeFormData('description', value),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
