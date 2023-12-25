import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// count String length ///
extension StringExtension on String {
  int countWords() {
    return this.split(' ').length;
  }
  int countTotalLengthOfString() {
    return this.length;
  }
  String capitalizeFirstLetter() {
    if (this.isEmpty) {
      return this; // Return the original string if it's empty
    }
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
/// isEven Integer bool ///
extension IntExtension on int {
  bool isEvenNumber() {
    return this % 2 == 0;
  }
}
/// in Decimal after .2 Pads ///
extension DoubleExtension on double {
  double roundToDecimalPlaces(int decimalPlaces) {
    double mod = 10.0 * decimalPlaces;
    return ((this * mod).round().toDouble() / mod);
  }
}
/// Provide Date Time ///
extension DateTimeExtension on DateTime {
  String formatAsCustomStringForDate() {
    return "${this.year}-${this.month}-${this.day} ${this.hour}:${this.minute}";
  }
}
/// Get Time Only in 12 hr Format ///
extension TimeExtension on DateTime {
  String getCurrentTime({String format = "hh:mm a"}) {
    return DateFormat(format).format(this);
  }
}
/// Add New value to TextEditing Controller ///
extension TextEditingControllerExtension on TextEditingController {
  void clearAndSetText(String newText) {
    this.clear();
    this.text = newText;
  }
}
/// Get Date Only ///
extension DateExtension on DateTime {
  String getDateOnly({String format = "yyyy-MM-dd"}) {
    return DateFormat(format).format(this);
  }
}
/// Custom Common Parsing with Date And Time ///
// extension StringToDateTimeExtension on String {
//   // Custom format for parsing dates
//   DateTime parseToDateTime(String format) {
//     try {
//       return DateFormat(format).parse(this);
//     } catch (_) {
//       // Handle parsing errors
//       return DateTime.now(); // Return a default value or handle the error as needed
//     }
//   }
//
//   String formatDateTime(String format) {
//     DateTime dateTime = this.parseToDateTime("dd-MM-yyyy");
//     return DateFormat(format).format(dateTime);
//   }
// }


void main() {
  String myString = "Hello, world!";
  print(myString.countWords()); // Output: 2
  DateTime now = DateTime.now();
  int myNumber = 42;
  double myDouble = 3.1415926535; // provide 2 pads after .
  String dateTimeString = "2023-01-01 12:34:56";
  // DateTime parsedDateTime = dateTimeString.parseToDateTime("yyyy-MM-dd HH:mm");


  print(myNumber.isEvenNumber()); // Output: true
  print(myDouble.roundToDecimalPlaces(2)); // Output: 3.14
  // print(now.formatAsCustomStringForDate()); // Output:
  // print(now.getDateOnly()); // only date output
  // print(now.getDateOnly()); // Output: 2023-12-25 without format
  print(now.getDateOnly(format: "dd-MM-yyyy")); // Output: 25-12-2023
  // DateTime parsedDateTime = dateTimeString.parseToDateTime("dd-MM-yyyy");
  // print(parsedDateTime); // Output: 2023-01-01 12:34:56.000
  // String formattedDateTime = dateTimeString.formatDateTime("yyyy-MM-dd HH:mm");
  // print(formattedDateTime); // Output: 2023-01-01 12:34
  print(now.getCurrentTime()); // Output: Current time formatted
  print(now.getCurrentTime(format: "HH:mm")); // Output: Current time in 24-hour format
}

