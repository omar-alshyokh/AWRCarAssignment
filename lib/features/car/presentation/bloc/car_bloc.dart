import 'dart:async';

import 'package:car_tracking_app/core/error/custom_error.dart';
import 'package:car_tracking_app/core/managers/localization/app_translation.dart';
import 'package:car_tracking_app/core/service/logger_service.dart';
import 'package:car_tracking_app/core/utils/app_utils.dart';
import 'package:car_tracking_app/features/car/data/models/car_model.dart';
import 'package:car_tracking_app/features/car/domain/entity/car_entity.dart';
import 'package:car_tracking_app/features/car/domain/repository/car_repository_impl.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:car_tracking_app/core/error/base_error.dart';
import 'package:injectable/injectable.dart';

part 'car_event.dart';

part 'car_state.dart';
@Injectable()
class CarBloc extends Bloc<CarEvent, CarState> {
  final CarRepositoryImpl _repository;
  CarBloc(this._repository) : super(CarInitial()) {
    on<GetCarsEvent>(_mapGetCars);
    on<AddCarEvent>(_mapAddCar);
    on<LoadCarDetails>(_mapLoadCarDetails);
  }

  void _mapGetCars(
    GetCarsEvent event,
    Emitter<CarState> emit,
  ) async {
    emit(CarLoading());

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
  }

  FutureOr<void> _mapAddCar(AddCarEvent event, Emitter<CarState> emit) async {
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

  void _mapLoadCarDetails(
    LoadCarDetails event,
    Emitter<CarState> emit,
  ) async {
    emit(CarLoading());
    try {
      final carStream = _repository.getCarAsStream(event.carId);
      await for (final car in carStream) {
        emit(CarDetailsLoaded(car: car));
      }
    } catch (e) {
      LoggerService().logError(e.toString(), e);
      emit(CarDetailsFailed(
          error: CustomError(message: translate.unknown_error)));
    }
  }
}
