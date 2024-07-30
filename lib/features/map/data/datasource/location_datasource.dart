import 'package:car_tracking_app/core/model/result.dart';
import 'package:car_tracking_app/features/map/data/models/route_item_model.dart';

abstract class LocationDatasource {
  Future<Result<List<RouteItemModel>>> getRoutesByKey({required String key});
  Future<Result> setLocalRoutesByKey(
      {required List<RouteItemModel> routes,required String key});

  Future<bool> routeExists({required String key});
}
