import 'package:geolocator/geolocator.dart';
import 'package:weather_app/features/fetch_location_gps/domain/repositories/location_gps_repository.dart';

class LocationGpsRepositoryImplementation implements LocationGpsRepository {
  @override
  Future<Position?> getCurrentLocation() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
        timeLimit: const Duration(minutes: 2));
  }
}
