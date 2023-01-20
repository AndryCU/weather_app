import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../features/five_days_weather/domain/entities/weather_day_list.dart';

class CustomDaysUtils {
  static Map<int, DaysDataHelper> getDaysSeparated(
      {required List<WeatherList> list}) {
    final Map<int, DaysDataHelper> result = {};
    List<int> daysSaved = [];
    for (var day in list) {
      var date = DateTime.fromMillisecondsSinceEpoch(day.dt * 1000);
      final customDate =
          DateUtils.dateOnly(DateTime(date.year, date.month, date.day));
      if (!daysSaved.contains(date.day) && !result.containsKey(day.dt)) {
        var dayInitial = DaysDataHelper(day.main.temp, day.main.temp, []);
        daysSaved.add(date.day);
        result[customDate.millisecondsSinceEpoch] = dayInitial;
      }
      if (result.containsKey(customDate.millisecondsSinceEpoch) &&
          result[customDate.millisecondsSinceEpoch]!.maxTemDay <
              day.main.temp) {
        result[customDate.millisecondsSinceEpoch]!.maxTemDay = day.main.temp;
      }
      if (result.containsKey(customDate.millisecondsSinceEpoch) &&
          result[customDate.millisecondsSinceEpoch]!.minTempDay >
              day.main.temp) {
        result[customDate.millisecondsSinceEpoch]!.minTempDay = day.main.temp;
      }
      if (result.containsKey(customDate.millisecondsSinceEpoch)) {
        result[customDate.millisecondsSinceEpoch]!.listDays.add(day);
      }
    }
    return result;
  }

  static String getNameDayOfWeek(int dt) =>
      DateTime.fromMillisecondsSinceEpoch(dt).day == DateTime.now().day
          ? 'Today'
          : DateFormat('EEEE').format(DateTime.fromMillisecondsSinceEpoch(dt));

  static String getDayOfMonth(int dt) =>
      DateFormat('MMM d').format(DateTime.fromMillisecondsSinceEpoch(dt));

  static String getHourOfDay(int dt) =>
      DateFormat('j').format(DateTime.fromMillisecondsSinceEpoch(dt * 1000));
}

class DaysDataHelper {
  List<WeatherList> listDays = [];
  double maxTemDay, minTempDay = 0;
  DaysDataHelper(this.maxTemDay, this.minTempDay, this.listDays);
}
