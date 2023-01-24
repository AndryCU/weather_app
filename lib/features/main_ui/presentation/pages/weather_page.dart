import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/features/fetch_location_gps/presentation/bloc/fetch_location_gps_bloc.dart';
import 'package:weather_app/features/main_ui/presentation/bloc/main_ui_bloc.dart';
import 'package:weather_app/features/main_ui/presentation/pages/texts_main_ui.dart';
import 'package:weather_app/features/settings/presentation/pages/settings_page.dart';

import '../../../../core/const/colors.dart';
import '../../../current_weather/presentation/widgets/current_weather_main_widget.dart';
import '../../../feth_location/presentation/bloc/cubit/spesific_location_selected_cubit.dart';
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: scaffoldBackgroundColor,
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
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      textAlign: TextAlign.center,
                      appTitle,
                      style: TextStyle(fontSize: 30.sp, color: textTitleColor),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () async {
                      BlocProvider.of<MainUiBloc>(context, listen: false)
                          .add(WeatherResetEvent());
                      BlocProvider.of<FetchLocationGpsBloc>(context,
                              listen: false)
                          .add(FetchLocationGpsStarted());
                    },
                    icon: const Icon(
                      Icons.gps_fixed,
                      color: iconColor,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SettingsPage()),
                      );
                    },
                    icon: const Icon(
                      Icons.settings,
                      color: iconColor,
                    ),
                  )
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: SizedBox(
                      width: 95.w,
                      child: TextFieldLocation(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 1.h),
              BlocBuilder<FetchLocationGpsBloc, FetchLocationGpsState>(
                builder: (context, state) {
                  if (state is FetchLocationGpsInitial) {
                    return Container();
                  }
                  if (state is FetchLocationGpsLoading) {
                    return _loadingWidget(message: loadingLocationText);
                  }
                  if (state is FetchLocationGpsLoaded) {
                    BlocProvider.of<MainUiBloc>(context, listen: false)
                        .add(WeatherCallEvent(state.lat, state.lon));
                    context
                        .read<GeoCodingModelSelectedCubit>()
                        .setGeoCodingModelReversed(
                            lat: state.lat, lon: state.lon);
                  }

                  if (state is FetchLocationGpsPermissionError) {
                    return _gpsServiceOrPermissionError(
                        message: gpsPermissionError,
                        icon: Icons.location_disabled);
                  }
                  if (state is FetchLocationGpsDenyForever) {
                    return Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.gps_off,
                            color: iconColor,
                            size: 25.w,
                          ),
                          SizedBox(
                            width: 80.w,
                            child: Text(
                              gpsPermissionDenyForeverText,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: messagesColor,
                                fontSize: 20.sp,
                              ),
                            ),
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                await openAppSettings();
                              },
                              child: const Text(goAppSettingsScreen))
                        ],
                      ),
                    );
                  }
                  if (state is FetchLocationGpsServiceError) {
                    return _gpsServiceOrPermissionError(
                      icon: Icons.wrong_location,
                      message: enableGpsText,
                    );
                  }
                  if (state is FetchLocationGpsError) {
                    return LottieBuilder.asset(
                      'assets/39612-location-animation.json',
                      fit: BoxFit.fill,
                      height: 60.h,
                      width: 80.w,
                    );
                  }
                  return Container();
                },
              ),
              SizedBox(height: 1.h),
              BlocBuilder<MainUiBloc, WeatherState>(
                builder: (context, state) {
                  if (state is WeatherLoadingState) {
                    return _loadingWidget(message: loadingWeather);
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
                        style: TextStyle(
                          color: messagesColor,
                          fontSize: 16.sp,
                        ),
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

  Center _gpsServiceOrPermissionError(
      {required IconData icon, required String message}) {
    return Center(
      child: Column(
        children: [
          Icon(
            icon,
            color: iconColor,
            size: 25.w,
          ),
          SizedBox(
            width: 80.w,
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: messagesColor,
                fontSize: 20.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding _loadingWidget({required String message}) {
    return Padding(
      padding: EdgeInsets.only(top: 15.h),
      child: Center(
        child: Container(
          height: 38.h,
          width: 50.w,
          decoration: BoxDecoration(
            color: Colors.white60,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/133946-hourglass.json',
                fit: BoxFit.fill,
                width: 50.w,
                height: 30.h,
              ),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
