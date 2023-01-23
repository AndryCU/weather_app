import 'package:bloc/bloc.dart';
import 'package:weather_app/features/feth_location/domain/entities/geocoding/geo_coding_entity.dart';

import '../../../../../injection/locator.dart';
import '../../../domain/repositories/geo_coding_repository.dart';

class GeoCodingModelSelectedCubit extends Cubit<GeoCodingModel?> {
  GeoCodingModel? geoCodingModel;
  GeoCodingModelSelectedCubit(this.geoCodingModel) : super(null);

  setGeocodingModel(GeoCodingModel geoCodingModel) {
    this.geoCodingModel = geoCodingModel;
    emit(geoCodingModel);
  }

  setGeoCodingModelReversed({required double lat, required double lon}) async {
    final model = await locator
        .get<GeoCodingRepository>()
        .fetchPositionByLatAndLon(lat: lat, lon: lon);
    emit(model);
  }
}
