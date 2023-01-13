import 'package:weather_app/features/feth_weather/data/models/geocoding/geo_coding_model.dart';
import 'package:weather_app/features/feth_weather/domain/repositories/geo_coding_repository.dart';

class ListGeoCodingUseCase {
  GeoCodingRepository _geoCodingRepository;

  ListGeoCodingUseCase(this._geoCodingRepository);

  Future<List<GeoCodingModel>> getCitiesNames(String city) async {
    List<GeoCodingModel> cities = [];
    final result = await _geoCodingRepository.getPositionByName(city);
    cities.addAll(result);
    return cities;
  }
}
