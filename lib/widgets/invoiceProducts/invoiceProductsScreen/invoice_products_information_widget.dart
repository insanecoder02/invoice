import 'package:flutter/material.dart';
import 'package:invoice/functions/core_function.dart' show t, toPersianNumber, toChar;
import 'package:invoice/models/invoice_model.dart';
import 'package:invoice/models/invoice_product_model.dart';
import 'package:invoice/states/invoice_products_state.dart';

class InvoiceProductsInformationWidget extends StatelessWidget {

  const InvoiceProductsInformationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    InvoiceProductsState invoiceProductsState = getInvoiceProductsState(context);
    InvoiceModel invoice = invoiceProductsState.invoice;

    int totalPrice = invoiceProductsState.totalPrice;
    double cashDiscount = totalPrice * (invoice.cashDiscount / 100);
    double payablePrice = totalPrice - cashDiscount;
    double volumeDiscount = payablePrice * (invoice.volumeDiscount / 100);
    payablePrice -= volumeDiscount;
    int productQuantity = invoiceProductsState.invoiceProducts.length;
    int totalBoxes = 0;
    invoiceProductsState.invoiceProducts.toList().forEach((InvoiceProductModel invoiceProduct) => totalBoxes += invoiceProduct.quantityOfBoxes);

    List<Widget> children = [
      Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(invoice.cashDiscount > 0)
              Row(
                children: [
                  Text("${toPersianNumber(context, invoice.cashDiscount.toString())}%", style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(width: 5.0),
                  Text(t(context).cashDiscount, style: Theme.of(context).textTheme.headlineSmall),
                ],
              ),

              if(invoice.cashDiscount > 0 && invoice.volumeDiscount > 0)
              const SizedBox(width: 20.0),
              
              if(invoice.cashDiscount == 0 && invoice.volumeDiscount == 0)
              Text(t(context).withoutDiscount, style: Theme.of(context).textTheme.headlineMedium),

              if(invoice.volumeDiscount > 0)
              Row(
                children: [
                  Text("${toPersianNumber(context, invoice.volumeDiscount.toString())}%", style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(width: 5.0),
                  Text(t(context).volumeDiscount, style: Theme.of(context).textTheme.headlineSmall),
                ],
              ),
            ]
          ),

          if(totalPrice > 0)
          const SizedBox(height: 10.0),

          if(totalPrice > 0)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(" ${toPersianNumber(context, productQuantity.toString(), onlyConvert: true)} ", style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Theme.of(context).colorScheme.primary)),
              Text(t(context).product, style: Theme.of(context).textTheme.headlineSmall),
              Text(" ${toPersianNumber(context, totalBoxes.toString(), onlyConvert: true)} ", style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Theme.of(context).colorScheme.primary)),
              Text(t(context).box, style: Theme.of(context).textTheme.headlineSmall),
            ],
          ),

          if(totalPrice > 0)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(t(context).total, style: Theme.of(context).textTheme.headlineSmall),

                  if(invoice.cashDiscount > 0)
                  Text(t(context).cashDiscount, style: Theme.of(context).textTheme.headlineSmall),

                  if(invoice.volumeDiscount > 0)
                  Text(t(context).volumeDiscount, style: Theme.of(context).textTheme.headlineSmall),

                  Text(t(context).payable, style: Theme.of(context).textTheme.headlineSmall),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(" ${toPersianNumber(context, totalPrice.toString())} ${t(context).rial}", style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Theme.of(context).colorScheme.primary)),

                  if(invoice.cashDiscount > 0)
                  Text(" ${toPersianNumber(context, cashDiscount.toStringAsFixed(0))} ${t(context).rial}", style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Theme.of(context).colorScheme.primary)),

                  if(invoice.volumeDiscount > 0)
                  Text(" ${toPersianNumber(context, volumeDiscount.toStringAsFixed(0))} ${t(context).rial}", style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Theme.of(context).colorScheme.primary)),
                  
                  Text(" ${toPersianNumber(context, payablePrice.toStringAsFixed(0))} ${t(context).rial}", style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Theme.of(context).colorScheme.primary)),
                ]
              ),
            ],
          ),
        ],
      ),
    ];
        
    return Container(
      padding: const EdgeInsets.all(20.0),
      color: Theme.of(context).cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ...children,
          if(totalPrice > 0) const SizedBox(height: 10.0),
          if(totalPrice > 0) Text("${toChar(context, payablePrice.toStringAsFixed(0))} ${t(context).rial}", style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Theme.of(context).colorScheme.primary), textAlign: TextAlign.center,)
        ],
      ),
    );
  }
}
