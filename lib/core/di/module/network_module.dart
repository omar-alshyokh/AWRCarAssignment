import 'package:car_tracking_app/core/managers/navigation/app_navigation_service.dart';
import 'package:car_tracking_app/core/managers/navigation/app_routes.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:car_tracking_app/core/di/di.dart';
import 'package:car_tracking_app/core/utils/app_utils.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../constants/constants.dart';

@module
abstract class NetworkModule {
  /// A singleton dio provider.
  ///
  /// Calling it multiple times will return the same instance.
  @lazySingleton
  Dio get dio {
    final dio = Dio();
    dio
      ..options.baseUrl = Endpoints.baseUrl.value
      ..options.connectTimeout = EndpointsConfig.connectionTimeout
      ..options.receiveTimeout = EndpointsConfig.receiveTimeout
      ..options.headers = EndpointsConfig.defaultHeaderValues
      ..interceptors.add(AuthInterceptor())
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (RequestOptions options,
              RequestInterceptorHandler handler) async {
            return handler.next(options);
          },
        ),
      )

      /// pretty logging for our http request and response
      ..interceptors.add(PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: false,
          responseHeader: false,
          error: true,
          logPrint: (o) => debugPrint(o.toString()),
          compact: true,
          maxWidth: 250));

    return dio;
  }
}

class AuthInterceptor extends Interceptor {

  bool isInvalidSession = false;

  // helper class to access your local storage

  AuthInterceptor();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    isInvalidSession = false;
    return handler.next(options);
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    appPrint('onError in AuthInterceptor $err');
    appPrint('onError in AuthInterceptor isInvalidSession $isInvalidSession');
    if (err.response?.statusCode == 401 ||
        err.response?.statusCode == 402 ||
        err.response?.statusCode == 403) {
      const loginRoute = AppRoutes.adminLoginPage;
      bool isNewRouteSameAsCurrent = false;
      Navigator.popUntil(
          findDep<AppNavigationService>().navigatorKey.currentContext!,
          (route) {
        if (route.settings.name == loginRoute) {
          isNewRouteSameAsCurrent = true;
        }
        return true;
      });
      if (!isNewRouteSameAsCurrent) {
        Navigator.pushNamed(
          findDep<AppNavigationService>().navigatorKey.currentContext!,
          AppRoutes.adminLoginPage,
        );
        isInvalidSession = true;
      }
    }
    handler.next(err);

    return;
  }
}
