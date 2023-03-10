import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:weather_app/features/five_days_weather/domain/entities/next_days_weather_main.dart';

import '../../../../../../core/exeptions.dart';
import '../../../../core/const/end_points.dart';
import '../../../../core/const/keys.dart';
import '../../../../core/platfoms/platfoms.dart';
import '../../domain/repositories/next_days_repository.dart';

import 'package:http/http.dart' as http;

class NextDaysWeatherRepositoryImplementation
    extends NextDaysWeatherRepository {
  @override
  Future<Either<Exception, WeatherByDaysMainEntity>> getNextDaysWeather(
      {required double lat, required double lon}) async {
    if (!(await CheckInternetConnection.checkIfHaveInternet())) {
      return Left(NoInternetException());
    }
    final uri = Uri(
      host: baseUrl,
      scheme: 'https',
      path: nextDaysEndPoint,
      queryParameters: {
        'lat': '$lat',
        'lon': '$lon',
        'appid': openWeatherMapKey,
      },
    );
    final response = await http.get(uri).timeout(
          const Duration(seconds: 20),
        );
    if (response.statusCode == 200) {
      return Right(
          WeatherByDaysMainEntity.fromJson(json.decode(response.body)));
    } else {
      return Left(ApiError(response.statusCode));
    }
  }
}
