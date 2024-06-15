import 'package:intl/intl.dart';
import 'dart:developer' as developer;

enum Status { INITIAL, LOADING, COMPLETED, ERROR }

class Helper {
  String kelvinToCelcius(String? temperature) {
    double celsius = double.parse(temperature!) - 273.15;
    return celsius.toStringAsFixed(1);
  }

  String unixTimeToAmPm(String? unixTime) {
    DateTime date =
        DateTime.fromMillisecondsSinceEpoch(int.parse(unixTime!) * 1000);
    return DateFormat('h:mm a').format(date);
  }

  String unixTimeToAmPmSs(String? milliseconds) {
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(int.parse(milliseconds!) * 1000);
    return DateFormat('dd MMM yyyy \'|\' hh:mm a').format(dateTime);
  }

  String timezoneOffsetToDate(String? timezoneOffset) {
    DateTime utcTime = DateTime.now().toUtc();
    DateTime localTime =
        utcTime.add(Duration(seconds: int.parse(timezoneOffset!)));
    return DateFormat('dd MMM yyyy \'|\' hh:mm:ss').format(localTime);
  }

  void log(String message, {String name = 'helper_log'}) {
    developer.log(message, name: name);
  }

  String capitalize(String input) {
    if (input.isEmpty) {
      return input;
    }
    List<String> words = input.split(' ');
    String capitalizedString = words.map((word) {
      if (word.isEmpty) {
        return '';
      }
      return '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}';
    }).join(' ');
    return capitalizedString;
  }
}
