import 'package:intl/intl.dart';

class Formatter {
  static final _usd = NumberFormat.currency(locale: 'en_US', symbol: '\$');
  static final _brl = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

  static String usd(double value) => _usd.format(value);
  static String brl(double value) => _brl.format(value);
}
