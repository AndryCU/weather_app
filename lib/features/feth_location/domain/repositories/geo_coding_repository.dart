import 'package:dartz/dartz.dart';

import '../entities/geocoding/geo_coding_entity.dart';

abstract class GeoCodingRepository {
  Future<List<GeoCodingModel>> getPositionByName(String city);
}
