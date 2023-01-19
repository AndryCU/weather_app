import 'package:dartz/dartz.dart';

import '../entities/geocoding/geo_coding_entity.dart';
import '../repositories/geo_coding_repository.dart';

class ListGeoCodingUseCase {
  final GeoCodingRepository _geoCodingRepository;

  ListGeoCodingUseCase(this._geoCodingRepository);

  Future<List<GeoCodingModel>> getCitiesNames(String city) async {
    final result = await _geoCodingRepository.fetchPositionByName(city);
    return result;
  }
}
