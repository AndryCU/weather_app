import 'package:dartz/dartz.dart';

import '../entities/next_days_weather_main.dart';

abstract class NextDaysWeatherRepository {
  Future<Either<Exception, WeatherByDaysMainEntity>> getNextDaysWeather(
      {required double lat, required double lon});
}
