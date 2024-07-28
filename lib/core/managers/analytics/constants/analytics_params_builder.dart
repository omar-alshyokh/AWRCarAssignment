
import 'package:car_tracking_app/core/constants/app_extensions.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'analytics_constants.dart';
import 'analytics_enums.dart';

@Singleton()
class AnalyticsParamsBuilder {
  // Map<String, dynamic> userInfoDataParam({UserDetails? profile}) {
  //   Map<String, dynamic> param = {};
  //   if (profile != null) {
  //     param.putIfAbsent(AnalyticsConstants.userNameParam, () => profile.name);
  //     param.putIfAbsent(AnalyticsConstants.genderParam, () => profile.gender);
  //     param.putIfAbsent(
  //         AnalyticsConstants.dateOfBirthParam, () => profile.dateOfBirth);
  //   }
  //   return param;
  // }

  Map<String, dynamic> locationParamParam({Position? locationData}) {
    Map<String, dynamic> param = {};

    if (locationData != null) {

      param.putIfAbsent(
          AnalyticsConstants.latitudeParam, () => locationData.latitude);
      param.putIfAbsent(
          AnalyticsConstants.longitudeParam, () => locationData.longitude);
      param.putIfAbsent(
          AnalyticsConstants.accuracyParam, () => locationData.accuracy);
      param.putIfAbsent(
          AnalyticsConstants.altitudeParam, () => locationData.altitude);
      param.putIfAbsent(AnalyticsConstants.timeParam, () => locationData.timestamp);
    }
    return param;
  }

  Map<String, dynamic> generalParam({Map<String, dynamic>? params}) {
    Map<String, dynamic> data = {};

    if (params != null) {
      data.addAll(params);
    }
    return data;
  }

  Map<String, dynamic> failedLoadAssetParam(
      {AnalyticFailedLoadAssetType? type, Map<String, dynamic>? params}) {
    Map<String, dynamic> data = {};

    if (params != null) {
      data.addAll(params);
    }
    if (type != null) {
      data.putIfAbsent(AnalyticsConstants.typeParam, () => type.name);
    }

    return data;
  }


  Map<String, dynamic> openCloseButtonParam(
      {required String page, Map<String, dynamic>? params}) {
    Map<String, dynamic> param = {};
    if (params != null) {
      param.addAll(params);
    }
    param.putIfAbsent(AnalyticsConstants.pageNameParam, () => page);

    return param;
  }


  Map<String, dynamic> navigateToParam(
      {required String locationName, Map<String, dynamic>? params}) {
    Map<String, dynamic> param = {};

    if (params != null) {
      param.addAll(params);
    }
    param.putIfAbsent(
        AnalyticsConstants.locationNameParam, () => locationName);
    return param;
  }

  // Map<String, dynamic> notificationSettingsParam(
  //     {required String sectionName,
  //     // required AnalyticNotificationSettingsType type,
  //     required String optionTitle,
  //     required bool value}) {
  //   Map<String, dynamic> param = {};
  //   // param.putIfAbsent(AnalyticsConstants.typeParam, () => type.name);
  //   param.putIfAbsent(AnalyticsConstants.sectionNameParam, () => sectionName);
  //   param.putIfAbsent(AnalyticsConstants.optionTitleParam, () => optionTitle);
  //   param.putIfAbsent(AnalyticsConstants.valueParam, () => value);
  //   return param;
  // }





  Map<String, dynamic> widgetLifeSpanPeriod(
      {required int timeSpent, Map<String, dynamic>? params}) {
    Map<String, dynamic> param = {AnalyticsConstants.timeParam: timeSpent};

    if (params != null && params.isNotEmpty) {
      param.addAll(params);
    }
    return param;
  }

  Map<String, dynamic> catchIssueParams(
      {required AnalyticCatchIssueType type,
      dynamic error,
      String? url,
      String? method,
      String? errorType,
      int? statusCode,
      Map<String, dynamic>? queryParams}) {
    Map<String, dynamic> param = {};
    param.putIfAbsent(AnalyticsConstants.typeParam, () => type.name);
    param.putIfAbsent(
        AnalyticsConstants.errorMessageParam, () => error.toString());
    if (url.itHasValue) {
      param.putIfAbsent(AnalyticsConstants.urlParam, () => url.toString());
    }
    if (errorType.itHasValue) {
      param.putIfAbsent(
          AnalyticsConstants.errorTypeParam, () => errorType.toString());
    }
    if (statusCode != null) {
      param.putIfAbsent(AnalyticsConstants.statusCodeParam, () => statusCode);
    }
    if (method.itHasValue) {
      param.putIfAbsent(
          AnalyticsConstants.methodParam, () => method.toString());
    }
    if (queryParams != null && queryParams.isNotEmpty) {
      param.putIfAbsent(
          AnalyticsConstants.queryParam, () => queryParams.toString());
    }

    return param;
  }

  Map<String, dynamic> appCrashParams({
    String? exception,
    String? stack,
    String? summary,
    String? library,
  }) {
    Map<String, dynamic> param = {};
    if (exception.itHasValue) {
      param.putIfAbsent(
          AnalyticsConstants.crashExceptionParam, () => exception);
    }
    if (stack.itHasValue) {
      param.putIfAbsent(AnalyticsConstants.crashStackParam, () => stack);
    }

    if (summary.itHasValue) {
      param.putIfAbsent(AnalyticsConstants.crashSummaryParam, () => summary);
    }

    if (library.itHasValue) {
      param.putIfAbsent(AnalyticsConstants.crashLibraryParam, () => library);
    }

    return param;
  }

}
