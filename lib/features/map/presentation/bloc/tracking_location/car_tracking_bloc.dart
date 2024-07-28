import 'package:car_tracking_app/core/utils/map_location_util.dart';
import 'package:car_tracking_app/features/car/domain/entity/car_entity.dart';
import 'package:car_tracking_app/features/map/domin/repository/location_simulation_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';

part 'car_tracking_event.dart';

part 'car_tracking_state.dart';

@Singleton()
class CarLiveTrackingBloc
    extends Bloc<CarLiveTrackingEvent, CarLiveTrackingState> {
  final LocationSimulationRepo locationSimulationRepo;

  CarLiveTrackingBloc(this.locationSimulationRepo)
      : super(CarLiveTrackingInitial()) {
    on<StartLiveTracking>(_mapStartLiveTrackingToState);
  }

  void _mapStartLiveTrackingToState(
      StartLiveTracking event, Emitter<CarLiveTrackingState> emit) async {
    final car = event.car;
    final startLocation =
        LatLng(car.currentLocationLatitude, car.currentLocationLongitude);
    final endLocation =
        LatLng(car.dropOffLocationLatitude, car.dropOffLocationLongitude);

    await for (final newLocation in locationSimulationRepo.simulateLocation(
        startLocation, endLocation, 60)) {
      final bearing = MapLocationUtil.calculateBearing(newLocation, endLocation);
      emit(CarLiveTrackingInProgress(
        currentLocation: newLocation,
        bearing: bearing
      ));
    }
  }
}
