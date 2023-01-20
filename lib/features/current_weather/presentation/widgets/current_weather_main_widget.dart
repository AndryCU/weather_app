import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/current_weather/presentation/widgets/current_weather_variable_widget.dart';

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
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(12),
              color: const Color.fromRGBO(32, 35, 41, 1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        BlocBuilder<UnitCubit, bool>(
                          builder: (context, state) {
                            return Text(
                              state
                                  ? TemperatureHelper
                                      .convertTemperatureToCelsius(
                                          currentWeatherModel.main.temp)
                                  : TemperatureHelper
                                      .convertTemperatureToFahrenheit(
                                          currentWeatherModel.main.temp),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.width * 0.15,
                                  fontWeight: FontWeight.bold),
                            );
                          },
                        ),
                        Text(
                          '${currentWeatherModel.weather.first.main}, \n${currentWeatherModel.weather.first.description}',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: const Color.fromARGB(255, 200, 200, 201),
                            //color: Colors.white,
                            fontSize: size.width * 0.07,
                          ),
                        ),
                      ],
                    ),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: CachedNetworkImage(
                          imageUrl:
                              'https://openweathermap.org/img/wn/${currentWeatherModel.weather.first.icon}@2x.png',
                          width: 80,
                        )),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 10, top: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(12),
              color: const Color.fromRGBO(32, 35, 41, 1),
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
