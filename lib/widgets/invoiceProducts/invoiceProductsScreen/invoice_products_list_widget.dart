import 'package:flutter/material.dart';
import 'package:invoice/database/sqlite/tables/invoice_products_table_sqlite_database.dart';
import 'package:invoice/models/invoice_product_model.dart';
import 'package:invoice/functions/core_function.dart' show t, showSnackBarWidget;
import 'package:invoice/states/invoice_products_state.dart';
import 'package:invoice/widgets/global/progresses/progress_full_screen_widget.dart';
import 'package:invoice/widgets/global/messages/center_message_widget.dart';
import 'package:invoice/widgets/invoiceProducts/invoiceProductsScreen/invoice_products_item_widget.dart';

class InvoiceProductsListWidget extends StatefulWidget {
  
  const InvoiceProductsListWidget({super.key});

  @override
  State<InvoiceProductsListWidget> createState() => _InvoiceProductsListWidgetState();
}

class _InvoiceProductsListWidgetState extends State<InvoiceProductsListWidget> {
  
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initialData();
  }

  void _onChangeIsLoding(bool value) => setState(() => _isLoading = value);

  _initialData() {
    _onChangeIsLoding(true);
    InvoiceProductsState invoiceProductsState = getInvoiceProductsState(context, listen: false);
    InvoiceProductsTableSqliteDatabase().allProductsForOneInvoice(invoiceProductsState.invoice.id ?? 0).then((List<InvoiceProductModel> invoiceProducts) {
      invoiceProductsState.addInvoiceProducts(context, invoiceProducts);
      _onChangeIsLoding(false);
    }).catchError((error) {
      _onChangeIsLoding(false);
      showSnackBarWidget(
        context,
        content: Text(t(context).fetchDataError),
        actionLabel: t(context).tryAgain,
        onPressed: _initialData
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    InvoiceProductsState invoiceProductsState = getInvoiceProductsState(context);

    return ! _isLoading
      ? invoiceProductsState.invoiceProducts.isNotEmpty
        ? Expanded(
            child: ListView.builder(
              controller: invoiceProductsState.scrollController,
              physics: const ScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 50.0),
              shrinkWrap: true,
              itemCount: invoiceProductsState.invoiceProducts.length,  
              itemBuilder: (context, index) => InvoiceProductsItemWidget(invoiceProductsState.invoiceProducts[index], index),
            )
          )
        : CenterMessageWidget(message: t(context).noInvoiceProducts, subMessage: t(context).tapAddInvoiceProducts, expanded: true)
      : const ProgressFullScreenWidget.center(expanded: true);
  }
}
