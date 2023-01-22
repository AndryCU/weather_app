part of 'main_ui_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class WeatherCallEvent extends WeatherEvent {
  final double lat, lon;
  const WeatherCallEvent(this.lat, this.lon);
}

class WeatherResetEvent extends WeatherEvent {}
