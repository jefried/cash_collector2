import 'package:intl/intl.dart';

String formatMoney(num amount, String locale){
  return NumberFormat.currency(name: 'XAF', locale: locale).format(amount);
}

String formatDate(DateTime dateTime, String locale){
  return DateFormat.yMMMd(locale).format(dateTime);
}

String formatContractDate(DateTime dateTime){
  return DateFormat('dd/MM/yyyy').format(dateTime);
}

String formatDateTime(DateTime dateTime, String locale){
  return DateFormat.yMMMd().add_Hm().format(dateTime);
}