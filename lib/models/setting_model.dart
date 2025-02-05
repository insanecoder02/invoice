import 'package:invoice/models/interface_model.dart';

class SettingModel implements InterfaceModel {
  final int? id;
  final String? passcode;
  final int? userLoginTime;
  final int autoLockDuration;
  final int quantityOfAuthAttempts;

  const SettingModel({
    this.id,
    this.passcode,
    this.userLoginTime,
    required this.autoLockDuration,
    required this.quantityOfAuthAttempts,
  });

  factory SettingModel.fromJson(Map<String, dynamic> json) {
    return SettingModel(
      id: json['id'],
      passcode: json['passcode'],
      userLoginTime: json['userLoginTime'],
      autoLockDuration: int.parse(json['autoLockDuration'].toString()),
      quantityOfAuthAttempts: json['quantityOfAuthAttempts'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'passcode': passcode,
      'userLoginTime': userLoginTime,
      'autoLockDuration': autoLockDuration,
      'quantityOfAuthAttempts': quantityOfAuthAttempts
    };
  }
}
