import 'package:car_tracking_app/core/managers/firebase/firebase_constants.dart';
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
  Future<void> addCar(CarModel car, String id, {FirebaseCollectionName? customCollection}) {
    return _carFirebaseDatasource.addCar(car, id,
        customCollection: customCollection);
  }

  @override
  Future<Result<List<CarModel>>> getListOfCars() {
    return _carFirebaseDatasource
        .getCarsAsFuture()
        .then((v) => Result(data: v));
  }

  @override
  Stream<List<CarModel>> getListOfCarsAsStream() {
    return _carFirebaseDatasource
        .getCarsAsStream();
  }
}
