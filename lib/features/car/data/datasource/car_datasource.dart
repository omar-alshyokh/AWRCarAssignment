import 'package:car_tracking_app/core/managers/firebase/firebase_constants.dart';
import 'package:car_tracking_app/features/car/data/models/car_model.dart';
import 'package:car_tracking_app/core/model/result.dart';

abstract class CarDatasource {
  Future<Result<List<CarModel>>> getListOfCars();
  Stream<List<CarModel>> getListOfCarsAsStream();

  Future<void> addCar(CarModel car, String id,
      {FirebaseCollectionName? customCollection});
}
