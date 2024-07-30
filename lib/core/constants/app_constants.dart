import 'package:car_tracking_app/core/constants/app_assets.dart';
import 'package:car_tracking_app/core/model/app_language_metadata_model.dart';
import 'package:car_tracking_app/core/widgets/common/app_map_widget.dart';
import 'package:car_tracking_app/features/car/data/models/brand_model.dart';
import 'package:car_tracking_app/features/car/data/models/car_type_model.dart';

class AppConstants {
  AppConstants._();

  /// add any fixed string here
  static const String appName = "AWRCarTracking";

  /// locals
  static const String langEN = "en";
  static const String langAR = "ar";

  /// hive table and boxes keys
  static const String notificationStorageKey = "notificationStorageKey";
  static const String locationStorageKey = "locationStorageKey";
  static const String bluetoothStorageKey = "bluetoothStorageKey";

  static const String routesHiveBox = "routesHiveBox";
  static const String defaultRouteHiveTable = "defaultRouteHiveTable";

  /// preferences keys
  static const String prefLanguageCode = "pref_language_code";
  static const String prefVendorFullName = "pref_vendor_full_name";
  static const String prefVendorContactNumber = "pref_vendor_contact_number";

  /// general keys

  static const List<BrandModel> mockBrandList = [
    BrandModel(name: "Nissan", id: 1)
  ];

  static const List<CarTypeModel> mockCarByBrandList = [
    CarTypeModel(
        id: 1, name: "Nissan Patrol", brandId: 1, image: AppAssets.patrolPng),
    CarTypeModel(
        id: 2, name: "Nissan Altima", brandId: 1, image: AppAssets.altimaPng),
    CarTypeModel(
        id: 3, name: "Nissan Kicks", brandId: 1, image: AppAssets.kicksPng),
    CarTypeModel(
        id: 4,
        name: "Nissan PathFinder",
        brandId: 1,
        image: AppAssets.pathfinderPng),
    CarTypeModel(
        id: 5, name: "Nissan Sunny", brandId: 1, image: AppAssets.sunnyPng),
    CarTypeModel(
        id: 6, name: "Nissan X-Trail", brandId: 1, image: AppAssets.xTrailPng),
  ];

  static double initialCameraZoom = 14;

  static AppLatLng initialMapLocation = const AppLatLng(25.2048, 55.2708);

  static final listOfLanguages = [
    const AppLanguageMetaData("English", "en", "🇺🇸"),
    const AppLanguageMetaData("العربية", "ar", "🇸🇦"),
  ];
}
