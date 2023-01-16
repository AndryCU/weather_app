import 'package:dartz/dartz.dart';

import '../entities/current_weather_entity.dart';
import '../repositories/current_weather_repository.dart';

class CurrentWeatherUseCase {
  final CurrentWeatherRepository _currentWeatherRepository;
  CurrentWeatherUseCase(this._currentWeatherRepository);

  Future<Either<Exception, CurrentWeatherModel>> getCurrentWeather(
      {required double lat, required double lon}) async {
    final current =
        await _currentWeatherRepository.getCurrentWeather(lat: lat, lon: lon);
    return current;
  }
}
