import 'dart:io';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:invoice/models/customer_model.dart';
import 'package:invoice/models/invoice_model.dart';
import 'package:invoice/config.dart';
import 'package:share_plus/share_plus.dart';
import 'package:pdf/pdf.dart';

class InvoicePdfHelperPlugin {
  final CustomerModel customer;
  final Map<String, bool> options;
  final InvoiceModel invoice;
  final List<Map> invoiceProducts;
  final String? invoiceDescription;
  late Font vazirmatn;
  late Document pdf;

  InvoicePdfHelperPlugin(
      this.customer, this.invoice, this.invoiceProducts, this.invoiceDescription, this.options);

  Future<void> init() async {
    final font = await rootBundle.load("assets/fonts/vazirmatn/Vazirmatn-Medium.ttf");
    vazirmatn = Font.ttf(font);
  }

  Future<void> saveAndSharePDF() async {
    var status = await Permission.manageExternalStorage.status;
    if (!status.isGranted) {
      await Permission.manageExternalStorage.request();
    }

    var status1 = await Permission.storage.status;
    if (!status1.isGranted) {
      await Permission.storage.request();
    }

    try {
      File ourDBFile = File((await _getPath())['withDirectory'].toString());
      Directory? folderPathForDBFile = Directory((await _getPath())['onlyDirectory'].toString());
      await folderPathForDBFile.create(recursive: true);
      Uint8List bytes = await pdf.save();
      await ourDBFile.writeAsBytes(bytes);
      await ourDBFile.create(recursive: true);
      await _sharePDF();

      return Future.value();
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<Map<String, String>> _getPath() async {
    // Ensure invoice date remains in English format
    String createdAtFileName =
    DateTime.parse(invoice.createdAt.toString()).toString().split(' ')[0].replaceAll('/', '-');
    String createdAtFolderName = createdAtFileName;

    String directory = "/storage/emulated/0/Invoice/Invoices/$createdAtFolderName/";

    int invoiceNumber = (invoice.id)!.toInt() + Config.baseInvoiceNumber;
    String englishInvoiceNumber = invoiceNumber.toString();

    return {
      "withDirectory": "$directory/${englishInvoiceNumber}_${customer.name}_$createdAtFileName.pdf",
      "onlyFileName": "${englishInvoiceNumber}_${customer.name}_$createdAtFileName.pdf",
      "onlyDirectory": directory
    };
  }

  Future<void> _sharePDF() async {
    try {
      final result =
      await Share.shareXFiles([XFile((await _getPath())['withDirectory'].toString())]);

      if (result.status == ShareResultStatus.dismissed) {
        // ToDo
      }

      return Future.value();
    } catch (error) {
      return Future.error(error);
    }
  }

  Widget tableCellTitle(
      String title, {
        EdgeInsets padding = const EdgeInsets.all(10.0),
        Alignment alignment = Alignment.center,
        double? fontSize,
      }) =>
      Container(
        padding: padding,
        alignment: alignment,
        color: const PdfColor.fromInt(0xFF696868),
        child: Text(title,
            style: TextStyle(color: const PdfColor.fromInt(0xFFFFFFFF), fontSize: fontSize)),
      );

  Widget tableCellBody(
      String text, {
        bool fittable = true,
        double? fontSize,
      }) =>
      Container(
        padding: const EdgeInsets.all(5.0),
        alignment: Alignment.center,
        child: fittable
            ? FittedBox(
          fit: BoxFit.contain,
          child: Text(text, style: TextStyle(fontSize: fontSize)),
        )
            : Text(text, style: TextStyle(fontSize: fontSize)),
      );

  Map<String, dynamic> getFinalPrices() {
    int totalPrice = 0;
    invoiceProducts.toList().forEach((Map invoiceProduct) => totalPrice +=
    ((int.parse(invoiceProduct['quantityInBox'].toString()) *
        int.parse(invoiceProduct['quantityOfBoxes'].toString())) *
        int.parse(invoiceProduct['productPriceEach'].toString())));
    double cashDiscount = totalPrice * (invoice.cashDiscount / 100);
    double payablePrice = totalPrice - cashDiscount;
    double volumeDiscount = payablePrice * (invoice.volumeDiscount / 100);
    payablePrice -= volumeDiscount;

    return {
      "totalPrice": totalPrice,
      "cashDiscount": cashDiscount.toStringAsFixed(0),
      "volumeDiscount": volumeDiscount.toStringAsFixed(0),
      "payablePrice": payablePrice.toStringAsFixed(0)
    };
  }

  paymentType(String text) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(border: Border.all(), shape: BoxShape.circle),
        ),
        SizedBox(width: 5.0),
        Text(text)
      ],
    );
  }
}
