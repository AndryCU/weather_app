part of 'current_weather_bloc.dart';

abstract class CurrentWeatherEvent {}

class CurrentWeatherStarted extends CurrentWeatherEvent {
  final double lat, lon;
  CurrentWeatherStarted(this.lat, this.lon);
}
