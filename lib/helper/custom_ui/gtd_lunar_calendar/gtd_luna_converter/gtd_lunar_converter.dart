import 'dart:math';

import '../gtd_date_picker_view/gtd_lunar_date.dart';

var timeZone = 7;

class GtdLunarConverter {
  static int _numberRound(double number) {
    if (number > 0) {
      return number.toInt();
    } else if (number < 0) {
      return (number - 1).toInt();
    } else {
      return number.toInt();
    }
  }

  static int _jd({required int dd, required int mm, required int yy}) {
    int a;
    int y;
    int m;
    int jd;
    a = (14 - mm) ~/ 12;
    y = yy + 4800 - a;
    m = mm + 12 * a - 3;
    jd = dd + (153 * m + 2) ~/ 5 + 365 * y + y ~/ 4 - y ~/ 100 + y ~/ 400 - 32045;
    if (jd < 2299161) {
      jd = dd + (153 * m + 2) ~/ 5 + 365 * y + y ~/ 4 - 32083;
    }
    return jd;
  }

  static int _getNewMoonDay(int soc) {
    double T = soc / 1236.85;
    double t2 = T * T;
    double t3 = t2 * T;
    double dr = pi / 180;
    double jd1 = 2415020.75933 + 29.53058868 * soc + 0.0001178 * t2 - 0.000000155 * t3;

    jd1 += 0.00033 * sin((166.56 + 132.87 * T - 0.009173 * t2) * dr);

    double M = 359.2242 + 29.10535608 * soc - 0.0000333 * t2 - 0.00000347 * t3;
    double mpr = 306.0253 + 385.81691806 * soc + 0.0107306 * t2 + 0.00001236 * t3;
    double F = 21.2964 + 390.67050646 * soc - 0.0016528 * t2 - 0.00000239 * t3;

    double c1 = (0.1734 - 0.000393 * T) * sin(M * dr) + 0.0021 * sin(2 * dr * M);
    c1 = c1 - 0.4068 * sin(mpr * dr) + 0.0161 * sin(dr * 2 * mpr);
    c1 = c1 - 0.0004 * sin(dr * 3 * mpr);
    c1 = c1 + 0.0104 * sin(dr * 2 * F) - 0.0051 * sin(dr * (M + mpr));
    c1 = c1 - 0.0074 * sin(dr * (M - mpr)) + 0.0004 * sin(dr * (2 * F + M));
    c1 = c1 - 0.0004 * sin(dr * (2 * F - M)) - 0.0006 * sin(dr * (2 * F + mpr));
    c1 = c1 + 0.0010 * sin(dr * (2 * F - mpr)) + 0.0005 * sin(dr * (2 * mpr + M));

    double deltat = 0;
    double jdNew = 0;

    if (T < -11) {
      deltat = 0.001 + 0.000839 * T + 0.0002261 * t2 - 0.00000845 * t3 - 0.000000081 * T * t3;
    } else {
      deltat = -0.000278 + 0.000265 * T + 0.000262 * t2;
    }
    jdNew = jd1 + c1 - deltat;

    return _numberRound(jdNew + 0.5 + timeZone / 24);
  }

  static int _getSunLongitude(int soc) {
    double T;
    double t2;
    double dr;
    double M;
    double l0;
    double dL;
    double L;
    T = (soc - 2451545.5 - timeZone / 24) / 36525;
    t2 = T * T;
    dr = pi / 180; // degree to radian
    M = 357.52910 + 35999.05030 * T - 0.0001559 * t2 - 0.00000048 * T * t2; // mean anomaly, degree
    l0 = 280.46645 + 36000.76983 * T + 0.0003032 * t2; // mean longitude, degree
    dL = (1.914600 - 0.004817 * T - 0.000014 * t2) * sin(dr * M);
    dL = dL + (0.019993 - 0.000101 * T) * sin(dr * 2 * M) + 0.000290 * sin(dr * 3 * M);
    L = l0 + dL; // true longitude, degree

    double omega = 125.04 - 1934.136 * T;
    L = L - 0.00569 - 0.00478 * sin(omega * dr);
    L = L * dr;
    L = L - pi * 2 * _numberRound(L / (pi * 2)); // Normalize to (0, 2*PI)
    return _numberRound(L / pi * 6);
  }

  static int _getLunarMonth11(int yy) {
    int soc;
    int off = _jd(dd: 31, mm: 12, yy: yy) - 2415021;
    int nm;
    int sunLong;

    soc = _numberRound(off / 29.530588853);
    nm = _getNewMoonDay(soc);
    sunLong = _getSunLongitude(nm); // sun longitude at local midnight
    if (sunLong >= 9) {
      nm = _getNewMoonDay(soc - 1);
    }
    return nm;
  }

  static int _getLeapMonthOffset(int a11) {
    int k;
    int last;
    int arc;
    int i;
    k = (((a11) - 2415021.076998695) / 29.530588853 + 0.5).toInt();
    last = 0;
    i = 1; // We start with the month following lunar month 11
    arc = _getSunLongitude(_getNewMoonDay(k + i));
    do {
      last = arc;
      i += 1;
      arc = _getSunLongitude(_getNewMoonDay(k + i));
    } while (arc != last && i < 14);
    return i - 1;
  }

  static GtdLunarDate convertSolar2Lunar(DateTime solaDate) {
    int dd = solaDate.day;
    int mm = solaDate.month;
    int yy = solaDate.year;

    int k;
    int dayNumber;
    int monthStart;
    int a11;
    int b11;
    int lunarDay;
    int lunarMonth;
    int lunarYear;
    dayNumber = _jd(dd: dd, mm: mm, yy: yy);
    k = (dayNumber - 2415021.076998695) ~/ 29.530588853;
    monthStart = _getNewMoonDay(k + 1);
    if (monthStart > dayNumber) {
      monthStart = _getNewMoonDay(k);
    }

    a11 = _getLunarMonth11(yy);
    b11 = a11;
    if (a11 >= monthStart) {
      lunarYear = yy;
      a11 = _getLunarMonth11(yy - 1);
    } else {
      lunarYear = yy + 1;
      b11 = _getLunarMonth11(yy + 1);
    }
    lunarDay = dayNumber - monthStart + 1;
    int diff = (monthStart - a11) ~/ 29;
    lunarMonth = diff + 11;
    if (b11 - a11 > 365) {
      int leapMonthDiff = _getLeapMonthOffset(a11);
      if (diff >= leapMonthDiff) {
        lunarMonth = diff + 10;
      }
    }
    if (lunarMonth > 12) {
      lunarMonth = lunarMonth - 12;
    }
    if (lunarMonth >= 11 && diff < 4) {
      lunarYear -= 1;
    }
    return GtdLunarDate(lunarDay: lunarDay, lunarMonth: lunarMonth, lunarYear: lunarYear);
  }
}
