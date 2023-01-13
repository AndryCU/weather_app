import 'package:equatable/equatable.dart';

class GeoCoding extends Equatable {
  final String name, country, state;
  final double lat, lon;
  const GeoCoding({
    required this.name,
    required this.lat,
    required this.lon,
    required this.country,
    required this.state,
  });
  @override
  List<Object?> get props => [lat, lon];
}
