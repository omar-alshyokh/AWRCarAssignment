import 'dart:async';

import 'package:car_tracking_app/core/error/custom_error.dart';
import 'package:car_tracking_app/core/managers/localization/app_translation.dart';
import 'package:car_tracking_app/core/service/logger_service.dart';
import 'package:car_tracking_app/core/utils/app_utils.dart';
import 'package:car_tracking_app/features/car/data/models/car_model.dart';
import 'package:car_tracking_app/features/car/domain/entity/car_entity.dart';
import 'package:car_tracking_app/features/car/domain/repository/car_repository_impl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:car_tracking_app/core/di/di.dart';
import 'package:car_tracking_app/core/error/base_error.dart';

part 'car_event.dart';

part 'car_state.dart';

class CarBloc extends Bloc<CarEvent, CarState> {
  CarBloc() : super(CarInitial()) {
    on<GetCarsEvent>(_getCars);
    on<AddCarEvent>(_addCar);
  }

  // List<CarModel> carList = [
  //   CarModel(
  //     id: '1',
  //     name: 'Car 1',
  //     carID: '1',
  //     brandName: 'Toyota',
  //     imageUrl: 'url_to_image_in_firebase_storage_1',
  //     currentKm: 15000,
  //     pickUpLocationLatitude: 25.2048,
  //     // Dubai Mall
  //     pickUpLocationLongitude: 55.2708,
  //     // Dubai Mall
  //     dropOffLocationLatitude: 25.276987,
  //     // Burj Al Arab
  //     dropOffLocationLongitude: 55.296249,
  //     // Burj Al Arab
  //     currentLocationLatitude: 25.2048,
  //     // Initial current location
  //     currentLocationLongitude: 55.2708,
  //     // Initial current location
  //     pickUpTime: Timestamp.now(),
  //     dropOffTime: Timestamp.now(),
  //     totalKm: 10,
  //     vendorUserName: 'Vendor 1',
  //     vendorContactNumber: 'vendor1@example.com',
  //     licensePlate: 'ABC1234',
  //     modelYear: 2020,
  //     status: 1,
  //   ),
  //   CarModel(
  //     id: '2',
  //     name: 'Car 2',
  //     carID: '2',
  //     brandName: 'Honda',
  //     imageUrl: 'url_to_image_in_firebase_storage_2',
  //     currentKm: 30000,
  //     pickUpLocationLatitude: 25.0657,
  //     // Jumeirah Beach
  //     pickUpLocationLongitude: 55.1713,
  //     // Jumeirah Beach
  //     dropOffLocationLatitude: 25.1972,
  //     // Dubai Marina
  //     dropOffLocationLongitude: 55.2744,
  //     // Dubai Marina
  //     currentLocationLatitude: 25.0657,
  //     // Initial current location
  //     currentLocationLongitude: 55.1713,
  //     // Initial current location
  //     pickUpTime: Timestamp.now(),
  //     dropOffTime: Timestamp.now(),
  //     totalKm: 20,
  //     vendorUserName: 'Vendor 2',
  //     vendorContactNumber: 'vendor2@example.com',
  //     licensePlate: 'XYZ5678',
  //     modelYear: 2018,
  //     status: 2,
  //   ),
  //   CarModel(
  //     id: '3',
  //     name: 'Car 3',
  //     carID: '3',
  //     brandName: 'BMW',
  //     imageUrl: 'url_to_image_in_firebase_storage_3',
  //     currentKm: 50000,
  //     pickUpLocationLatitude: 25.1180,
  //     // Dubai Internet City
  //     pickUpLocationLongitude: 55.2000,
  //     // Dubai Internet City
  //     dropOffLocationLatitude: 25.0781,
  //     // Palm Jumeirah
  //     dropOffLocationLongitude: 55.1424,
  //     // Palm Jumeirah
  //     currentLocationLatitude: 25.1180,
  //     // Initial current location
  //     currentLocationLongitude: 55.2000,
  //     // Initial current location
  //     pickUpTime: Timestamp.now(),
  //     dropOffTime: Timestamp.now(),
  //     totalKm: 15,
  //     vendorUserName: 'Vendor 3',
  //     vendorContactNumber: 'vendor3@example.com',
  //     licensePlate: 'LMN9876',
  //     modelYear: 2021,
  //     status: 3,
  //   ),
  //   CarModel(
  //     id: '4',
  //     name: 'Car 4',
  //     carID: '4',
  //     brandName: 'Mercedes',
  //     imageUrl: 'url_to_image_in_firebase_storage_4',
  //     currentKm: 20000,
  //     pickUpLocationLatitude: 25.276987,
  //     // Burj Al Arab
  //     pickUpLocationLongitude: 55.296249,
  //     // Burj Al Arab
  //     dropOffLocationLatitude: 25.0657,
  //     // Jumeirah Beach
  //     dropOffLocationLongitude: 55.1713,
  //     // Jumeirah Beach
  //     currentLocationLatitude: 25.276987,
  //     // Initial current location
  //     currentLocationLongitude: 55.296249,
  //     // Initial current location
  //     pickUpTime: Timestamp.now(),
  //     dropOffTime: Timestamp.now(),
  //     totalKm: 12,
  //     vendorUserName: 'Vendor 4',
  //     vendorContactNumber: 'vendor4@example.com',
  //     licensePlate: 'GHI1234',
  //     modelYear: 2019,
  //     status: 1,
  //   ),
  //   CarModel(
  //     id: '5',
  //     name: 'Car 5',
  //     carID: '5',
  //     brandName: 'Audi',
  //     imageUrl: 'url_to_image_in_firebase_storage_5',
  //     currentKm: 25000,
  //     pickUpLocationLatitude: 25.1972,
  //     // Dubai Marina
  //     pickUpLocationLongitude: 55.2744,
  //     // Dubai Marina
  //     dropOffLocationLatitude: 25.2048,
  //     // Dubai Mall
  //     dropOffLocationLongitude: 55.2708,
  //     // Dubai Mall
  //     currentLocationLatitude: 25.1972,
  //     // Initial current location
  //     currentLocationLongitude: 55.2744,
  //     // Initial current location
  //     pickUpTime: Timestamp.now(),
  //     dropOffTime: Timestamp.now(),
  //     totalKm: 8,
  //     vendorUserName: 'Vendor 5',
  //     vendorContactNumber: 'vendor5@example.com',
  //     licensePlate: 'JKL3456',
  //     modelYear: 2022,
  //     status: 2,
  //   ),
  // ];

  final CarRepositoryImpl _repository = findDep<CarRepositoryImpl>();

  void _getCars(
    GetCarsEvent event,
    Emitter<CarState> emit,
  ) async {
    emit(CarLoading());

    // final results = await _repository.getListOfCars();
    await emit.forEach(
      _repository.getListOfCarsAsStream(),
      onData: (cars) => GetCarsSuccess(cars: cars),
      onError: (e, s) {
        appPrint("onError $s");
        LoggerService().logError(e.toString());
        return const GetCarsFailed(
            error: CustomError(message: 'Failed to fetch cars.'));
      },
    );
    // if (results.hasDataOnly) {
    //   emit(GetCarsSuccess(cars: results.data!));
    // } else {
    //   emit(GetCarsFailed(error: results.error!));
    // }
  }

  FutureOr<void> _addCar(AddCarEvent event, Emitter<CarState> emit) async {
    try {
      emit(AddCarLoading());

      await _repository.addCar(event.car, event.car.id);

      emit(AddCarSuccess());
    } catch (e) {
      if (e is BaseError) {
        emit(AddCarFailed(error: e));
      } else {
        emit(AddCarFailed(
            error: CustomError(message: translate.something_went_wrong)));
        LoggerService().logError(e.toString());
      }
    }
  }
}
