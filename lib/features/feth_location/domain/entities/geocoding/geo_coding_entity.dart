import 'package:freezed_annotation/freezed_annotation.dart';
part 'geo_coding_entity.freezed.dart';
part 'geo_coding_entity.g.dart';

@freezed
class GeoCodingModel with _$GeoCodingModel {
  factory GeoCodingModel({
    required double lat,
    required double lon,
    required String name,
    required String country,
    String? state,
  }) = _GeoCodingModel;
  factory GeoCodingModel.fromJson(Map<String, Object?> json) =>
      _$GeoCodingModelFromJson(json);
}
