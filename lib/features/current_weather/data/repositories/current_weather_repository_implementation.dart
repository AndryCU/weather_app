import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:weather_app/core/exeptions.dart';

import '../../../../core/const/end_points.dart';
import '../../../../core/const/keys.dart';
import '../../../../core/platfoms/platfoms.dart';
import '../../domain/entities/current_weather_entities.dart';
import '../../domain/repositories/current_weather_repository.dart';

class CurrentWeatherRepositoryImplementation extends CurrentWeatherRepository {
  final ApiHandler _apiHandler;
  CurrentWeatherRepositoryImplementation(this._apiHandler);
  @override
  Future<Either<Exception, CurrentWeatherModel>> fetchCurrentWeather({
    required double lat,
    required double lon,
  }) async {
    Map<String, String> body = {
      'lat': '$lat',
      'lon': '$lon',
      'appid': openWeatherMapKey,
    };
    if (!(await CheckInternetConnection.checkIfHaveInternet())) {
      return Left(NoInternetException());
    }
    final response = await _apiHandler
        .get(path: currentWeatherEndPoint, queryParameters: body)
        .timeout(const Duration(seconds: 10));
    if (response.statusCode == 200) {
      return Right(CurrentWeatherModel.fromJson(json.decode(response.body)));
    } else {
      return Left(ApiError(response.statusCode));
    }
  }
}
