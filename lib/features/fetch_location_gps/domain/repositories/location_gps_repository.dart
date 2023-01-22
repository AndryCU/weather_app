import 'package:geolocator/geolocator.dart';

abstract class LocationGpsRepository {
  Future<Position?> getCurrentLocation();
}
