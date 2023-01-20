import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/utils/utils.dart';
import 'package:weather_app/features/settings/presentation/cubit/settings_order_cubit.dart';

import '../../../settings/presentation/cubit/settings_unit_cubit.dart';
import '../../domain/entities/next_days_weather_main.dart';

class ExpandedListItem extends StatelessWidget {
  final WeatherByDaysMainEntity weatherByDaysMainEntity;
  const ExpandedListItem({super.key, required this.weatherByDaysMainEntity});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final unit = context.read<UnitCubit>().state;
    final results =
        CustomDaysUtils.getDaysSeparated(list: weatherByDaysMainEntity.list);
    return ListView.builder(
      reverse: context.watch<OrderCubit>().state,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, indexDay) {
        final dayName = results.keys.toList()[indexDay];
        return Card(
          child: ExpansionTile(
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
                        fontWeight: FontWeight.bold,
                        fontSize: size.height * 0.030,
                      ),
                    ),
                    Text(
                      CustomDaysUtils.getDayOfMonth(dayName),
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: size.height * 0.025,
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
                ),
                Text(
                  unit
                      ? TemperatureHelper.convertTemperatureToCelsius(
                          results[dayName]!.minTempDay)
                      : TemperatureHelper.convertTemperatureToFahrenheit(
                          results[dayName]!.minTempDay),
                  style: const TextStyle(
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ],
            ),
            children: [
              SizedBox(
                height: size.height * 0.25,
                width: size.width * 0.95,
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
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                CustomDaysUtils.getHourOfDay(
                                    weatherEvery3Hours.dt),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'https://openweathermap.org/img/wn/${weatherEvery3Hours.weather.first.icon}@2x.png',
                                  height: size.height * 0.1,
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
    );
  }
}
