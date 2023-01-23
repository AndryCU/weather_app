import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/core/exeptions.dart';

import '../../../../injection/locator.dart';
import '../../../current_weather/domain/entities/current_weather_entity.dart';
import '../../../current_weather/domain/usecases/list_current_weather_use_case.dart';
import '../../../five_days_weather/domain/entities/next_days_weather_main.dart';
import '../../../five_days_weather/domain/usecases/next_days_use_case.dart';

part 'main_ui_event.dart';
part 'main_ui_state.dart';

class MainUiBloc extends Bloc<WeatherEvent, WeatherState> {
  MainUiBloc() : super(WeatherInitialState()) {
    on<WeatherCallEvent>((event, emit) async {
      emit(WeatherLoadingState());
      WeatherByDaysMainEntity? nextDaysData;
      CurrentWeatherModel? currentWeatherModelData;
      late Either<Exception, WeatherByDaysMainEntity> nextDays;
      late Either<Exception, CurrentWeatherModel> currentWeather;

      try {
        nextDays = await locator
            .get<NextDaysUseCase>()
            .getNextDaysWeather(lat: event.lat, lon: event.lon);
        currentWeather =
            await locator.get<CurrentWeatherUseCase>().getCurrentWeather(
                  lat: event.lat,
                  lon: event.lon,
                );
      } catch (e) {
        emit(const WeatherErrorState('An error ocurred, try again'));
      }
      nextDays.fold((l) {
        if (l is NoInternetException) {
          emit(WeatherErrorState(l.message));
        }
        if (l is TimeoutException) {
          emit(const WeatherErrorState('Retry again'));
        }
      }, (r) {
        nextDaysData = r;
      });
      currentWeather.fold((l) {
        if (l is NoInternetException) {
          emit(WeatherErrorState(l.message));
        }
      }, (r) {
        return currentWeatherModelData = r;
      });
      if (nextDays.isRight() && currentWeather.isRight()) {
        emit(WeatherLoadedState(nextDaysData!, currentWeatherModelData!));
      }
    });

    on<WeatherResetEvent>((event, emit) => emit(WeatherInitialState()));
  }
}
