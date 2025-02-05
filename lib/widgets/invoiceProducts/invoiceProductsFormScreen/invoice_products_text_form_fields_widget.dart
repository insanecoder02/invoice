import 'package:flutter/material.dart';
import 'package:invoice/functions/core_function.dart' show t, isRTL, navigatorByPushNamed;
import 'package:invoice/models/category_model.dart';
import 'package:invoice/models/product_model.dart';
import 'package:invoice/plugins/custom_text_input_formatter_plugin.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:invoice/states/category_state.dart';
import 'package:invoice/states/global_form_state.dart';
import 'package:invoice/states/product_state.dart';
import 'package:invoice/widgets/global/form/text_form_field_widget.dart';
import 'package:invoice/widgets/invoiceProducts/invoiceProductsFormScreen/invoice_product_information_widget.dart';

class InvoiceProductsTextFormFieldsWidget extends StatefulWidget {
  
  final String? existsError;

  const InvoiceProductsTextFormFieldsWidget(this.existsError, {super.key});

  @override
  State<InvoiceProductsTextFormFieldsWidget> createState() => _InvoiceProductsTextFormFieldsWidgetState();
}

class _InvoiceProductsTextFormFieldsWidgetState extends State<InvoiceProductsTextFormFieldsWidget> {

  TextEditingController codeController = TextEditingController();

  TextEditingController priceController = TextEditingController();

  // final FocusNode priceEachFocusNode = FocusNode();

  Map<String, dynamic> productInformation = {};

  late final List<ProductModel> products;

  late final List<CategoryModel> categories;

  @override
  void initState() {
    super.initState();
    products = getProductState(context, listen: false).products;
    categories = getCategoryState(context, listen: false).categories;
    Map<String, dynamic> formData = getGlobalFormState(context, listen: false).formData;
    _onChangedHandler(formData['productCode']);
    codeController.text = formData['productCode'] ?? '';
    priceController.text = formData['productPriceEach'].toString().seRagham();
  }

  String? _validator(BuildContext context, String? value) => value != null ? value.isEmpty ? t(context).requiredField : null : t(context).requiredField;

  void _onChangedHandler(String? value) {
    List<ProductModel> result = products.where((product) => product.code == value).toList();
    Map<String, dynamic> formData = getGlobalFormState(context, listen: false).formData;

    if(result.isNotEmpty) {
      formData["productId"] = result.first.id;

      productInformation['categoryName'] = categories.where((category) => category.id == result.first.categoryId).first.name;
      productInformation['name'] = result.first.name;
      formData["productVolumeEach"] = productInformation['volume'] = result.first.volume;
      productInformation['unit'] = result.first.unit;
      productInformation['quantityInBox'] = result.first.quantityInBox;
      productInformation['price'] = result.first.price;
    } else {
      productInformation = {};
      formData.remove('productId');
      formData.remove('productCode');
      // formData["quantityOfBoxes"] = '';
    }

    setState(() {});
  }

  void _redirectToProductSearch(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    navigatorByPushNamed(context, '/product/search').then((product) {
      _onChangedHandler((product as ProductModel).code);
      codeController.text = product.code;
      priceController.text = product.price.toString().seRagham();
      // priceEachFocusNode.requestFocus();
      //  SystemChannels.textInput.invokeMethod('TextInput.hide');
    });
  }

  @override
  Widget build(BuildContext context) {
    GlobalFormState globalFormState = getGlobalFormState(context, listen: false);
    Map<String, dynamic> formData = globalFormState.formData;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: isRTL(context) ? 20.0 : 5.0, right: !isRTL(context) ? 20.0 : 5.0),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 25.0, left: isRTL(context) ? 1.0: 0, right: !isRTL(context) ? 1.0 : 0),
                child: IconButton(
                  icon: const Icon(Icons.manage_search, size: 30.0),
                  onPressed: () => _redirectToProductSearch(context),
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    TextFormFieldWidget(
                      // initialValue: formData['productCode'],
                      controller: codeController,
                      label: t(context).productCode,
                      counter: const Offstage(),
                      maxLength: 16,
                      textInputAction: productInformation.isNotEmpty ? TextInputAction.done : null,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.left,
                      onSaved: (String? value) => globalFormState.changeFormData('productCode', value),
                      validator: (String? value) => _validator(context, value),
                      onChanged: (String? value) => _onChangedHandler(value),
                      errorText: widget.existsError
                    ),
                    if(productInformation.isNotEmpty)
                    Positioned(
                      top: 20.0, right: 10.0,
                      child: Icon(Icons.verified, color: Colors.green.shade700),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 20.0),
        if(productInformation.isNotEmpty)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              InvoiceProductInformationWidget(productInformation),
              TextFormFieldWidget(
                // focusNode: priceEachFocusNode,
                // initialValue: formData['productPriceEach'].toString(),
                controller: priceController,
                label: t(context).priceEach,
                counter: const Offstage(),
                maxLength: 9,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                helperText: t(context).helperTextforPrice,
                textAlign: TextAlign.left,
                onSaved: (String? value) => globalFormState.changeFormData('productPriceEach', value),
                validator: (String? value) => _validator(context, value),
                inputFormatters: [CustomTextInputFormatterPlugin()],
              ),
              const SizedBox(height: 30.0),
              TextFormFieldWidget(
                initialValue: formData['quantityOfBoxes'].toString(),
                label: t(context).quantityOfBoxes,
                counter: const Offstage(),
                maxLength: 3,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                textAlign: TextAlign.left,
                onSaved: (String? value) => globalFormState.changeFormData('quantityOfBoxes', value),
                validator: (String? value) => _validator(context, value),
              ),
            ],
          ),
        )
      ],
    );
  }
}
