part of 'five_days_weather_bloc.dart';

abstract class FiveDaysWeatherEvent extends Equatable {
  const FiveDaysWeatherEvent();

  @override
  List<Object> get props => [];
}

class GetNextDaysWeatherEvent extends FiveDaysWeatherEvent {
  final double lat, lon;
  const GetNextDaysWeatherEvent(this.lat, this.lon);
}
