import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/const/colors.dart';
import 'package:weather_app/core/const/end_points.dart';
import 'package:weather_app/core/utils/sun_data_converter.dart';
import 'package:weather_app/features/current_weather/presentation/widgets/current_weather_variable_widget.dart';
import 'package:sizer/sizer.dart';
import 'package:weather_app/features/current_weather/presentation/widgets/texts_current_weather.dart';
import 'package:weather_app/features/feth_location/domain/entities/geocoding/geo_coding_entity.dart';
import 'package:weather_app/features/feth_location/presentation/bloc/cubit/spesific_location_selected_cubit.dart';
import '../../../../core/utils/utils.dart';
import '../../../settings/presentation/cubit/settings_unit_cubit.dart';
import '../../domain/entities/current_weather_entities.dart';

class CurrentWeatherMain extends StatelessWidget {
  final CurrentWeatherModel currentWeatherModel;

  const CurrentWeatherMain({
    super.key,
    required this.currentWeatherModel,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 10, left: 10, top: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(12),
              color: cardBackgroundColor,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        BlocBuilder<GeoCodingModelSelectedCubit,
                            GeoCodingModel?>(
                          builder: (context, state) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: CachedNetworkImage(
                                    errorWidget: (context, url, error) {
                                      return Icon(
                                        Icons.image_not_supported_sharp,
                                        color: iconErrorColor,
                                        size: 10.w,
                                      );
                                    },
                                    fit: BoxFit.fill,
                                    imageUrl: '$baseUrlFlags${state!.country}',
                                    height: 5.h,
                                    width: 15.w,
                                    filterQuality: FilterQuality.medium,
                                  ),
                                ),
                                Text(
                                  '${state.name} \n${state.state ?? ''}',
                                  style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    color: textTitleColor,
                                    fontSize: 15.sp,
                                  ),
                                  softWrap: false,
                                ),
                              ],
                            );
                          },
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              SunDataConverter.fromMillisecondsToString(
                                  currentWeatherModel.sys.sunrise),
                              style: TextStyle(
                                color: textTitleColor,
                                fontSize: 16.sp,
                              ),
                            ),
                            Image.asset(
                              'assets/sunrise_new.png',
                              width: 12.w,
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              SunDataConverter.fromMillisecondsToString(
                                  currentWeatherModel.sys.sunset),
                              style: TextStyle(
                                color: textTitleColor,
                                fontSize: 16.sp,
                              ),
                            ),
                            Image.asset(
                              'assets/sunset_new.png',
                              width: 12.w,
                            ),
                          ],
                        ),
                        BlocBuilder<UnitCubit, bool>(
                          builder: (context, state) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  state
                                      ? TemperatureHelper
                                          .convertTemperatureToCelsius(
                                              currentWeatherModel.main.temp)
                                      : TemperatureHelper
                                          .convertTemperatureToFahrenheit(
                                              currentWeatherModel.main.temp),
                                  style: TextStyle(
                                    color: textTitleColor,
                                    fontSize: 30.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        '$baseUrlImagesOpenWeatherMap${currentWeatherModel.weather.first.icon}@2x.png',
                                    width: 25.w,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        Text(
                          '${currentWeatherModel.weather.first.main}, \n${currentWeatherModel.weather.first.description}',
                          textAlign: TextAlign.start,
                          softWrap: false,
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: cardSubtitleColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.alarm_rounded,
                              color: textTitleColor,
                              size: 2.h,
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Text(
                              timeZoneMessage,
                              textAlign: TextAlign.end,
                              softWrap: false,
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: cardSubtitleColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 10.sp,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 10, top: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(12),
              color: cardBackgroundColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CurrentWeatherColumns(
                  icon: Icons.wind_power,
                  value: '${currentWeatherModel.wind.speed} m/s',
                  cat: 'Wind',
                ),
                CurrentWeatherColumns(
                  icon: Icons.arrow_downward_rounded,
                  value: '${currentWeatherModel.main.pressure.round()} hPa',
                  cat: 'Pressure',
                ),
                CurrentWeatherColumns(
                  icon: Icons.water_drop_rounded,
                  value: '${currentWeatherModel.main.humidity}%',
                  cat: 'Humidity',
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
