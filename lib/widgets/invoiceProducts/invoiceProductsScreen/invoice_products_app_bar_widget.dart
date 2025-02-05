import 'package:flutter/material.dart';
import 'package:invoice/config.dart';
import 'package:invoice/states/customer_invoices_state.dart';
import 'package:invoice/states/invoice_products_state.dart';
import 'package:invoice/functions/core_function.dart' show t, toPersianNumber;
import 'package:invoice/widgets/invoiceProducts/invoiceProductsScreen/invoice_products_pdf_widget.dart';
import 'package:invoice/widgets/invoiceProducts/invoiceProductsScreen/invoice_products_popup_menu_button_widget.dart';

class InvoiceProductsAppBarWidget extends StatelessWidget implements PreferredSizeWidget {

  final bool redirectToCustomerInvoicesEnable;

  const InvoiceProductsAppBarWidget({super.key, this.redirectToCustomerInvoicesEnable = true});

  @override
  Widget build(BuildContext context) {
    InvoiceProductsState invoiceProductsState = getInvoiceProductsState(context);
    CustomerInvoicesState cusatomerInvoicesState = getCustomerInvoicesState(context);

    return AppBar(
      title: GestureDetector(
        onDoubleTap: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(cusatomerInvoicesState.customer.name, style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 21.0), overflow: TextOverflow.ellipsis),
            Row(
              children: [
                Text(invoiceProductsState.invoice.getType ? t(context).invoice : t(context).preinvoice, style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(width: 10),
                Text(toPersianNumber(context, (invoiceProductsState.invoice.id!.toInt() + Config.baseInvoiceNumber).toString(), onlyConvert: true), style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        )
      ),
      actions: [
        const InvoiceProductsPdfWidget(),
        InvoiceProductsPopupMenuButtonWidget(redirectToCustomerInvoicesEnable: redirectToCustomerInvoicesEnable)
      ],
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
