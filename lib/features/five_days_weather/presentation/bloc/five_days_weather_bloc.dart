import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:weather_app/core/exeptions.dart';
import 'package:weather_app/features/five_days_weather/domain/entities/next_days_weather_main.dart';
import 'package:weather_app/features/five_days_weather/domain/usecases/next_days_use_case.dart';

import '../../../../injection/locator.dart';

part 'five_days_weather_event.dart';
part 'five_days_weather_state.dart';

class FiveDaysWeatherBloc
    extends Bloc<FiveDaysWeatherEvent, FiveDaysWeatherState> {
  FiveDaysWeatherBloc() : super(FiveDaysWeatherInitial()) {
    on<GetNextDaysWeatherEvent>((event, emit) async {
      emit(FiveDaysWeatherLoadingState());
      final nextDays = await locator
          .get<NextDaysUseCase>()
          .getNextDaysWeather(lat: event.lat, lon: event.lon);
      emit(nextDays.fold((l) {
        if (l is NoInternetException) {
          return FiveDaysWeatherErrorState(l.message);
        }
        if (l is TimeoutException) {
          return const FiveDaysWeatherErrorState('Reintente de nuevo');
        } else {
          return const FiveDaysWeatherErrorState('Ups!, algo ha salido mal.');
        }
      }, (r) => FiveDaysWeatherLoadedState(r)));
    });
  }
}
