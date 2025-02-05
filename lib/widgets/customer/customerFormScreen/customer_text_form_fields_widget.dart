import 'package:flutter/material.dart';
import 'package:invoice/functions/core_function.dart' show t;
import 'package:invoice/states/global_form_state.dart';
import 'package:invoice/widgets/global/form/text_form_field_widget.dart';

class CustomerTextFormFieldsWidget extends StatelessWidget {
  
  final String? existsError;

  const CustomerTextFormFieldsWidget(this.existsError, {super.key});

  String? _validator(BuildContext context, String? value, int? length) => value!.isEmpty ? t(context).requiredField : length != null && value.length != length ? t(context).invalidLengthField : null;

  @override
  Widget build(BuildContext context) {
    GlobalFormState globalFormState = getGlobalFormState(context, listen: false);
    Map<String, dynamic> formData = globalFormState.formData;

    return Column(
      children: [
        TextFormFieldWidget(
          initialValue: formData['nationalCode'].toString(),
          label: t(context).nationalCode,
          counter: const Offstage(),
          maxLength: 10,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.left,
          onSaved: (String? value) => globalFormState.changeFormData('nationalCode', value),
          validator: (String? value) => _validator(context, value, 10),
          errorText: existsError
        ),
        const SizedBox(height: 20.0),
        TextFormFieldWidget(
          initialValue: formData['name'],
          label: t(context).name,
          counter: const Offstage(),
          maxLength: 32,
          onSaved: (String? value) => globalFormState.changeFormData('name', value),
          validator: (String? value) => _validator(context, value, null),
        ),
        const SizedBox(height: 20.0),
        TextFormFieldWidget(
          initialValue: formData['phone'].toString(),
          label: t(context).phone,
          counter: const Offstage(),
          maxLength: 11,
          keyboardType: TextInputType.phone,
          textAlign: TextAlign.left,
          onSaved: (String? value) => globalFormState.changeFormData('phone', value),
          validator: (String? value) => _validator(context, value, 11),
        ),
        const SizedBox(height: 20.0),
        TextFormFieldWidget(
          initialValue: formData['address'],
          label: t(context).address,
          textInputAction: TextInputAction.done,
          maxLength: 64,
          onSaved: (String? value) => globalFormState.changeFormData('address', value),
          validator: (String? value) => _validator(context, value, null),
        ),
      ],
    );
  }
}
