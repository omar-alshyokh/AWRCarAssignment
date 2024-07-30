import 'package:car_tracking_app/core/error/no_cache_data_found_error.dart';
import 'package:car_tracking_app/core/managers/localdb/route_box_handler.dart';
import 'package:car_tracking_app/core/model/result.dart';
import 'package:car_tracking_app/core/service/logger_service.dart';
import 'package:car_tracking_app/features/map/data/models/route_item_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class LocationLocalDataSource {
  // injecting local storage instance
  final RouteBoxHandler _routeBoxHandler;

  LocationLocalDataSource(this._routeBoxHandler);

  Future<Result<List<RouteItemModel>>> getRoutesByKey(
      {required String key}) async {
    try {
      var cached = await _routeBoxHandler.get(key: key);
      return Result(data: cached);
    } catch (e) {
      rethrow;
    }
  }

  Future<Result> setLocalRoutesByKey(
      {required List<RouteItemModel> routes, required String key}) async {
    try {
      await _routeBoxHandler.delete(key: key).whenComplete(
          () async => await _routeBoxHandler.put(routes, key: key));

      return Result(data: routes);
    } catch (e) {
      throw const Result(error: NoCacheDataFoundError());
    }
  }

  Future<bool> routeExists({required String key}) {
    try {
      return _routeBoxHandler.routeExists(key);
    } catch (e, s) {
      LoggerService().logError(e.toString(), e, s);
      return Future.value(false);
    }
  }
}
