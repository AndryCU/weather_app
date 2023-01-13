import 'dart:convert';

import 'package:weather_app/const/end_points.dart';
import 'package:weather_app/const/keys.dart';
import 'package:weather_app/features/feth_weather/data/models/geocoding/geo_coding_model.dart';
import 'package:weather_app/features/feth_weather/domain/repositories/geo_coding_repository.dart';
import 'package:http/http.dart' as http;

class GeoCodingRepositoryImplantation extends GeoCodingRepository {
  final cliente = http.Client();
  @override
  Future<List<GeoCodingModel>> getPositionByName(String city) async {
    var d = Uri(
      host: 'api.openweathermap.org',
      scheme: 'https',
      path: geoCodingEndPoint,
      queryParameters: {
        'q': city,
        'appid': openWeatherMapKey,
        'limit': '5',
      },
    );
    final response = await http.get(d, headers: {'appid': openWeatherMapKey});
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
      throw Exception();
    }
  }
}
