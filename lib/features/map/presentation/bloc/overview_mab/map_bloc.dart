import 'package:car_tracking_app/core/error/custom_error.dart';
import 'package:car_tracking_app/core/helper/location_helper.dart';
import 'package:car_tracking_app/core/service/logger_service.dart';
import 'package:car_tracking_app/core/utils/app_utils.dart';
import 'package:car_tracking_app/features/car/domain/entity/car_entity.dart';
import 'package:car_tracking_app/features/car/domain/repository/car_repository_impl.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:car_tracking_app/core/di/di.dart';
import 'package:car_tracking_app/core/error/base_error.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'map_event.dart';

part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapInitial()) {
    on<GetCarsLocationEvent>(_getCars);
  }

  final CarRepositoryImpl _repository = findDep<CarRepositoryImpl>();

  void _getCars(GetCarsLocationEvent event,
      Emitter<MapState> emit,) async {
    emit(MapLoading());

    // final results = await _repository.getListOfCars();
    await emit.forEach(
      _repository.getListOfCarsAsStream(),
      onData: (cars) {
        final latLngBounds = LocationHelper.getLatLngBounds(cars.map((e) =>
            LatLng(e.currentLocationLatitude, e.currentLocationLongitude))
            .toList());
        return GetCarsLocationSuccess(cars: cars, latLngBounds:latLngBounds);
      },
      onError: (e, s) {
        appPrint("onError $s");
        LoggerService().logError(e.toString());
        return const GetCarsLocationFailed(
            error: CustomError(message: 'Failed to fetch cars location.'));
      },
    );
  }
}
