// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_polyline_points/flutter_polyline_points.dart' as _i574;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart'
    as _i161;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../features/car/data/datasource/car_datasource.dart' as _i90;
import '../../features/car/data/datasource/car_datasource_impl.dart' as _i192;
import '../../features/car/data/datasource/car_firebase_datasource.dart'
    as _i991;
import '../../features/car/domain/repository/car_repository_impl.dart' as _i960;
import '../../features/car/presentation/bloc/car_bloc.dart' as _i183;
import '../../features/home/data/datasources/post_datasource.dart' as _i405;
import '../../features/home/data/datasources/post_datasource_impl.dart'
    as _i954;
import '../../features/home/data/datasources/post_local_datasource.dart'
    as _i1003;
import '../../features/home/data/datasources/post_remote_datasource.dart'
    as _i873;
import '../../features/home/domain/repository/post_repository_impl.dart'
    as _i897;
import '../../features/map/data/datasource/location_datasource.dart' as _i367;
import '../../features/map/data/datasource/location_datasource_impl.dart'
    as _i521;
import '../../features/map/data/datasource/location_local_datasource.dart'
    as _i543;
import '../../features/map/domin/repository/location_simulation_repo.dart'
    as _i265;
import '../../features/map/presentation/bloc/tracking_location/car_tracking_bloc.dart'
    as _i505;
import '../../features/vendor/domain/repository/vendor_repository_impl.dart'
    as _i787;
import '../../features/vendor/presentation/bloc/vendor_details/vendor_car_details_bloc.dart'
    as _i480;
import '../../features/vendor/presentation/bloc/vendor_home/vendor_car_list_bloc.dart'
    as _i447;
import '../helper/shared_preference_helper.dart' as _i460;
import '../managers/analytics/central/analytics_central.dart' as _i8;
import '../managers/analytics/central/analytics_central_impl.dart' as _i706;
import '../managers/analytics/constants/analytics_params_builder.dart'
    as _i1000;
import '../managers/analytics/service/firebase_analytics_service.dart' as _i798;
import '../managers/analytics/service/mixpanel_analytics_service.dart'
    as _i1049;
import '../managers/graphql/graphql_client_agent.dart' as _i500;
import '../managers/localdb/hive_service.dart' as _i874;
import '../managers/localdb/route_box_handler.dart' as _i104;
import '../managers/localization/app_language.dart' as _i67;
import '../managers/navigation/app_navigation_service.dart' as _i486;
import '../managers/network/connection_checker.dart' as _i1020;
import '../managers/network/dio_client.dart' as _i455;
import '../repository/preferences_repository.dart' as _i583;
import '../repository/preferences_repository_impl.dart' as _i422;
import 'module/local_module.dart' as _i130;
import 'module/network_module.dart' as _i881;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i174.GetIt> init(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final localModule = _$LocalModule();
  final networkModule = _$NetworkModule();
  await gh.factoryAsync<_i460.SharedPreferences>(
    () => localModule.prefs(),
    preResolve: true,
  );
  await gh.factoryAsync<_i161.InternetConnection>(
    () => localModule.checker(),
    preResolve: true,
  );
  await gh.factoryAsync<_i574.PolylinePoints>(
    () => localModule.polyLinePoints(),
    preResolve: true,
  );
  gh.factory<_i874.HiveService>(() => _i874.HiveService());
  gh.factory<_i500.GraphQlClientAgent>(() => _i500.GraphQlClientAgent());
  gh.factory<_i67.AppLanguage>(() => _i67.AppLanguage());
  gh.singleton<_i104.RouteBoxHandler>(() => _i104.RouteBoxHandler());
  gh.singleton<_i1000.AnalyticsParamsBuilder>(
      () => _i1000.AnalyticsParamsBuilder());
  gh.singleton<_i991.CarFirebaseDatasource>(
      () => _i991.CarFirebaseDatasource());
  gh.lazySingleton<_i361.Dio>(() => networkModule.dio);
  gh.lazySingleton<_i486.AppNavigationService>(
      () => _i486.AppNavigationService());
  gh.lazySingleton<_i798.FirebaseAnalyticsService>(
      () => _i798.FirebaseAnalyticsService());
  gh.lazySingleton<_i1049.MixPanelAnalyticsService>(
      () => _i1049.MixPanelAnalyticsService());
  gh.lazySingleton<_i1003.PostLocalDataSource>(
      () => _i1003.PostLocalDataSource());
  gh.lazySingleton<_i8.AnalyticsCentral>(() => _i706.AnalyticsCentralImpl(
        gh<_i798.FirebaseAnalyticsService>(),
        gh<_i1049.MixPanelAnalyticsService>(),
      ));
  gh.singleton<_i455.DioClient>(() => _i455.DioClient(gh<_i361.Dio>()));
  gh.lazySingleton<_i460.SharedPreferenceHelper>(
      () => _i460.SharedPreferenceHelper(gh<_i460.SharedPreferences>()));
  gh.singleton<_i1020.ConnectionChecker>(
      () => _i1020.ConnectionCheckerImpl(gh<_i161.InternetConnection>()));
  gh.lazySingleton<_i543.LocationLocalDataSource>(
      () => _i543.LocationLocalDataSource(gh<_i104.RouteBoxHandler>()));
  gh.lazySingleton<_i90.CarDatasource>(
      () => _i192.CarDatasourceImpl(gh<_i991.CarFirebaseDatasource>()));
  gh.lazySingleton<_i873.PostRemoteDataSource>(
      () => _i873.PostRemoteDataSource(gh<_i455.DioClient>()));
  gh.singleton<_i583.PreferencesRepository>(() =>
      _i422.PreferencesRepositoryImpl(gh<_i460.SharedPreferenceHelper>()));
  gh.lazySingleton<_i367.LocationDatasource>(
      () => _i521.LocationDatasourceImpl(gh<_i543.LocationLocalDataSource>()));
  gh.lazySingleton<_i405.PostDatasource>(() => _i954.PostDatasourceImpl(
        gh<_i1003.PostLocalDataSource>(),
        gh<_i873.PostRemoteDataSource>(),
      ));
  gh.lazySingleton<_i897.PostRepositoryImpl>(
      () => _i897.PostRepositoryImpl(gh<_i405.PostDatasource>()));
  gh.lazySingleton<_i960.CarRepositoryImpl>(
      () => _i960.CarRepositoryImpl(gh<_i90.CarDatasource>()));
  gh.lazySingleton<_i265.LocationSimulationRepo>(
      () => _i265.LocationSimulationRepo(
            gh<_i367.LocationDatasource>(),
            gh<_i574.PolylinePoints>(),
          ));
  gh.lazySingleton<_i787.VendorRepositoryImpl>(
      () => _i787.VendorRepositoryImpl(gh<_i90.CarDatasource>()));
  gh.factory<_i480.VendorCarDetailsBloc>(() => _i480.VendorCarDetailsBloc(
        gh<_i787.VendorRepositoryImpl>(),
        gh<_i460.SharedPreferenceHelper>(),
      ));
  gh.factory<_i447.VendorCarListBloc>(
      () => _i447.VendorCarListBloc(gh<_i787.VendorRepositoryImpl>()));
  gh.factory<_i183.CarBloc>(() => _i183.CarBloc(gh<_i960.CarRepositoryImpl>()));
  gh.factory<_i505.CarLiveTrackingBloc>(
      () => _i505.CarLiveTrackingBloc(gh<_i265.LocationSimulationRepo>()));
  return getIt;
}

class _$LocalModule extends _i130.LocalModule {}

class _$NetworkModule extends _i881.NetworkModule {}
