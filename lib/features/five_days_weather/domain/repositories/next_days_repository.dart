import 'package:dartz/dartz.dart';
import 'package:weather_app/features/five_days_weather/domain/entities/next_days_weather_main.dart';

abstract class NextDaysWeatherRepository {
  Future<Either<Exception, WeatherByDaysMainEntity>> getNextDaysWeather(
      {required double lat, required double lon});
}
