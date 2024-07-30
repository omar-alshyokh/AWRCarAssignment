import 'dart:math';

import 'package:car_tracking_app/core/error/base_error.dart';
import 'package:car_tracking_app/core/error/custom_error.dart';
import 'package:car_tracking_app/core/helper/location_helper.dart';
import 'package:car_tracking_app/core/helper/shared_preference_helper.dart';
import 'package:car_tracking_app/core/managers/localization/app_translation.dart';
import 'package:car_tracking_app/core/service/logger_service.dart';
import 'package:car_tracking_app/features/car/domain/entity/car_entity.dart';
import 'package:car_tracking_app/features/vendor/domain/repository/vendor_repository_impl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';

part 'vendor_car_details_event.dart';

part 'vendor_car_details_state.dart';

@Injectable()
class VendorCarDetailsBloc
    extends Bloc<VendorCarDetailsEvent, VendorCarDetailsState> {
  final VendorRepositoryImpl _repository;
  final SharedPreferenceHelper _sharedPreferenceHelper;

  VendorCarDetailsBloc(this._repository, this._sharedPreferenceHelper)
      : super(VendorCarDetailsInitial()) {
    on<StartDelivery>(_mapStartDelivery);
    on<CompleteDelivery>(_mapCompleteDelivery);
  }

  void _mapStartDelivery(
    StartDelivery event,
    Emitter<VendorCarDetailsState> emit,
  ) async {
    emit(VendorCarDetailsLoading());
    try {
      final result = await _repository.getCar(id: event.carId);
      if (result.hasDataOnly) {
        final car = result.data!;
        car.status = CarStatusType.delivering.value;
        car.pickUpTime = Timestamp.now();
        car.vendorUserName = _sharedPreferenceHelper.vendorFullName;
        car.vendorContactNumber = _sharedPreferenceHelper.vendorContactNumber;

        await _repository.updateCar(car: car, id: event.carId);
        emit(VendorCarDetailsUpdatedToDelivering());
        final latLngBounds = LocationHelper.getLatLngBounds([
          LatLng(car.pickUpLocationLatitude, car.pickUpLocationLongitude),
          LatLng(car.dropOffLocationLatitude, car.dropOffLocationLongitude),
        ]);
        emit(VendorCarDetailsLoaded(car: car,latLngBounds: latLngBounds));
      } else {
        emit(VendorCarDetailsError(
            error: CustomError(message: translate.car_not_found)));
      }
    } catch (e, s) {
      LoggerService().logError(e.toString(), e, s);
      emit(VendorCarDetailsError(
          error: CustomError(message: translate.unknown_error)));
    }
  }

  /// simulation for car delivery successfully
  void _mapCompleteDelivery(
    CompleteDelivery event,
    Emitter<VendorCarDetailsState> emit,
  ) async {
    emit(VendorCarDetailsLoading());
    try {
      final result = await _repository.getCar(id: event.carId);
      if (result.hasDataOnly) {
        Random rnd = Random();
        int min = 10;
        int max = 100;
        int totalDistanceKm = min + rnd.nextInt(max - min);
        final car = result.data!;
        car.status = CarStatusType.delivered.value;
        car.dropOffTime = Timestamp.now();
        car.totalKm = totalDistanceKm.toString();
        car.currentLocationLongitude = car.dropOffLocationLongitude;
        car.currentLocationLatitude = car.dropOffLocationLatitude;

        await _repository.updateCar(car: car, id: event.carId);
        emit(VendorCarDetailsUpdatedToDelivered());
        final latLngBounds = LocationHelper.getLatLngBounds([
          LatLng(car.pickUpLocationLatitude, car.pickUpLocationLongitude),
          LatLng(car.dropOffLocationLatitude, car.dropOffLocationLongitude),
        ]);
        emit(VendorCarDetailsLoaded(car: car,latLngBounds: latLngBounds));
      } else {
        emit(VendorCarDetailsError(
            error: CustomError(message: translate.car_not_found)));
      }
    } catch (e, s) {
      LoggerService().logError(e.toString(), e, s);
      emit(VendorCarDetailsError(
          error: CustomError(message: translate.unknown_error)));
    }
  }
}
