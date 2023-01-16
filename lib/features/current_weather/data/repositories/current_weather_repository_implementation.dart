import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:weather_app/core/exeptions.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/core/platfoms/share_preferences_handler.dart';
import 'package:weather_app/injection/locator.dart';

import '../../../../core/const/end_points.dart';
import '../../../../core/const/keys.dart';
import '../../../../core/platfoms/internet_checker.dart';
import '../../../../core/platfoms/network_handler.dart';
import '../../domain/entities/current_weather_entity.dart';
import '../../domain/repositories/current_weather_repository.dart';

class CurrentWeatherRepositoryImplementation extends CurrentWeatherRepository {
  final ApiHandler _apiHandler;
  CurrentWeatherRepositoryImplementation(this._apiHandler);
  @override
  Future<Either<Exception, CurrentWeatherModel>> getCurrentWeather({
    required double lat,
    required double lon,
  }) async {
    final unitValue =
        await locator.get<SharedPreferencesManager>().getUnitValue();
    Map<String, String> body = {
      'lat': '$lat',
      'lon': '$lon',
      'appid': openWeatherMapKey,
      'units': unitValue == true ? 'metric' : 'imperial',
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
