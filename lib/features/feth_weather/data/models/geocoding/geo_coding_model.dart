import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather_app/features/feth_weather/domain/entities/geocoding/geo_coding_entity.dart';
part 'geo_coding_model.g.dart';

@JsonSerializable()
class GeoCodingModel extends GeoCoding {
  const GeoCodingModel(
      {required double lat,
      required double lon,
      required String name,
      required String country,
      required String state})
      : super(lat: lat, lon: lon, country: country, name: name, state: state);

  factory GeoCodingModel.fromJson(Map<String, Object?> json) =>
      _$GeoCodingModelFromJson(json);
}
