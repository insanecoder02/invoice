import 'package:invoice/exceptions/core_exception.dart';

class SqliteException extends CoreException {
  SqliteException({super.message = 'A database error has occurred'});
}