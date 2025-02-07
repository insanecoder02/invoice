import 'package:flutter/material.dart';
import 'package:invoice/constans/enums.dart';
import 'package:invoice/states/setting_state.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

bool isRTL(BuildContext context) => false;

Future<bool> checkNetworkConnectivity() async {
  final connectivityResult = await (Connectivity().checkConnectivity());

  return connectivityResult == ConnectivityResult.mobile
          || connectivityResult == ConnectivityResult.wifi;
}

bool checkPortrait(BuildContext context) => MediaQuery.of(context).orientation ==  Orientation.portrait;
