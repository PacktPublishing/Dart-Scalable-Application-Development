import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

var now = new DateTime.now();

void main() {
  // 1- Find the last day of the month:
  var date = new DateTime(2014,6,0);
  print(date.day);  // 31
  // more general:
  var lastDayDateTime = (now.month < 12) ? new DateTime(now.year, now.month + 1, 0)
                                          : new DateTime(now.year + 1, 1, 0);
  print(lastDayDateTime.day); // 31
  // 2- Formatting a date:
  print(now.toIso8601String()); // 2014-05-08T14:03:21.238
  print(now.toLocal());         // 2014-05-08 14:03:21.238
  print(now.toString());        // 2014-05-08 14:03:21.238
  print(now.toUtc());           // 2014-05-08 12:03:21.238Z
  // 3- Parsing dates:
  try {
    DateTime dt = DateTime.parse("2014-05-08T15+02:00");
  } on FormatException catch(e) {
    print('FormatException: $e');
  }
  // 4 - timezones:
  print(now.timeZoneName); // Romance (zomertijd)
  print(now.timeZoneOffset); // 2:00:00.000000

  // 5 - using intl to format:
  var formatter = new DateFormat('yyyy-MM-dd');
  String formatted = formatter.format(now);
  print(formatted); // 2014-05-08
  print(new DateFormat("EEEEE").format(now)); // Thursday
  print(new DateFormat("yMMMMEEEEd").format(now)); // Thursday, May 8, 2014
  print(new DateFormat("y-MM-E-d").format(now)); // 2014-05-Thu-8
  print(new DateFormat("jms").format(now)); // 2:19:08 PM
  print(new DateFormat('dd/MMM/y HH:mm:ss').format(now)); // 08/May/2014 14:39:07
  // locale data:
  initializeDateFormatting("fr_FR", null).then(formatDates);

  // 6 - using the UTC constructor:
  DateTime moonLanding  = new DateTime.utc(1969, DateTime.JULY, 20);
 }

formatDates (var d) {
    print(new DateFormat("EEEEE", 'fr_FR').format(now)); // jeudi
    print(new DateFormat("yMMMMEEEEd", 'fr_FR').format(now)); // jeudi 8 mai 2014
    print(new DateFormat("y-MM-E-d", 'fr_FR').format(now)); // 2014-05-jeu.-8
}
