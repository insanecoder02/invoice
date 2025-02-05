import 'package:flutter/material.dart';
import 'package:invoice/functions/core_function.dart' show t, isRTL, showModalBottomSheetWidget, navigatorByPop, showSnackBarWidget;
import 'package:invoice/models/category_model.dart';
import 'package:invoice/models/product_model.dart';
import 'package:invoice/plugins/invoicePdf/invoice_pdf_plugin.dart';
import 'package:invoice/states/category_state.dart';
import 'package:invoice/states/customer_invoices_state.dart';
import 'package:invoice/states/invoice_products_state.dart';
import 'package:invoice/states/product_state.dart';
import 'package:invoice/widgets/global/form/check_box_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InvoiceProductsPdfWidget extends StatefulWidget {

  const InvoiceProductsPdfWidget({super.key});

  @override
  State<InvoiceProductsPdfWidget> createState() => _InvoiceProductsPdfWidgetState();
}

class _InvoiceProductsPdfWidgetState extends State<InvoiceProductsPdfWidget> {

  bool _isLoading = false;
  
  final Map<String, bool> _options = {
    "isDate": true,
    "isInvoiceNumber": true,
    "isName": true,
    "isNationalCode": true,
    "isPhone": true,
    "isAddress": true,
    "isInvoiceDescription": true,
    "isColorInvoice": true,
    "isTermsOfSale": true,
    "isInvoiceHints": true,
    "isSigners": true
  };

  void _invoicePdfShare(context) async {
    try {
      //TodoChange
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt("enterUser", DateTime.now().millisecondsSinceEpoch);
      navigatorByPop(context);
      setState(() => _isLoading = true);
      final [invoiceProductsState, invoiceProducts] = _getInvoiceProducts();
      await InvoicePdfPlugin(
        getCustomerInvoicesState(context, listen: false).customer,
        invoiceProductsState.invoice,
        invoiceProducts,
        invoiceProductsState.invoice.description,
        _options
      ).create();
      setState(() => _isLoading = false);
    } catch(error) {
      // ignore: use_build_context_synchronously
      showSnackBarWidget(context, content: Text(t(context).error));
      setState(() => _isLoading = false);
    }
  }

  List _getInvoiceProducts() {
    InvoiceProductsState invoiceProductsState = getInvoiceProductsState(context, listen: false);
    List<ProductModel> products = getProductState(context, listen: false).products;
    List<CategoryModel> categories = getCategoryState(context, listen: false).categories;
    List<Map> invoiceProducts = invoiceProductsState.invoiceProducts.map((invoiceProduct) {
      ProductModel product = products.where((product) => product.id == invoiceProduct.productId).first;
      String categoryName = categories.where((CategoryModel category) => category.id == product.categoryId).first.name;
      return {
        ...invoiceProduct.toMap(), 
        'productName': "$categoryName ${product.name} ${product.volume} ${product.unit == 0 ? t(context).gram : t(context).cc} - ${product.quantityInBox} ${t(context).numbers}",
        'productCode': product.code,
        'quantityInBox': product.quantityInBox,
      };
    }).toList();

    return [
      invoiceProductsState,
      invoiceProducts
    ];
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.share),
      onPressed: !_isLoading
        ? () {
            setState(() => _isLoading = false);
            showModalBottomSheetWidget(context,
              initialChildSize: .5,
              content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setStateSetter) => Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: isRTL(context) ? 10.0 : 20.0, right: isRTL(context) ? 20.0 : 10.0),
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Theme.of(context).colorScheme.primary.withOpacity(.1)))
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(t(context).options, style: Theme.of(context).textTheme.headlineMedium),
                          IconButton(
                            icon: const Icon(Icons.check, size: 30.0),
                            onPressed: () => !_isLoading ? _invoicePdfShare(context) : null
                          ),
                        ]
                      )
                    ),
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        children: [
                          ListTile(
                            leading: CheckBoxWidget(isChecked: _options["isNationalCode"]!),
                            title: Text(t(context).customerNationalCode),
                            onTap: () => setStateSetter(() => _options["isNationalCode"] = !_options["isNationalCode"]!),
                            onLongPress: () {},
                          ),

                          ListTile(
                            leading: CheckBoxWidget(isChecked: _options["isColorInvoice"]!),
                            title: Text(t(context).colorInvoice),
                            onTap: () => setStateSetter(() => _options["isColorInvoice"] = !_options["isColorInvoice"]!),
                            onLongPress: () {},
                          ),

                          ListTile(
                            leading: CheckBoxWidget(isChecked: _options["isDate"]!),
                            title: Text(t(context).invoiceDate),
                            onTap: () => setStateSetter(() => _options["isDate"] = !_options["isDate"]!),
                            onLongPress: () {},
                          ),

                          ListTile(
                            leading: CheckBoxWidget(isChecked: _options["isInvoiceNumber"]!),
                            title: Text(t(context).invoiceNumber),
                            onTap: () => setStateSetter(() => _options["isInvoiceNumber"] = !_options["isInvoiceNumber"]!),
                            onLongPress: () {},
                          ),

                          ListTile(
                            leading: CheckBoxWidget(isChecked: _options["isName"]!),
                            title: Text(t(context).customerName),
                            onTap: () => setStateSetter(() => _options["isName"] = !_options["isName"]!),
                            onLongPress: () {},
                          ),

                          ListTile(
                            leading: CheckBoxWidget(isChecked: _options["isPhone"]!),
                            title: Text(t(context).customerPhone),
                            onTap: () => setStateSetter(() => _options["isPhone"] = !_options["isPhone"]!),
                            onLongPress: () {},
                          ),

                          ListTile(
                            leading: CheckBoxWidget(isChecked: _options["isAddress"]!),
                            title: Text(t(context).customerAddress),
                            onTap: () => setStateSetter(() => _options["isAddress"] = !_options["isAddress"]!),
                            onLongPress: () {},
                          ),

                          ListTile(
                            leading: CheckBoxWidget(isChecked: _options["isInvoiceDescription"]!),
                            title: Text(t(context).invoiceDescription),
                            onTap: () => setStateSetter(() => _options["isInvoiceDescription"] = !_options["isInvoiceDescription"]!),
                            onLongPress: () {},
                          ),

                          ListTile(
                            leading: CheckBoxWidget(isChecked: _options["isTermsOfSale"]!),
                            title: Text(t(context).termsOfSale),
                            onTap: () => setStateSetter(() => _options["isTermsOfSale"] = !_options["isTermsOfSale"]!),
                            onLongPress: () {},
                          ),

                          ListTile(
                            leading: CheckBoxWidget(isChecked: _options["isInvoiceHints"]!),
                            title: Text(t(context).invoiceHints),
                            onTap: () => setStateSetter(() => _options["isInvoiceHints"] = !_options["isInvoiceHints"]!),
                            onLongPress: () {},
                          ),

                          ListTile(
                            leading: CheckBoxWidget(isChecked: _options["isSigners"]!),
                            title: Text(t(context).signers),
                            onTap: () => setStateSetter(() => _options["isSigners"] = !_options["isSigners"]!),
                            onLongPress: () {},
                          ),
                        ]
                      ),
                    )
                  ],
                )
              )
            );
          }
        : null
    );
  }
}
