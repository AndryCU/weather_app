part of 'main_ui_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherInitialState extends WeatherState {}

class WeatherLoadingState extends WeatherState {}

class WeatherLoadedState extends WeatherState {
  final WeatherByDaysMainEntity weatherByDaysMainEntity;
  final CurrentWeatherModel currentWeatherModel;

  const WeatherLoadedState(
      this.weatherByDaysMainEntity, this.currentWeatherModel);
  @override
  List<Object> get props => [currentWeatherModel, weatherByDaysMainEntity];
}

class WeatherErrorState extends WeatherState {
  final String message;

  const WeatherErrorState(this.message);
}
