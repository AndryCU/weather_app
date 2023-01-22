import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/utils/utils.dart';
import 'package:weather_app/features/five_days_weather/domain/entities/next_days_weather_main.dart';
import 'package:weather_app/features/settings/presentation/cubit/settings_order_cubit.dart';
import 'package:sizer/sizer.dart';
import '../../../settings/presentation/cubit/settings_unit_cubit.dart';

class ExpandedListItem extends StatelessWidget {
  final WeatherByDaysMainEntity weatherByDaysMainEntity;
  const ExpandedListItem({super.key, required this.weatherByDaysMainEntity});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final unit = context.watch<UnitCubit>().state;
    final results =
        CustomDaysUtils.getDaysSeparated(list: weatherByDaysMainEntity.list);
    return Padding(
      padding: const EdgeInsets.only(
        right: 10,
        left: 10,
        top: 5,
      ),
      child: ListView.builder(
        reverse: context.watch<OrderCubit>().state,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, indexDay) {
          final dayName = results.keys.toList()[indexDay];
          return Card(
            color: const Color.fromRGBO(32, 35, 41, 1),
            child: ExpansionTile(
              collapsedIconColor: Colors.white,
              iconColor: Colors.white,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        CustomDaysUtils.getNameDayOfWeek(dayName),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                      ),
                      Text(
                        CustomDaysUtils.getDayOfMonth(dayName),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    unit
                        ? TemperatureHelper.convertTemperatureToCelsius(
                            results[dayName]!.maxTemDay)
                        : TemperatureHelper.convertTemperatureToFahrenheit(
                            results[dayName]!.maxTemDay),
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    unit
                        ? TemperatureHelper.convertTemperatureToCelsius(
                            results[dayName]!.minTempDay)
                        : TemperatureHelper.convertTemperatureToFahrenheit(
                            results[dayName]!.minTempDay),
                    style: TextStyle(
                      fontWeight: FontWeight.w100,
                      fontSize: 16.sp,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              children: [
                Container(
                  color: const Color.fromRGBO(26, 28, 30, 0),
                  height: 25.h,
                  width: 95.w,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: results[dayName]!.listDays.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final weatherEvery3Hours =
                          results[dayName]!.listDays[index];
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Card(
                          color: Color.fromARGB(179, 128, 128, 128),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  CustomDaysUtils.getHourOfDay(
                                      weatherEvery3Hours.dt),
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Colors.white,
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        'https://openweathermap.org/img/wn/${weatherEvery3Hours.weather.first.icon}@2x.png',
                                    height: 10.h,
                                    errorWidget: (context, url, error) {
                                      return Icon(
                                        Icons.error,
                                        color: Colors.red,
                                        size: 7.w,
                                      );
                                    },
                                  ),
                                ),
                                Text(
                                  unit
                                      ? TemperatureHelper
                                          .convertTemperatureToCelsius(
                                              weatherEvery3Hours.main.temp)
                                      : TemperatureHelper
                                          .convertTemperatureToFahrenheit(
                                              weatherEvery3Hours.main.temp),
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
        itemCount: results.length,
      ),
    );
  }
}
