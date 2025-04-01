import 'package:intl/intl.dart';


String formatDate(DateTime date) {
  return DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").format(date);
}