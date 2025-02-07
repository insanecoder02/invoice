import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:invoice/config.dart';
import 'package:invoice/plugins/invoicePdf/invoice_pdf_helper_plugin.dart';
import 'package:number_to_words_english/number_to_words_english.dart';

class InvoicePdfPlugin extends InvoicePdfHelperPlugin {
  InvoicePdfPlugin(customer, invoice, invoiceProducts, invoiceDescription, options)
      : super(customer, invoice, invoiceProducts, invoiceDescription, options);

  Future<void> create() async {
    try {
      await init();
      pdf = Document();
      pdf.addPage(
        MultiPage(
          margin: const EdgeInsets.all(20.0),
          orientation: PageOrientation.portrait,
          pageFormat: PdfPageFormat.a4,
          textDirection: TextDirection.ltr, // Ensure English text direction
          theme: ThemeData.withFont(base: super.vazirmatn),
          build: (context) => [
            _generateInvoiceHeader(),
            _generateInvoiceInfo(),
            _generateInvoiceTable(),
            _tableTotalNumberBox(),
            _generateInvoicePrices(),
            _generateNumberTotalToChar(),
            _generateInvoiceDescription(),
            _generateRules(),
            _generateSignature(),
          ],
        ),
      );
      await super.saveAndSharePDF();
      return Future.value();
    } catch (error) {
      return Future.error(error);
    }
  }

  Widget _generateInvoiceHeader() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: super.options["isColorInvoice"]! ? Config.brandPdfColor : const PdfColor.fromInt(0xFAED1A3B),
        border: Border.all(color: const PdfColor.fromInt(0x00000000)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${super.invoice.getType ? 'Invoice' : 'Proforma Invoice'}",
                style: const TextStyle(color: PdfColor.fromInt(0xFFFFFFFF), fontSize: 20),
              ),
            ],
          ),
          if (super.options["isDate"]! || super.options["isInvoiceNumber"]!)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (super.options["isInvoiceNumber"]!)
                  Text(
                    "Invoice Number: ${(super.invoice.id)!.toInt() + Config.baseInvoiceNumber}",
                    style: const TextStyle(color: PdfColor.fromInt(0xFFFFFFFF)),
                  ),
                if (super.options["isDate"]!)
                  Text(
                    "Invoice Date: ${DateTime.parse(super.invoice.createdAt.toString()).toString().split(' ')[0]}",
                    style: const TextStyle(color: PdfColor.fromInt(0xFFFFFFFF)),
                  ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _generateInvoiceInfo() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(border: Border.all()),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (super.options["isName"]! || super.options["isNationalCode"]!)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (super.options["isName"]!) Text("Customer Name: ${super.customer.name}"),
                  if (super.options["isNationalCode"]!) Text("National Code: ${super.customer.nationalCode}"),
                ],
              ),
            ),
          if (super.options["isAddress"]! || super.options["isPhone"]!)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (super.options["isAddress"]!) Text("Address: ${super.customer.address}"),
                  if (super.options["isPhone"]!) Text("Phone: ${super.customer.phone}"),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _generateInvoiceTable() {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: {
        0: const FlexColumnWidth(.4),
        1: const FlexColumnWidth(.4),
        2: const FlexColumnWidth(.4),
        3: const FlexColumnWidth(.2),
        4: const FlexColumnWidth(.5),
        5: const FlexColumnWidth(.3),
        6: const FlexColumnWidth(.2),
      },
      border: TableBorder.all(),
      children: [
        _tableHeader(),
        ..._tableBody(),
      ],
    );
  }
  TableRow _tableHeader() { // ✅ Now fully included
    return TableRow(
      decoration: const BoxDecoration(color: PdfColor.fromInt(0xFF9E9E9E)),
      children: [
        super.tableCellTitle('Price'),
        super.tableCellTitle('Carton Price'),
        super.tableCellTitle('Unit Price'),
        super.tableCellTitle('Quantity'),
        super.tableCellTitle('Product Info'),
        super.tableCellTitle('Product Code'),
        super.tableCellTitle('Row'),
      ],
    );
  }

  List<TableRow> _tableBody() {
    return List.generate(super.invoiceProducts.length, (i) {
      return TableRow(
        children: [
          super.tableCellBody(
              ((super.invoiceProducts[i]['quantityInBox'] * super.invoiceProducts[i]['quantityOfBoxes']) * super.invoiceProducts[i]['productPriceEach'])
                  .toString()),
          super.tableCellBody(((super.invoiceProducts[i]['productPriceEach'] * super.invoiceProducts[i]['quantityInBox']).toString())),
          super.tableCellBody(super.invoiceProducts[i]['productPriceEach'].toString()),
          super.tableCellBody((super.invoiceProducts[i]['quantityOfBoxes']).toString()),
          super.tableCellBody(super.invoiceProducts[i]['productName'], fittable: false),
          super.tableCellBody(super.invoiceProducts[i]['productCode'].toString()),
          super.tableCellBody((i + 1).toString()),
        ],
      );
    });
  }

  Widget _tableTotalNumberBox() {
    int totalNumberBox = 0;
    invoiceProducts.forEach((invoiceProduct) {
      totalNumberBox += int.parse(invoiceProduct['quantityOfBoxes'].toString());
    });

    return Container(
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(border: Border.all()),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 154),
            child: Text('Total Cartons:'),
          ),
          Text(totalNumberBox.toString(), style: const TextStyle(fontSize: 16.0)),
        ],
      ),
    );
  }

  Widget _generateInvoicePrices() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: Text("Total Amount: ${super.getFinalPrices()['payablePrice']} Rupees",
          style: const TextStyle(fontSize: 16.0)),
    );
  }

  Widget _generateNumberTotalToChar() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      alignment: Alignment.center,
      child: Text(
        "Amount in Words: ${NumberToWordsEnglish.convert(int.parse(super.getFinalPrices()['payablePrice'].toString()))} Rupees",
        style: const TextStyle(fontSize: 16.0),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _generateInvoiceDescription() {
    return super.invoiceDescription != null &&
        super.invoiceDescription!.isNotEmpty &&
        super.options["isInvoiceDescription"]!
        ? Container(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Description', style: const TextStyle(fontSize: 16.0)),
          Text(super.invoiceDescription.toString()),
        ],
      ),
    )
        : Container();
  }

  Widget _generateRules() {
    return super.options["isInvoiceHints"]!
        ? Container(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Notes', style: const TextStyle(fontSize: 16.0)),
          Text("1 - If there is an issue with the items, returns are allowed within 15 days from the invoice date."),
          Text("2 - The items remain under the seller’s ownership until full payment is made."),
        ],
      ),
    )
        : Container();
  }

  Widget _generateSignature() {
    return super.options["isSigners"]!
        ? Container(
      decoration: BoxDecoration(border: Border(top: BorderSide(color: PdfColor.fromRYB(1, 1, 1)))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(padding: const EdgeInsets.only(top: 20.0), child: Text('Seller Signature')),
          Padding(padding: const EdgeInsets.only(top: 20.0), child: Text('Buyer or Receiver Signature')),
        ],
      ),
    )
        : Container();
  }
}
