import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:weather_app/core/exeptions.dart';

import '../../../../injection/locator.dart';
import '../../domain/entities/current_weather_entity.dart';
import '../../domain/usecases/list_current_weather_use_case.dart';

part 'current_weather_event.dart';
part 'current_weather_state.dart';

class CurrentWeatherBloc
    extends Bloc<CurrentWeatherEvent, CurrentWeatherState> {
  CurrentWeatherBloc() : super(CurrentWeatherInitialState()) {
    on<CurrentWeatherStarted>((event, emit) async {
      emit(CurrentWeatherLoadingState());
      final currentWeather =
          await locator.get<CurrentWeatherUseCase>().getCurrentWeather(
                lat: event.lat,
                lon: event.lon,
              );
      emit(
        currentWeather.fold(
          (l) {
            if (l is NoInternetException) {
              return CurrentWeatherErrorState(l.message);
            }
            if (l is TimeoutException) {
              return const CurrentWeatherErrorState('Reintente de nuevo');
            } else {
              return const CurrentWeatherErrorState('Ha ocurrido un error');
            }
          },
          (r) => CurrentWeatherLoadedState(r),
        ),
      );
    });
  }
}
