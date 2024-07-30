import 'package:car_tracking_app/core/constants/app_constants.dart';
import 'package:car_tracking_app/core/managers/localdb/box_handler.dart';
import 'package:car_tracking_app/core/service/logger_service.dart';
import 'package:car_tracking_app/features/map/data/models/route_item_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';


@Singleton()
class RouteBoxHandler extends ListBoxHandler<RouteItemModel> {
  @override
  String get defaultKey => AppConstants.defaultRouteHiveTable;

  @override
  Future<Box> get box async =>
      await Hive.openBox(AppConstants.routesHiveBox);

  @override
  Future<List<RouteItemModel>> get({String? key}) async {
    final openBox = await box;
    final List dynamicList = openBox.get(key ?? defaultKey, defaultValue: []);
    final casted = List<RouteItemModel>.from(dynamicList);
    return casted;
  }

  @override
  Future<void> put(List<RouteItemModel> value, {String? key}) async {
    final openBox = await box;
    openBox.put(key ?? defaultKey, value);
    super.put(value, key: key);
  }

  Future<bool> routeExists(String key) async{
    try{
      final openBox = await box;
      return openBox.containsKey(key);
    }catch(e,s){
      LoggerService().logError(e.toString(), e, s);

      return false;
    }
  }
}
