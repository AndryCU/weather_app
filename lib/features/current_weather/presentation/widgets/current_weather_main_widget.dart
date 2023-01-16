import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/exeptions.dart';
import 'package:weather_app/core/weather_ui/weather_cubit.dart';
import 'package:weather_app/features/current_weather/presentation/widgets/current_weather_variable_widget.dart';

import '../bloc/current_weather_bloc.dart';

class CurrentWeatherMain extends StatelessWidget {
  const CurrentWeatherMain({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      child: BlocBuilder<CurrentWeatherBloc, CurrentWeatherState>(
        builder: (context, state) {
          if (state is CurrentWeatherInitialState) {
            return const Center(
              child: Text(
                'Initial',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            );
          }
          if (state is CurrentWeatherLoadingState) {
            return const Text(
              'Cargando clima',
              style: TextStyle(
                color: Colors.white,
              ),
            );
          }
          if (state is CurrentWeatherLoadedState) {
            final letter = context.read<UnitCubit>().state ? 'C' : 'F';
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
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
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  //TODO pensar esta conversion
                                  Text(
                                    '${state.currentWeatherModel.main.temp} $letter',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: size.width * 0.15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '${state.currentWeatherModel.weather.first.main}, \n${state.currentWeatherModel.weather.first.description}',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: const Color.fromARGB(
                                          255, 200, 200, 201),
                                      //color: Colors.white,
                                      fontSize: size.width * 0.07,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                  'https://openweathermap.org/img/wn/${state.currentWeatherModel.weather.first.icon}@2x.png',
                                  width: 80),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
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
                          value: '${state.currentWeatherModel.wind.speed} m/s',
                          cat: 'Wind',
                        ),
                        CurrentWeatherColumns(
                          icon: Icons.web,
                          value: '${state.currentWeatherModel.main.humidity}%',
                          cat: 'Humidity',
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }
          if (state is TimeoutException) {
            return const Text('Reintente de nuevo');
          }
          if (state is NoInternetException) {
            return Text(
              (state as NoInternetException).message,
              style: const TextStyle(
                color: Colors.white,
              ),
            );
          }
          return const Text(
            'Ups, ha ocurrido un errorrr',
            style: TextStyle(
              color: Colors.white,
            ),
          );
        },
      ),
    );
  }

  String convertTemperatureToCelcius(BuildContext context, double temp) {
    return '${((temp - 32) * 0.5556).toStringAsFixed(1)}°C';
  }

  String convertTemperatureToFarenhid(BuildContext context, double temp) {
    return '${((temp * 1.8) + 32).toStringAsFixed(1)}°F';
  }
}
