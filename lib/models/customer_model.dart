import 'package:invoice/models/interface_model.dart';

class CustomerModel implements InterfaceModel {
  final int? id;
  final String nationalCode;
  final String name;
  final String phone;
  final String address;
  final String? createdAt;
  final String? updatedAt;
  final String? seenAt;

  const CustomerModel({
    this.id,
    required this.name,
    required this.nationalCode,
    required this.phone,
    required this.address,
    this.createdAt,
    this.updatedAt,
    this.seenAt
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['id'],
      nationalCode: json['nationalCode'],
      name: json['name'],
      phone: json['phone'].toString(),
      address: json['address'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      seenAt: json['seenAt']
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nationalCode': nationalCode,
      'name': name,
      'phone': phone,
      'address': address,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'seenAt': seenAt
    };
  }
}
