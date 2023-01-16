part of 'geocoding_bloc.dart';

abstract class GeoCodingEvent {}

class FindLocationByNameEvent extends GeoCodingEvent {
  final String location;
  FindLocationByNameEvent(this.location);
}
