import 'package:car_tracking_app/core/model/query_condition_model.dart';
import 'package:car_tracking_app/features/car/data/datasource/car_datasource.dart';
import 'package:car_tracking_app/features/car/data/models/car_model.dart';
import 'package:car_tracking_app/features/car/domain/entity/car_entity.dart';
import 'package:car_tracking_app/features/vendor/domain/repository/vendor_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:car_tracking_app/core/model/result.dart';
import 'package:car_tracking_app/core/repository/base_repository.dart';

@LazySingleton()
class VendorRepositoryImpl extends BaseRepository implements VendorRepository {
  final CarDatasource _carDatasource;

  VendorRepositoryImpl(this._carDatasource);

  @override
  Future<Result<List<CarEntity>>> getListOfCars(
      {List<QueryConditionModel>? conditions}) async {
    final result = await _carDatasource.getListOfCars(conditions: conditions);
    return executeForList<CarModel, CarEntity>(remoteResult: result);
  }

  @override
  Stream<List<CarEntity>> getListOfCarsAsStream(
      {QueryConditionModel? condition}) {
    return _carDatasource.getListOfCarsAsStream(condition: condition).map(
        (carModels) =>
            carModels.map((carModel) => carModel.toEntity()).toList());
  }

  @override
  Future<Result<CarEntity>> getCar({required String id}) async {
    final result = await _carDatasource.getCar(id: id);
    return execute<CarModel, CarEntity>(remoteResult: result);
  }

  @override
  Future<void> updateCar({required CarEntity car, required String id}) async {
    await _carDatasource.updateCar(id: id, car: car.toCarModel());
  }
}
