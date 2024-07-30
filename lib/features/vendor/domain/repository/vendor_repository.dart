import 'package:car_tracking_app/core/model/query_condition_model.dart';
import 'package:car_tracking_app/features/car/domain/entity/car_entity.dart';
import 'package:car_tracking_app/core/model/result.dart';

abstract class VendorRepository {
  Future<Result<List<CarEntity>>> getListOfCars(
      {List<QueryConditionModel>? conditions});

  Stream<List<CarEntity>> getListOfCarsAsStream(
      {QueryConditionModel? condition});

  Future<Result<CarEntity>> getCar({required String id});

  Future<void> updateCar({required CarEntity car,required String id});
}
