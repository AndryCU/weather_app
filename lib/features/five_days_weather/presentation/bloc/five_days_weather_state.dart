part of 'five_days_weather_bloc.dart';

abstract class FiveDaysWeatherState extends Equatable {
  const FiveDaysWeatherState();

  @override
  List<Object> get props => [];
}

class FiveDaysWeatherInitial extends FiveDaysWeatherState {}

class FiveDaysWeatherLoadingState extends FiveDaysWeatherState {}

class FiveDaysWeatherLoadedState extends FiveDaysWeatherState {
  final WeatherByDaysMainEntity weatherByDaysMainEntity;

  const FiveDaysWeatherLoadedState(this.weatherByDaysMainEntity);

  @override
  List<Object> get props => [weatherByDaysMainEntity];
}

class FiveDaysWeatherErrorState extends FiveDaysWeatherState {
  final String message;
  const FiveDaysWeatherErrorState(
    this.message,
  );
  @override
  List<Object> get props => [message];
}
