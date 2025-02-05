import 'package:invoice/models/interface_model.dart';

class InvoiceProductModel implements InterfaceModel {
  final int? id;
  final int invoiceId;
  final int productId;
  final int productVolumeEach;
  final int quantityOfBoxes;
  final int productPriceEach;

  InvoiceProductModel({
    this.id,
    required this.invoiceId,
    required this.productId,
    required this.productVolumeEach,
    required this.quantityOfBoxes,
    required this.productPriceEach,
  });
  
  factory InvoiceProductModel.fromJson(Map<String, dynamic> json) {
    return InvoiceProductModel(
      id: json['id'],
      invoiceId: int.parse(json['invoiceId'].toString()),
      productId: int.parse(json['productId'].toString()),
      productVolumeEach: int.parse(json['productVolumeEach'].toString()),
      quantityOfBoxes: int.parse(json['quantityOfBoxes'].toString()),
      productPriceEach: int.parse(json['productPriceEach'].toString().replaceAll(',', '')),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'invoiceId': invoiceId,
      'productId': productId,
      'productVolumeEach': productVolumeEach,
      'quantityOfBoxes': quantityOfBoxes,
      'productPriceEach': productPriceEach
    };
  }
}
