import 'package:car_tracking_app/core/service/logger_service.dart';
import 'package:car_tracking_app/features/car/data/datasource/car_datasource.dart';
import 'package:car_tracking_app/features/car/data/models/car_model.dart';
import 'package:car_tracking_app/features/car/domain/entity/car_entity.dart';
import 'package:car_tracking_app/features/car/domain/repository/car_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:car_tracking_app/core/model/result.dart';
import 'package:car_tracking_app/core/repository/base_repository.dart';

@LazySingleton()
class CarRepositoryImpl extends BaseRepository implements CarRepository {
  final CarDatasource _datasource;

  CarRepositoryImpl(this._datasource);

  @override
  Future<void> addCar(CarModel car, String id) async {
    await _datasource.addCar(car: car, id: id);
  }

  @override
  Future<Result<List<CarEntity>>> getListOfCars() async {
    final result = await _datasource.getListOfCars();
    return executeForList<CarModel, CarEntity>(remoteResult: result);
  }

  @override
  Stream<List<CarEntity>> getListOfCarsAsStream() {
    return _datasource.getListOfCarsAsStream().map((carModels) =>
        carModels.map((carModel) => carModel.toEntity()).toList());
  }

  @override
  Stream<CarEntity> getCarAsStream(String id) {
    try {
      return _datasource.getCarAsStream(id).map((model) => model!.toEntity());
    } catch (e, s) {
      LoggerService().logError(e.toString(), e, s);
      rethrow;
    }
  }
}
