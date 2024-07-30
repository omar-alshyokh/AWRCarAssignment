import 'package:car_tracking_app/core/error/custom_error.dart';
import 'package:car_tracking_app/core/managers/firebase/firebase_constants.dart';
import 'package:car_tracking_app/core/model/query_condition_model.dart';
import 'package:car_tracking_app/features/car/data/datasource/car_datasource.dart';
import 'package:car_tracking_app/features/car/data/datasource/car_firebase_datasource.dart';
import 'package:car_tracking_app/features/car/data/models/car_model.dart';
import 'package:injectable/injectable.dart';
import 'package:car_tracking_app/core/model/result.dart';

@LazySingleton(as: CarDatasource)
class CarDatasourceImpl extends CarDatasource {
  final CarFirebaseDatasource _carFirebaseDatasource;

  CarDatasourceImpl(this._carFirebaseDatasource);

  @override
  Future<void> addCar(
      {required CarModel car,
      required String id,
      FirebaseCollectionName? customCollection}) {
    return _carFirebaseDatasource.addCar(car, id,
        customCollection: customCollection);
  }

  @override
  Future<Result<List<CarModel>>> getListOfCars(
      {List<QueryConditionModel>? conditions}) {
    return _carFirebaseDatasource
        .getCarsAsFuture(conditions: conditions)
        .then((v) => Result(data: v));
  }

  @override
  Stream<List<CarModel>> getListOfCarsAsStream(
      {QueryConditionModel? condition}) {
    return _carFirebaseDatasource.getCarsAsStream(condition: condition);
  }

  @override
  Future<Result<CarModel>> getCar(
      {required String id, FirebaseCollectionName? customCollection}) {
    return _carFirebaseDatasource
        .getCar(id, customCollection: customCollection)
        .then((v) => Result(data: v))
        .onError((e, _) => Result(error: CustomError(message: e.toString())));
  }

  @override
  Future<void> updateCar(
      {required CarModel car,
      required String id,
      FirebaseCollectionName? customCollection}) {
    return _carFirebaseDatasource.updateCar(car, id,
        customCollection: customCollection);
  }

  @override
  Stream<CarModel?> getCarAsStream(String id,
      {FirebaseCollectionName? customCollection}) {
    return _carFirebaseDatasource.getCarAsStream(id,
        customCollection: customCollection);
  }
}
