import 'package:freezed_annotation/freezed_annotation.dart';
part 'wind_model.freezed.dart';
part 'wind_model.g.dart';

@freezed
class WindModel with _$WindModel {
  factory WindModel({
    required double speed,
  }) = _WindModel;

  factory WindModel.fromJson(Map<String, Object?> json) =>
      _$WindModelFromJson(json);
}
