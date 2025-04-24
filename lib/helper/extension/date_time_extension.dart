import 'package:gtd_helper/helper/gtd_app_logger.dart';
import 'package:intl/intl.dart';

const String shortPattern = "dd/MM/yyyy";
const String utcPattern = "yyyy-MM-ddTHH:mm:ss'Z'";
const String fullDateTimePattern1 = "HH:mm, EEE dd/MM/yyyy";
const String fullDateTimePattern2= "HH:mm - EEEE, dd/MM/yyyy";
DateFormat dateFormat = DateFormat(shortPattern);
DateFormat dateFormatFlight = DateFormat(fullDateTimePattern2);
DateFormat monthYearFormat = DateFormat("MM/yyyy");
DateFormat iosDateFormat = DateFormat(utcPattern);
DateFormat fullDateTimeFormat = DateFormat(fullDateTimePattern1);

extension GtdDateTime on DateTime {
  //Format date at local with timezone system
  String localDate(String pattern, {String lang = "vi"}) {
    try {
      DateFormat dateFormat = DateFormat(pattern, lang);
      return dateFormat.format(toLocal());
    } catch (e) {
      Logger.e(e.toString());
    }
    return "";
  }

  //Format date at UTC 0
  String utcDate(String pattern, {String lang = "vi"}) {
    try {
      DateFormat dateFormat = DateFormat(pattern, lang);
      return dateFormat.format(toUtc());
    } catch (e) {
      Logger.e(e.toString());
    }
    return "";
  }

  static int timestampFromUTC(String utcTime) {
    DateTime? date = DateTime.tryParse(utcTime);
    return date?.millisecondsSinceEpoch ?? -1;
  }

  static int timestampFromLocalDate({required String dateTime, String pattern = "yyyy-MM-dd HH:mm:ss"}) {
    String dateTest = "2023-03-15 10:36:14 UTC";
    DateTime date = DateFormat("yyyy-MM-dd HH:mm:ss").parseUTC(dateTest);
    return date.millisecondsSinceEpoch;
  }

  static String timeStampToDateString(int? timeStamp) {
    String timeString = '';
    if (timeStamp != null) {
      int oneSecond = 1;
      int oneMinute = oneSecond * 1;
      int oneHour = oneMinute * 60;
      int oneDay = oneHour * 24;

      // int seconds = ((millSeconds % oneMinute) / oneSecond).floor();
      int minutes = ((timeStamp % oneHour) / oneMinute).floor();
      int hours = ((timeStamp % oneDay) / oneHour).floor();
      int days = (timeStamp / oneDay).floor();

      if (days != 0) {
        timeString += (days != 1) ? ('${days}d') : ('${days}d');
      }
      if (hours != 0) {
        timeString += (hours != 1) ? (' ${hours}h') : ('${hours}h');
      }
      if (minutes != 0) {
        timeString += (minutes != 1) ? (' ${minutes}m') : ('${minutes}m');
      }
    }
    return timeString;
  }

  bool isSameDate(DateTime? other) {
    return year == other?.year && month == other?.month && day == other?.day;
  }

  int difInDays(DateTime? other) {
    if (other == null) {
      return 0;
    }
    if (isSameDate(other)) {
      return 0;
    }
    final newThis = DateTime(year, month, day, 0);
    final newOther = DateTime(other.year, other.month, other.day, 0);
    return newOther.difference(newThis).inDays;
  }
}
