import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/core/const/end_points.dart';
import 'package:weather_app/core/exeptions.dart';
import 'package:weather_app/features/feth_location/domain/usecases/geo_coding_list.dart';
import 'package:weather_app/features/main_ui/presentation/bloc/main_ui_bloc.dart';

import '../../../current_weather/presentation/widgets/current_weather_main_widget.dart';
import '../../../feth_location/domain/entities/geocoding/geo_coding_entity.dart';
import '../../../five_days_weather/presentation/widgets/day_expanded_widget.dart';
import '../../../../injection/locator.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  late bool unitValue, order_days;
  @override
  void initState() {
    unitValue =
        locator.get<SharedPreferences>().getBool('units_value') ?? false;
    order_days =
        locator.get<SharedPreferences>().getBool('order_days') ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromRGBO(26, 28, 30, 0),
      body: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    textAlign: TextAlign.center,
                    'Weather App',
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                  IconButton(
                      onPressed: () {
                        context.go('/settings_page');
                      },
                      icon: const Icon(
                        Icons.settings,
                        color: Colors.white,
                      ))
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: SizedBox(
                      width: size.width * 0.95,
                      child: TypeAheadField<GeoCodingModel>(
                        textFieldConfiguration: TextFieldConfiguration(
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                width: 3,
                                color: Colors.white,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  width: 3, color: Colors.white),
                            ),
                            contentPadding: const EdgeInsets.only(left: 10),
                            //helperText: 'Type here a location',
                            helperStyle: const TextStyle(
                              color: Colors.white30,
                            ),
                            hintStyle: const TextStyle(
                              color: Colors.white30,
                            ),
                            labelText: 'Type here a location',
                            labelStyle: const TextStyle(
                              color: Colors.white30,
                            ),
                          ),
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        keepSuggestionsOnLoading: false,
                        suggestionsCallback: (pattern) async {
                          if (pattern.isNotEmpty) {
                            return await locator
                                .get<ListGeoCodingUseCase>()
                                .getCitiesNames(pattern);
                          }
                          return [];
                        },
                        itemBuilder: (context, itemData) {
                          final state =
                              itemData.state != null ? '${itemData.state}' : '';
                          return Card(
                            elevation: 20,
                            child: ListTile(
                              title: Text(itemData.name),
                              subtitle: Text(state),
                              leading: CachedNetworkImage(
                                fit: BoxFit.fill,
                                imageUrl: '$baseUrlFlags${itemData.country}',
                                height: size.height * 0.04,
                                width: size.width * 0.1,
                              ),
                            ),
                          );
                        },
                        errorBuilder: (context, error) {
                          if (error is NoInternetException) {
                            return Text(
                              error.message,
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: size.width * 0.05,
                              ),
                              textAlign: TextAlign.center,
                            );
                          }
                          if (error is TimeoutException) {
                            return Text(
                              'Try again',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: size.width * 0.05,
                              ),
                              textAlign: TextAlign.center,
                            );
                          }
                          return Text(
                            'Oops something went wrong: ${error.toString()}',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: size.width * 0.05,
                            ),
                            textAlign: TextAlign.center,
                          );
                        },
                        onSuggestionSelected: (suggestion) {
                          BlocProvider.of<MainUiBloc>(context, listen: false)
                              .add(WeatherCallEvent(
                                  suggestion.lat, suggestion.lon));
                        },
                        noItemsFoundBuilder: (context) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Ups! No locations found',
                              style: TextStyle(
                                fontSize: size.width * 0.05,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              BlocBuilder<MainUiBloc, WeatherState>(
                builder: (context, state) {
                  if (state is WeatherLoadingState) {
                    return Center(
                      child: Container(
                        height: size.height * 0.2,
                        width: size.width * 0.22,
                        decoration: BoxDecoration(
                          color: Colors.white60,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset('assets/133946-hourglass.json',
                                fit: BoxFit.fill),
                            const Text(
                              'Loading',
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  if (state is WeatherLoadedState) {
                    return Column(
                      children: [
                        CurrentWeatherMain(
                            currentWeatherModel: state.currentWeatherModel),
                        ExpandedListItem(
                          weatherByDaysMainEntity:
                              state.weatherByDaysMainEntity,
                        ),
                      ],
                    );
                  }
                  if (state is WeatherErrorState) {
                    return Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
