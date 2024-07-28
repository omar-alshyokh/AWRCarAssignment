
import 'package:car_tracking_app/core/managers/analytics/constants/analytics_enums.dart';
import 'package:car_tracking_app/core/managers/analytics/service/firebase_analytics_service.dart';
import 'package:car_tracking_app/core/managers/analytics/service/mixpanel_analytics_service.dart';
import 'package:car_tracking_app/core/model/base_model.dart';
import 'package:injectable/injectable.dart';

import 'analytics_central.dart';

@LazySingleton(as: AnalyticsCentral)
class AnalyticsCentralImpl with AnalyticsCentral {
  final FirebaseAnalyticsService firebase;
  final MixPanelAnalyticsService mixPanel;
  // final AmplifyAnalyticsService amplifyAnalytics;


  AnalyticsCentralImpl(
      this.firebase,
      this.mixPanel,
      // this.amplifyAnalytics
      );

  @override
  Future buttonViewTracker<T extends BaseModel>(
      {required ButtonAnalyticIdentity event,
      Map<String, dynamic>? parameters}) async {
    // await firebase.buttonViewTracker(event: event, parameters: parameters);
    // await mixPanel.buttonViewTracker(event: event, parameters: parameters);
    // await amplifyAnalytics.buttonViewTracker(
    //     event: event, parameters: parameters);
  }


  @override
  Future registerSuperProperties<T extends BaseModel>(
      {Map<String, dynamic>? properties}) async {
    // await mixPanel.registerSuperProperties(properties: properties);
    // await firebase.registerSuperProperties(properties: properties);
    // await amplifyAnalytics.registerSuperProperties(properties: properties);
  }

  @override
  Future setUser<T extends BaseModel>({required String id}) async {
    // await mixPanel.setUser(id: id);
    // await firebase.setUser(id: id);
    // await amplifyAnalytics.setUser(id: id);
  }
}