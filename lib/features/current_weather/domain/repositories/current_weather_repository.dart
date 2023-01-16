import 'package:dartz/dartz.dart';

import '../entities/current_weather_entity.dart';

abstract class CurrentWeatherRepository {
  Future<Either<Exception, CurrentWeatherModel>> getCurrentWeather(
      {required double lat, required double lon});
}
