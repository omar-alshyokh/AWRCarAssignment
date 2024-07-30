import 'package:car_tracking_app/core/managers/firebase/firebase_constants.dart';
import 'package:car_tracking_app/core/model/query_condition_model.dart';
import 'package:car_tracking_app/features/car/data/models/car_model.dart';
import 'package:car_tracking_app/core/model/result.dart';

abstract class CarDatasource {
  Future<Result<List<CarModel>>> getListOfCars(
      {List<QueryConditionModel>? conditions});

  Stream<List<CarModel>> getListOfCarsAsStream(
      {QueryConditionModel? condition});

  Future<void> addCar(
      {required CarModel car,
      required String id,
      FirebaseCollectionName? customCollection});

  Future<Result<CarModel>> getCar(
      {required String id, FirebaseCollectionName? customCollection});

  Stream<CarModel?> getCarAsStream(String id,
      {FirebaseCollectionName? customCollection});

  Future<void> updateCar(
      {required CarModel car,
      required String id,
      FirebaseCollectionName? customCollection});
}
