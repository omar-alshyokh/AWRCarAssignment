

import 'package:car_tracking_app/core/di/di.dart';
import 'package:car_tracking_app/core/managers/analytics/constants/analytics_enums.dart';
import 'package:car_tracking_app/core/managers/analytics/constants/analytics_params_builder.dart';

import 'analytics_central.dart';

mixin AnalyticsMixin {
  final AnalyticsCentral _analyticsCentral = findDep<AnalyticsCentral>();
  final AnalyticsParamsBuilder _paramsBuilder =
      findDep<AnalyticsParamsBuilder>();

  AnalyticsParamsBuilder get analyticsParam => _paramsBuilder;
  AnalyticsCentral get analyticsCentral => _analyticsCentral;

  Future eventTracker(
      {required ButtonAnalyticIdentity event,
      Map<String, dynamic>? parameters}) async {
    _analyticsCentral.buttonViewTracker(event: event, parameters: parameters);
  }


  Future setUserAnalytics({required String id}) async {
    _analyticsCentral.setUser(id: id);
  }

  Future registerSuperPropertiesAnalytics(
      {Map<String, dynamic>? properties}) async {
    _analyticsCentral.registerSuperProperties(properties: properties);
  }


  Future openPage(
      {required String page,
      Map<String, dynamic>? parameters}) async {
    eventTracker(
        event: ButtonAnalyticIdentity.open,
        parameters:
            analyticsParam.openCloseButtonParam(page: page, params: parameters));
  }

  Future closePage(
      {required String page,
      Map<String, dynamic>? parameters}) async {
    eventTracker(
        event: ButtonAnalyticIdentity.close,
        parameters:
            analyticsParam.openCloseButtonParam(page: page, params: parameters));
  }
}
