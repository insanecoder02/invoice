import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:invoice/config.dart';
import 'package:invoice/plugins/invoicePdf/invoice_pdf_helper_plugin.dart';

class InvoicePdfPlugin extends InvoicePdfHelperPlugin {

  InvoicePdfPlugin(customer, invoice, invoiceProducts, invoiceDescription, options):super(customer, invoice, invoiceProducts, invoiceDescription, options);

  Future<void> create() async {
    try {
      await init();
      pdf = Document();
      pdf.addPage(
        MultiPage(
          margin: const EdgeInsets.all(20.0),
          orientation: PageOrientation.portrait,
          pageFormat: PdfPageFormat.a4,
          textDirection: TextDirection.rtl,
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
              _generateSignature()
            ]
          )
        );
      await super.saveAndSharePDF();

      return Future.value();
    } catch(error) {
      return Future.error(error);
    }
  }

  Widget _generateInvoiceHeader() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: super.options["isColorInvoice"]! ? Config.brandPdfColor : const PdfColor.fromInt(0xFA696868),
        border: Border.all(color: const PdfColor.fromInt(0x00000000))
      ),
      child: Column(
        children: [
          Row( 
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${super.invoice.getType ? 'فاکتور'  : 'پیش فاکتور'} محصولات", style: const TextStyle(color: PdfColor.fromInt(0xFFFFFFFF), fontSize: 20))
            ]
          ),
          if(super.options["isDate"]! || super.options["isInvoiceNumber"]!)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if(super.options["isInvoiceNumber"]!)
              Text("شماره فاکتور:  ${(super.invoice.id)!.toInt() + Config.baseInvoiceNumber}", style: const TextStyle(color: PdfColor.fromInt(0xFFFFFFFF))),

              if(super.options["isDate"]!)
              Text("تاریخ فاکتور:  ${DateTime.parse(super.invoice.createdAt.toString()).toPersianDate()}", style: const TextStyle(color: PdfColor.fromInt(0xFFFFFFFF)))
            ]
          ),
        ]
      )
    );
  }

  Widget _generateInvoiceInfo() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all()
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if(super.options["isName"]! || super.options["isNationalCode"]!)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(super.options["isName"]!)
                Text("نام خریدار:  ${super.customer.name}"),

                if(super.options["isNationalCode"]!)
                Text("کد ملی:  ${super.customer.nationalCode.toPersianDigit()}"),
              ]
            )
          ),

          if(super.options["isName"]! || super.options["isNationalCode"]!)
          SizedBox(width: 5.0),

          if(super.options["isAddress"]! || super.options["isPhone"]!)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(super.options["isAddress"]!)
                Text("آدرس:  ${super.customer.address}"),

                if(super.options["isPhone"]!)
                Text("تلفن:  ${super.customer.phone.toPersianDigit()}"),
              ]
            )
          )
        ]
      )
    );
  }

  TableRow _tableHeader() {
    return TableRow(
      decoration: const BoxDecoration(
        color: PdfColor.fromInt(0xFF9E9E9E)
      ),
      children: [
        super.tableCellTitle('قیمت'),
        super.tableCellTitle('فی کارتن'),
        super.tableCellTitle('فی هر'),
        super.tableCellTitle('تعداد'),
        super.tableCellTitle('مشخصات کالا'),
        super.tableCellTitle('کد کالا'),
        super.tableCellTitle('ردیف')
      ]
    );
  }

  Widget _tableTotalNumberBox() {
    int totalNumberBox = 0;
    invoiceProducts.toList().forEach((Map invoiceProducts) => totalNumberBox += int.parse(invoiceProducts['quantityOfBoxes'].toString()));

    return Container(
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(border: Border.all()),
      child: Row(
        children: [
          Padding(padding: const EdgeInsets.only(left: 10, right: 154), child: Text('تعداد کارتن ها :')),
          Text(totalNumberBox.toString().toPersianDigit(), style: const TextStyle(fontSize: 16.0)),
        ]
      )
    );
  }

  List<TableRow> _tableBody() {
    List<TableRow> tableRows = [];
    for (int i = 0; i < super.invoiceProducts.length; i++) {
      tableRows.add(
        TableRow(
          children: [
            super.tableCellBody(((super.invoiceProducts[i]['quantityInBox'] * super.invoiceProducts[i]['quantityOfBoxes']) * super.invoiceProducts[i]['productPriceEach']).toString().toPersianDigit().seRagham()),
            super.tableCellBody(((super.invoiceProducts[i]['productPriceEach'] * super.invoiceProducts[i]['quantityInBox']).toString().toPersianDigit().seRagham())),
            super.tableCellBody(super.invoiceProducts[i]['productPriceEach'].toString().toPersianDigit().seRagham()),
            super.tableCellBody((super.invoiceProducts[i]['quantityOfBoxes']).toString().toPersianDigit()),
            super.tableCellBody(super.invoiceProducts[i]['productName'], fittable: false),
            super.tableCellBody(super.invoiceProducts[i]['productCode'].toString().toPersianDigit()),
            super.tableCellBody((i + 1).toString().toPersianDigit()),
          ]
        )
      );
    }

    return tableRows;
  }

  Widget _generateInvoiceTable() {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths:  {
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
      ]
    );
  }

  Widget _generateInvoicePrices() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: super.options["isTermsOfSale"]!
                ? [
                    Text('شرایط فروش :'),
                    SizedBox(width: 20),
                    super.paymentType('نقدی'),
                    SizedBox(width: 40),
                    super.paymentType('غیر نقدی')
                  ]
                : []
            )
          ),
          Expanded(
            child: Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: {
                0: const FlexColumnWidth(.3),
                1: const FlexColumnWidth(.3),
              },
              border: TableBorder.all(),
              children: [
                if(super.invoice.cashDiscount > 0 || super.invoice.volumeDiscount > 0)
                TableRow(
                  children: [
                    super.tableCellBody(super.getFinalPrices()['totalPrice'].toString().seRagham().toPersianDigit(), fontSize: 16.0),
                    super.tableCellBody('جمع کل'),
                  ]
                ),
                if(super.invoice.cashDiscount > 0)
                TableRow(
                  children: [
                    super.tableCellBody(super.getFinalPrices()['cashDiscount'].toString().seRagham().toPersianDigit(), fontSize: 16.0),
                    super.tableCellBody('${super.invoice.cashDiscount.toString().toPersianDigit()}% تخفیف نقدی'),
                  ]
                ),
                if(super.invoice.volumeDiscount > 0)
                TableRow(
                  children: [
                    super.tableCellBody(super.getFinalPrices()['volumeDiscount'].toString().seRagham().toPersianDigit(), fontSize: 16.0),
                    super.tableCellBody('${super.invoice.volumeDiscount.toString().toPersianDigit()}% تخفیف حجمی'),
                  ]
                ),
                TableRow(
                  children: [
                    super.tableCellBody(super.getFinalPrices()['payablePrice'].toString().seRagham().toPersianDigit(), fontSize: 16.0),
                    super.tableCellBody('مبلغ قابل پرداخت'),
                  ]
                )
              ]      
            )
          ),
        ]
      )
    );
  }

  Widget _generateNumberTotalToChar() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      alignment: Alignment.center,
      child: Text("مبلغ به حروف :  ${super.getFinalPrices()['payablePrice'].toString().toWord()} ریال", style: const TextStyle(fontSize: 16.0), textAlign: TextAlign.center)
    );
  }

  Widget _generateInvoiceDescription() {
    return super.invoiceDescription != null && super.invoiceDescription!.isNotEmpty && super.options["isInvoiceDescription"]!
      ? Container(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('توضیحات', style: const TextStyle(fontSize: 16.0)),
            Text(super.invoiceDescription.toString()),
          ]
        )
      )
      : Container();
  }

  Widget _generateRules() {
    return super.options["isInvoiceHints"]!
      ? Container(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('توجه', style: const TextStyle(fontSize: 16.0)),
              Text('${"1".toPersianDigit()} - در صورت مشکل دار بودن اجناس ارسالی حداکثر مهلت عودت کالا ${"15".toPersianDigit()} روز از تاریخ صدور فاکتور میباشد.'),
              Text('${"2".toPersianDigit()} - اجناس فوق تا تسویه نهایی به طور امانت نزد مشتری میباشد.'),
            ]
          )
        )
      : Container();
  }

  Widget _generateSignature() {
    return super.options["isSigners"]!
      ? Container(
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: PdfColor.fromRYB(1, 1, 1)))
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(padding: const EdgeInsets.only(top: 20.0), child: Text('امضاء فروشنده')),
              Padding(padding: const EdgeInsets.only(top: 20.0), child: Text('امضاء خریدار یا تحویل گیرنده')),
            ]
          )
        )
      : Container();
  }
}
