import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/features/main_ui/presentation/bloc/main_ui_bloc.dart';

import '../../../current_weather/presentation/widgets/current_weather_main_widget.dart';
import '../../../feth_location/presentation/widgets/text_field.dart';
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
                      child: const TextFieldLocation(),
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
