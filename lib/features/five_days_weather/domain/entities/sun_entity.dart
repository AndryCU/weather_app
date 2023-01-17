import 'package:freezed_annotation/freezed_annotation.dart';
part 'sun_entity.freezed.dart';
part 'sun_entity.g.dart';

@freezed
class SunDataEntity with _$SunDataEntity {
  factory SunDataEntity({
    required int sunrise,
    required int sunset,
  }) = _SunDataEntity;
  factory SunDataEntity.fromJson(Map<String, Object?> json) =>
      _$SunDataEntityFromJson(json);
}
