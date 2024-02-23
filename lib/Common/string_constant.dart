import 'package:tuple/tuple.dart';

class StringConstant {
  static String okay = "Okay";
  static String login = "login";
  static String loading = "Loading..";

  static List<Tuple2<String, String>> emailRegexPattern = [
    const Tuple2('^', ''),
    const Tuple2('[a-z0-9]+', 'email must be in small'),
    const Tuple2('@', 'Matches the "@" symbol.'),
    const Tuple2('@[a-z]{4}', 'Specify sub-domain after (@) like (gmail).'),
    const Tuple2('\\.', 'Matches the dot (.) character in the domain.'),
    const Tuple2('\\.[a-z]{2,}.', 'Specify domain name after (.) like (.com).'),
    const Tuple2('\$', ''),
  ];
  static List<Tuple2<String, String>> passwordRegexPattern = [
    const Tuple2('^(?=.*[A-Z])',
        'Password must be contain uppercase letters'),
    const Tuple2('(?=.*[a-z])',
        'Password must be contain lowercase letters'),
    const Tuple2('(?=.*[@#\$%^&+=!])',
        'Password must be contain least one special character'),
    const Tuple2('(?=.*?[0-9])',
        'Password must be contain least one numeric character'),
    const Tuple2(
        '(?=.{8,})', 'Password must be 8 length'),
  ];

  static bool connectivityStatus = false;
  static bool connectivityStatus1 = false;

  static String deviceToken = '';
  static String deviceToken1 = '';

  static String loginModelResponse = '';
  static String loginModelResponse1 = '';

  static  String themeModeSaved = 'false';

}
