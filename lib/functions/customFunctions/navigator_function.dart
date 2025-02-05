import 'package:flutter/material.dart';

void navigatorByPop(BuildContext context, {dynamic result}) => Navigator.of(context).pop(result);

Future<dynamic> navigatorByPushNamed(BuildContext context, String route) => Navigator.of(context).pushNamed(route);

Future<dynamic> navigatorByPushReplacementNamed(BuildContext context, String route) => Navigator.of(context).pushReplacementNamed(route);

Future<dynamic> navigatorByPush(BuildContext context, Widget screen) => Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => screen));

Future<dynamic> navigatorByPushReplacement(BuildContext context, Widget screen) => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => screen));
