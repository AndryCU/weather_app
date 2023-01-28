import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/const/colors.dart';
import 'package:weather_app/core/const/end_points.dart';
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
    final results =
        CustomDaysUtils.getDaysSeparated(list: weatherByDaysMainEntity.list);
    return Padding(
      padding: const EdgeInsets.only(
        right: 8,
        left: 8,
        top: 5,
        bottom: 10,
      ),
      child: ListView.builder(
        reverse: context.watch<OrderCubit>().state,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, indexDay) {
          final dayName = results.keys.toList()[indexDay];
          return Card(
            color: cardBackgroundColor,
            child: ExpansionTile(
              collapsedIconColor: textTitleColor,
              iconColor: iconColor,
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
                          color: textTitleColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                      ),
                      Text(
                        CustomDaysUtils.getDayOfMonth(dayName),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: textTitleColor,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                  BlocBuilder<UnitCubit, bool>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          Text(
                            state
                                ? TemperatureHelper.convertTemperatureToCelsius(
                                    results[dayName]!.maxTemDay)
                                : TemperatureHelper
                                    .convertTemperatureToFahrenheit(
                                        results[dayName]!.maxTemDay),
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: textTitleColor,
                            ),
                          ),
                          Text(
                            state
                                ? TemperatureHelper.convertTemperatureToCelsius(
                                    results[dayName]!.minTempDay)
                                : TemperatureHelper
                                    .convertTemperatureToFahrenheit(
                                        results[dayName]!.minTempDay),
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 16.sp,
                              color: textTitleColor,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
              children: [
                Container(
                  color: cardBackgroundColor,
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
                          color: cardInsideColor,
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
                                    color: textTitleColor,
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        '$baseUrlImagesOpenWeatherMap${weatherEvery3Hours.weather.first.icon}@2x.png',
                                    height: 10.h,
                                    errorWidget: (context, url, error) {
                                      return Icon(
                                        Icons.error,
                                        color: iconErrorColor,
                                        size: 7.w,
                                      );
                                    },
                                  ),
                                ),
                                BlocBuilder<UnitCubit, bool>(
                                  builder: (context, state) {
                                    return Text(
                                      state
                                          ? TemperatureHelper
                                              .convertTemperatureToCelsius(
                                                  weatherEvery3Hours.main.temp)
                                          : TemperatureHelper
                                              .convertTemperatureToFahrenheit(
                                                  weatherEvery3Hours.main.temp),
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        color: textTitleColor,
                                      ),
                                    );
                                  },
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
