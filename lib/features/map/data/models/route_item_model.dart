import 'package:car_tracking_app/core/managers/localdb/hive_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';

part 'route_item_model.g.dart';

@HiveType(typeId: HiveAdapterTypeIds.routesAdapterId)
class RouteItemModel {
  @HiveField(0)
  final double latitude;
  @HiveField(1)
  final double longitude;

  RouteItemModel({required this.latitude, required this.longitude});

  @override
  String toString() {
    return 'RouteItemModel{latitude: $latitude, longitude: $longitude}';
  }

  LatLng toLatLng() {
    return LatLng(latitude, longitude);
  }

  factory RouteItemModel.fromLatLng({required LatLng latlng}) {
    return RouteItemModel(
        latitude: latlng.latitude, longitude: latlng.longitude);
  }
}
