import 'package:dartz/dartz.dart';

import '../entities/current_weather_entity.dart';

abstract class CurrentWeatherRepository {
  Future<Either<Exception, CurrentWeatherModel>> fetchCurrentWeather(
      {required double lat, required double lon});
}
