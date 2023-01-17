import 'package:dartz/dartz.dart';
import 'package:weather_app/features/five_days_weather/domain/repositories/next_days_repository.dart';

import '../entities/next_days_weather_main.dart';

class NextDaysUseCase {
  final NextDaysWeatherRepository _nextDaysWeatherRepository;

  NextDaysUseCase(this._nextDaysWeatherRepository);

  Future<Either<Exception, WeatherByDaysMainEntity>> getNextDaysWeather(
      {required double lat, required double lon}) async {
    final nextWeather =
        await _nextDaysWeatherRepository.getNextDaysWeather(lat: lat, lon: lon);
    return nextWeather;
  }
}
