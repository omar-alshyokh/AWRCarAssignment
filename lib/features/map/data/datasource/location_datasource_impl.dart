import 'package:car_tracking_app/features/map/data/datasource/location_datasource.dart';
import 'package:car_tracking_app/features/map/data/datasource/location_local_datasource.dart';
import 'package:car_tracking_app/features/map/data/models/route_item_model.dart';
import 'package:injectable/injectable.dart';
import 'package:car_tracking_app/core/model/result.dart';

@LazySingleton(as: LocationDatasource)
class LocationDatasourceImpl extends LocationDatasource {
  final LocationLocalDataSource _locationDataSource;

  LocationDatasourceImpl(this._locationDataSource);

  @override
  Future<Result<List<RouteItemModel>>> getRoutesByKey(
      {required String key}) async {
    return await _locationDataSource
        .getRoutesByKey(key: key)
        .then((value) async {
      return Result(data: value.data);
    }).catchError((error, stackTrack) {
      throw error;
    });
  }

  @override
  Future<Result> setLocalRoutesByKey(
      {required List<RouteItemModel> routes, required String key}) async {
    return await _locationDataSource.setLocalRoutesByKey(
        key: key, routes: routes);
  }

  @override
  Future<bool> routeExists({required String key}) {
    return _locationDataSource.routeExists(key: key);
  }
}
