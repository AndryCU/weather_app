import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/utils/extract_days_from_list.dart';
import 'package:weather_app/features/five_days_weather/presentation/bloc/five_days_weather_bloc.dart';

class ExpandedListItem extends StatefulWidget {
  ExpandedListItem({super.key});

  @override
  State<ExpandedListItem> createState() => _ExpandedListItemState();
}

class _ExpandedListItemState extends State<ExpandedListItem> {
  List<String> d = [
    'Lunes',
    'martes',
    'Miercoles',
    'Jueves',
    'Viernes',
    'Sabado'
  ];
  List<bool> expanded = [false, false, false];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<FiveDaysWeatherBloc, FiveDaysWeatherState>(
      builder: (context, state) {
        if (state is FiveDaysWeatherInitial) {
          return const Text('Initial state');
        }
        if (state is FiveDaysWeatherLoadingState) {
          return const CircularProgressIndicator();
        }
        if (state is FiveDaysWeatherErrorState) {
          return Text('Error ${state.message}');
        }
        if (state is FiveDaysWeatherLoadedState) {
          final results = CustomDaysUtil.getDaysSeparated(
              list: state.weatherByDaysMainEntity.list);
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, indexdia) {
              final dayName = results.keys.toList()[indexdia];
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
                            CustomDaysUtil.getNameDayOfWeek(dayName),
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: size.height * 0.030,
                            ),
                          ),
                          Text(
                            CustomDaysUtil.getDayOfMonth(dayName),
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: size.height * 0.025,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '${results[dayName]!.maxTemDay}',
                      ),
                      Text(
                        '${results[dayName]!.minTempDay}',
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
                                      CustomDaysUtil.getHourOfDay(
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
                                      '${weatherEvery3Hours.main.temp}',
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
        return const Text('Salio aparenemente sin errores');
      },
    );
  }
}
