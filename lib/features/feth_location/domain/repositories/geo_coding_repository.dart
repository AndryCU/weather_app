import 'package:dartz/dartz.dart';

import '../entities/geocoding/geo_coding_entity.dart';

abstract class GeoCodingRepository {
  Future<List<GeoCodingModel>> fetchPositionByName(String city);
  Future<GeoCodingModel> fetchPositionByLatAndLon(
      {required double lat, required double lon});
}
