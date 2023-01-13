import '../../data/models/geocoding/geo_coding_model.dart';

abstract class GeoCodingRepository {
  Future<List<GeoCodingModel>> getPositionByName(String city);
}
