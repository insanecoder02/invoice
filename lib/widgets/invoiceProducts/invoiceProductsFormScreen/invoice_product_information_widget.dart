import 'package:flutter/material.dart';
import 'package:invoice/config.dart';
import 'package:invoice/functions/core_function.dart' show t, toPersianNumber, switchColor;

class InvoiceProductInformationWidget extends StatelessWidget {
  
  final Map<String, dynamic> productInformation;

  const InvoiceProductInformationWidget(this.productInformation, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
          margin: const EdgeInsets.only(top: 7.0, bottom: 53.0),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Config.borderRadius),
            border: Border.all(
              color: switchColor(context, light: Theme.of(context).colorScheme.primary.withOpacity(.3), dark: Theme.of(context).colorScheme.primary.withOpacity(.2)),
              width: Config.widthBorder
            )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${productInformation['categoryName'].toString()} ${productInformation['name'].toString()}", style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 16.0)),
              const SizedBox(height: 10.0),
              Text("${toPersianNumber(context, productInformation['volume'].toString(), onlyConvert: true)} ${productInformation['unit'] == 0 ? t(context).gram : t(context).cc} - ${toPersianNumber(context, productInformation['quantityInBox'].toString(), onlyConvert: true)} ${t(context).numbers}", style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 16.0)),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  Text(t(context).priceEach, style: Theme.of(context).textTheme.headlineSmall),
                  Expanded(child: Text(" ${toPersianNumber(context, productInformation['price'].toString())} ${t(context).rial}", style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 16.0)))
                ],
              ),
            ]
          ),
        ),
        Container(
          color: Theme.of(context).colorScheme.background,
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Text(t(context).productInformation, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 12.0, fontWeight: FontWeight.normal))
        )
      ],
    );
  }
}
