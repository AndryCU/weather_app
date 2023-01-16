part of 'current_weather_bloc.dart';

abstract class CurrentWeatherState extends Equatable {
  const CurrentWeatherState();

  @override
  List<Object> get props => [];
}

class CurrentWeatherInitialState extends CurrentWeatherState {}

class CurrentWeatherLoadingState extends CurrentWeatherState {}

class CurrentWeatherLoadedState extends CurrentWeatherState {
  final CurrentWeatherModel currentWeatherModel;

  const CurrentWeatherLoadedState(this.currentWeatherModel);
  @override
  List<Object> get props => [currentWeatherModel];
}

class CurrentWeatherErrorState extends CurrentWeatherState {
  final String message;
  const CurrentWeatherErrorState(
    this.message,
  );
  @override
  List<Object> get props => [message];
}
