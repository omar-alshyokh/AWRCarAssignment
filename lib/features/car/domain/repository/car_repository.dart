import 'package:car_tracking_app/features/car/data/models/car_model.dart';
import 'package:car_tracking_app/features/car/domain/entity/car_entity.dart';
import 'package:car_tracking_app/core/model/result.dart';

abstract class CarRepository {
  Future<Result<List<CarEntity>>> getListOfCars();
  Stream<List<CarEntity>> getListOfCarsAsStream();

  Future<void> addCar(CarModel car, String id);
  Stream<CarEntity> getCarAsStream(String id);
}
