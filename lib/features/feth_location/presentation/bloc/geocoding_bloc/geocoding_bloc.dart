import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

import '../../../../../injection/locator.dart';
import '../../../domain/entities/geocoding/geo_coding_entity.dart';
import '../../../domain/usecases/geo_coding_list.dart';

part 'geocoding_event.dart';
part 'geocoding_state.dart';

class GeoCodingBloc extends Bloc<GeoCodingEvent, GeoCodingBlocState> {
  GeoCodingBloc() : super(GeoCodingInitialState()) {
    on<FindLocationByNameEvent>((event, emit) async {
      emit(GeoCodingLoadingState());
      final list = await locator
          .get<ListGeoCodingUseCase>()
          .getCitiesNames(event.location);

      emit(GeoCodingLoadedState(newCountries: list));
    });
  }
}
