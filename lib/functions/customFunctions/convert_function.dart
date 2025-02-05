import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:number_to_words_english/number_to_words_english.dart';
import 'package:invoice/config.dart';
import 'package:invoice/functions/customFunctions/check_function.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

AppLocalizations t(BuildContext context) => AppLocalizations.of(context)!;

String toPersianNumber(BuildContext context, String value, {bool onlyConvert = false}) {
  return onlyConvert ? isRTL(context) ? value.toPersianDigit() : value : isRTL(context) ? value.toPersianDigit().seRagham() : value.seRagham();
}

String toChar(BuildContext context, String value) {
  return isRTL(context) ? value.toWord() : NumberToWordsEnglish.convert(int.parse(value));
}

String toHash(String value) {
  List<int> key = utf8.encode(Config.sqliteSecretKey);
  List<int> bytes = utf8.encode(value);
  Hmac hmacSha256 = Hmac(sha256, key); // HMAC-SHA256
  return hmacSha256.convert(bytes).toString();
}
