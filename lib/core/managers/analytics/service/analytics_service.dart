

import 'package:car_tracking_app/core/managers/analytics/constants/analytics_enums.dart';
import 'package:car_tracking_app/core/model/base_model.dart';

mixin AnalyticsService {
  Future buttonViewTracker<T extends BaseModel>({required ButtonAnalyticIdentity event, Map<String, dynamic>? parameters});
  Future setUser<T extends BaseModel>({required String id});
  Future registerSuperProperties<T extends BaseModel>({Map<String, dynamic>? properties});
}