import 'package:intl/intl.dart';

//mise au bon format des dates
String formatDate(DateTime date) {
  return DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").format(date);
}