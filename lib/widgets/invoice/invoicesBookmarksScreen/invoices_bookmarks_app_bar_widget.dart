import 'package:flutter/material.dart';
import 'package:invoice/functions/core_function.dart' show t, toPersianNumber;
import 'package:invoice/models/invoice_model.dart';
import 'package:invoice/states/invoice_state.dart';

class InvoicesBookmarksAppBarWidget extends StatelessWidget implements PreferredSizeWidget{
  
  const InvoicesBookmarksAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<InvoiceModel> invoices = getInvoiceState(context).invoices;
    int lengthInvoicesBookmars = invoices.where((InvoiceModel invoice) => invoice.getBookmark).length;

    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(t(context).bookmarks, style: Theme.of(context).textTheme.headlineLarge),
          if(lengthInvoicesBookmars > 0)
          FittedBox(
            fit: BoxFit.contain,
            child: Text("${toPersianNumber(context, lengthInvoicesBookmars.toString(), onlyConvert: true)} ${t(context).bookmark}", style: Theme.of(context).textTheme.headlineSmall)
          )
        ]
      )
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
