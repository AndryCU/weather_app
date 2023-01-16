import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:weather_app/core/const/end_points.dart';
import 'package:weather_app/core/const/keys.dart';
import 'package:weather_app/core/platfoms/internet_checker.dart';

import '../../../../../../core/exeptions.dart';
import '../../../../core/platfoms/network_handler.dart';
import '../../domain/entities/geocoding/geo_coding_entity.dart';
import '../../domain/repositories/geo_coding_repository.dart';

class GeoCodingRepositoryImplantation extends GeoCodingRepository {
  final ApiHandler _apiHandler;
  GeoCodingRepositoryImplantation(this._apiHandler);
  @override
  Future<List<GeoCodingModel>> getPositionByName(String city) async {
    if (!(await CheckInternetConnection.checkIfHaveInternet())) {
      throw NoInternetException();
    }
    Map<String, String> body = {
      'q': city,
      'appid': openWeatherMapKey,
      'limit': '5',
    };
    final response = await _apiHandler.get(
      path: geoCodingEndPoint,
      queryParameters: body,
    );
    if (response.statusCode == 200) {
      final decoded = json.decode(response.body) as List;
      List<GeoCodingModel> test = [];
      List<GeoCodingModel> itemsList = List<GeoCodingModel>.from(decoded
          .map<GeoCodingModel>((dynamic i) => GeoCodingModel.fromJson(i)));
      (json.decode(response.body) as List)
          .map((data) => test.add(GeoCodingModel.fromJson(data)))
          .toList();
      return itemsList;
    } else {
      //TODO buscar los posibles codigos de error
      throw ApiError(response.statusCode);
    }
  }
}
