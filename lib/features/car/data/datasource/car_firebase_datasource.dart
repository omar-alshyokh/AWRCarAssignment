import 'package:car_tracking_app/core/managers/firebase/base_firebase_service.dart';
import 'package:car_tracking_app/core/managers/firebase/firebase_constants.dart';
import 'package:car_tracking_app/core/model/query_condition_model.dart';
import 'package:car_tracking_app/features/car/data/models/car_model.dart';
import 'package:injectable/injectable.dart';

@Singleton()
class CarFirebaseDatasource extends BaseFirebaseService<CarModel> {
  CarFirebaseDatasource() : super(FirebaseCollectionName.cars);

  Future<void> addCar(CarModel car, String id,
      {FirebaseCollectionName? customCollection}) async {
    await addItem(car, id, (car) => car.toJson(),
        customCollection: customCollection);
  }

  Future<void> updateCar(CarModel car, String id,
      {FirebaseCollectionName? customCollection}) async {
    await updateItem(car, id, (car) => car.toJson(),
        customCollection: customCollection);
  }

  Future<void> deleteCar(String id,
      {FirebaseCollectionName? customCollection}) async {
    await deleteItem(id, customCollection: customCollection);
  }

  Future<CarModel?> getCar(String id,
      {FirebaseCollectionName? customCollection}) async {
    return await getItem(id, (data) => CarModel.fromJson(data),
        customCollection: customCollection);
  }

  Stream<CarModel?> getCarAsStream(String id,
      {FirebaseCollectionName? customCollection}) {
    return getItemAsStream(id, (data) => CarModel.fromJson(data),
        customCollection: customCollection);
  }

  Stream<List<CarModel>> getCarsAsStream(
      {FirebaseCollectionName? customCollection,
      QueryConditionModel? condition}) {
    // return getItemsAsStream((data) => CarModel.fromJson(data),
    //     customCollection: customCollection);
    return getItemsAsStream(
      (data) => CarModel.fromJson(data),
      customCollection: customCollection,
      queryBuilder: (query) {
        if (condition != null) {
          switch (condition.operator) {
            case QueryConditionOperatorType.isEqualTo:
              query = query.where(condition.field, isEqualTo: condition.value);
              break;
            case QueryConditionOperatorType.isGreaterThan:
              query =
                  query.where(condition.field, isGreaterThan: condition.value);
              break;
            case QueryConditionOperatorType.isLessThan:
              query = query.where(condition.field, isLessThan: condition.value);
              break;
            default:
              query = query.where(condition.field, isEqualTo: condition.value);
          }
        }
        return query;
      },
    );
  }

  Future<List<CarModel>> getCarsAsFuture(
      {FirebaseCollectionName? customCollection,
      List<QueryConditionModel>? conditions}) async {
    return await getItemsAsFuture(
      (data) => CarModel.fromJson(data),
      customCollection: customCollection,
      queryBuilder: (query) {
        if (conditions != null) {
          for (var condition in conditions) {
            query = query.where(condition.field, isEqualTo: condition.value);
          }
        }
        return query;
      },
    );
  }
}
