import 'package:flutter/material.dart';
import 'package:invoice/functions/core_function.dart' show t;
import 'package:invoice/states/global_form_state.dart';
import 'package:invoice/widgets/global/form/text_form_field_widget.dart';

class CategoryNameFieldWidget extends StatelessWidget {
  
  final String? existsError;

  const CategoryNameFieldWidget(this.existsError, {super.key});

  String? _validator(BuildContext context, String? value) => value!.isEmpty ? t(context).requiredField : null;

  @override
  Widget build(BuildContext context) {
    GlobalFormState globalFormState = getGlobalFormState(context, listen: false);
    Map<String, dynamic> formData = globalFormState.formData;

    return Column(
      children: [
        TextFormFieldWidget(
          initialValue: formData['name'],
          label: t(context).categoryName,
          counter: const Offstage(),
          textInputAction: TextInputAction.done,
          maxLength: 16,
          onSaved: (String? value) => globalFormState.changeFormData('name', value),
          validator: (String? value) => _validator(context, value),
          errorText: existsError
        ),
        const SizedBox(height: 20.0),
      ],
    );
  }
}
