import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:invoice/config.dart';
import 'package:invoice/constans/enums.dart';
import 'package:invoice/functions/core_function.dart' show t;
import 'package:invoice/models/category_model.dart';
import 'package:invoice/states/category_state.dart';
import 'package:invoice/states/global_form_state.dart';
import 'package:invoice/widgets/global/form/text_form_field_widget.dart';
import 'package:invoice/plugins/custom_text_input_formatter_plugin.dart';

class ProductTextFormFieldsWidget extends StatefulWidget {

  final String? codeExistsError;

  final String? nameExistsError;

  const ProductTextFormFieldsWidget(this.codeExistsError, this.nameExistsError, {super.key});

  @override
  State<ProductTextFormFieldsWidget> createState() => _ProductTextFormFieldsWidgetState();
}

class _ProductTextFormFieldsWidgetState extends State<ProductTextFormFieldsWidget> {

  List<String> units= ['gram', 'cc'];
  String? _categorySelected;
  String? _unitSelected;

  @override
  void initState() {
    super.initState();
    _initialDataForEditForm();
  }

  void _initialDataForEditForm() {
    GlobalFormState globalFormState = getGlobalFormState(context, listen: false);
    if(globalFormState.formMode == FormMode.update) {
      _categorySelected = globalFormState.formData['categoryId'].toString();
      _unitSelected = globalFormState.formData['unit'].toString();
    }
  }

  String? _validator(BuildContext context, String? value) => value != null ? value.isEmpty ? t(context).requiredField : null : t(context).requiredField;

  @override
  Widget build(BuildContext context) {
    List<CategoryModel> categories = getCategoryState(context, listen: false).categories;
    GlobalFormState globalFormState = getGlobalFormState(context, listen: false);
    Map<String, dynamic> formData = globalFormState.formData;

    return Column(
      children: [
        DropdownButtonFormField(
          borderRadius: BorderRadius.circular(Config.borderRadius),
          decoration: InputDecoration(labelText: t(context).productCategory, helperText: ''),
          value: _categorySelected,
          items: categories.map<DropdownMenuItem<String>>((CategoryModel category) => DropdownMenuItem<String>(
            value: category.id.toString(),
            child: Text(category.name),
          )).toList(),
          onSaved: (String? value) => globalFormState.changeFormData('categoryId', value),
          validator: (String? value) => _validator(context, value),
          onChanged: (String? value) => setState(() => _categorySelected = value),
        ),
        const SizedBox(height: 20.0),
        TextFormFieldWidget(
          initialValue: formData['code'].toString(),
          label: t(context).productCode,
          counter: const Offstage(),
          maxLength: 16,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.left,
          onSaved: (String? value) => globalFormState.changeFormData('code', value),
          validator: (String? value) => _validator(context, value),
          errorText: widget.codeExistsError
        ),
        const SizedBox(height: 20.0),
        TextFormFieldWidget(
          initialValue: formData['name'],
          label: t(context).productName,
          counter: const Offstage(),
          maxLength: 64,
          onSaved: (String? value) => globalFormState.changeFormData('name', value),
          validator: (String? value) => _validator(context, value),
          errorText: widget.nameExistsError
        ),
        const SizedBox(height: 20.0),
        Row(
          children: [
            Expanded(
              child: TextFormFieldWidget(
                initialValue: formData['volume'].toString(),
                label: t(context).productVolume,
                counter: const Offstage(),
                maxLength: 8,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.left,
                onSaved: (String? value) => globalFormState.changeFormData('volume', value),
                validator: (String? value) => _validator(context, value),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: DropdownButtonFormField(
                borderRadius: BorderRadius.circular(Config.borderRadius),
                decoration: InputDecoration(labelText: t(context).volumeUnit, helperText: ''),
                value: _unitSelected,
                items: units.map<DropdownMenuItem<String>>((String unit) => DropdownMenuItem<String>(
                  value: units.indexWhere((item) => item == unit).toString(),
                  child: Text(unit == 'gram' ? t(context).gram : t(context).cc),
                )).toList(),
                onSaved: (String? value) => globalFormState.changeFormData('unit', value),
                validator: (String? value) => _validator(context, value),
                onChanged: (String? value) => setState(() => _unitSelected = value),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20.0),
        TextFormFieldWidget(
          initialValue: formData['quantityInBox'].toString(),
          label: t(context).quantityInBox,
          counter: const Offstage(),
          maxLength: 3,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.left,
          onSaved: (String? value) => globalFormState.changeFormData('quantityInBox', value),
          validator: (String? value) => _validator(context, value),
        ),
        const SizedBox(height: 20.0),
        TextFormFieldWidget(
          initialValue: formData['price'].toString().seRagham(),
          label: t(context).productPrice,
          counter: const Offstage(),
          maxLength: 9,
          textAlign: TextAlign.left,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.number,
          onSaved: (String? value) => globalFormState.changeFormData('price', value),
          validator: (String? value) => _validator(context, value),
          inputFormatters: [CustomTextInputFormatterPlugin()],
        ),
      ],
    );
  }
}
