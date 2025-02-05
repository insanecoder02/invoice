import 'package:flutter/material.dart';
import 'package:invoice/config.dart';
import 'package:invoice/functions/core_function.dart' show t, switchColor, toPersianNumber, navigatorByPushNamed, isThemeModeLight;
import 'package:invoice/states/security_state.dart';
import 'package:invoice/states/invoice_state.dart';

class HomeAppBarWidget extends StatelessWidget implements PreferredSizeWidget {

  final Function animationHandler;
  
  const HomeAppBarWidget(this.animationHandler, {super.key});

  void _lockHandler(BuildContext context) {
    getSecurityState(context, listen: false).changeIsCheckingSecurity(true);
    navigatorByPushNamed(context, '/passcode');
  }

  @override
  Widget build(BuildContext context) {
    InvoiceState invoiceState = getInvoiceState(context);
    SecurityState securityState = getSecurityState(context);

    return AppBar(
      /*leading: InvoiceState.selectedInvoices.isEmpty
        ? Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer()
            )
          )
        : null,*/
      centerTitle: true,
      title: invoiceState.selectedInvoices.isEmpty 
        ? GestureDetector(
            onDoubleTap: () => animationHandler(),
            child: Image(image: AssetImage(isThemeModeLight(context) ? 'assets/images/invoice_name_light.png' : 'assets/images/invoice_name_dark.png'), width: 90),
          )
        : null,
      actions: [
        if(invoiceState.selectedInvoices.isEmpty && securityState.passcode != null)
        IconButton(
          icon: const Icon(Icons.lock_open, size: 25.0),
          onPressed: () => _lockHandler(context)
        ),

        if(invoiceState.selectedInvoices.isNotEmpty)
        Row(
          children: [
            Text("${toPersianNumber(context, invoiceState.selectedInvoices.length.toString())} ${t(context).selected}", style: const TextStyle(fontSize: 16.0)),
            IconButton(
              icon: invoiceState.selectedInvoices.length == invoiceState.invoices.take(10).length ? Icon(Config.iconChecked, color: switchColor(context, light: Config.brandColor)) : Icon(Config.iconUnChecked),
              onPressed: () => invoiceState.selectedInvoices.length != invoiceState.invoices.take(10).length ? getInvoiceState(context, listen: false).addSelectedInvoices(take: 10) : getInvoiceState(context, listen: false).removeSelectedInvoices()
            )
          ],
        ),

        if(invoiceState.selectedInvoices.isEmpty)
          const SizedBox(width: 5.0)
        else
          const SizedBox(width: 20.0)
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
