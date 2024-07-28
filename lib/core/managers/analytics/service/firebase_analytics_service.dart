import 'package:car_tracking_app/core/entity/base_entity.dart';
import 'package:car_tracking_app/core/managers/analytics/constants/analytics_constants.dart';
import 'package:car_tracking_app/core/managers/analytics/constants/analytics_enums.dart';
import 'package:car_tracking_app/core/managers/analytics/service/analytics_service.dart';
import 'package:car_tracking_app/core/model/base_model.dart';
import 'package:car_tracking_app/core/service/logger_service.dart';
import 'package:car_tracking_app/core/utils/app_utils.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
@Injectable()
class FirebaseAnalyticsService implements AnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  FirebaseAnalytics get analyticsInstance => _analytics;

  FirebaseAnalyticsObserver getAnalyticsObserver() =>
      FirebaseAnalyticsObserver(analytics: _analytics);

  @override
  Future registerSuperProperties<T extends BaseModel<BaseEntity>>(
      {Map<String, dynamic>? properties}) {
    // TODO: implement registerSuperProperties
    throw UnimplementedError();
  }

  @override
  Future setUser<T extends BaseModel<BaseEntity>>({required String id}) {
    // TODO: implement setUser
    throw UnimplementedError();
  }

  @override
  Future buttonViewTracker<T extends BaseModel<BaseEntity>>(
      {required ButtonAnalyticIdentity event,
      Map<String, dynamic>? parameters}) async {
    try {
      await _analytics.logEvent(
          name: event.name, parameters: parameters?.cast<String, Object>());
      AppUtils.mockPrintAnalytics(
          eventName: "${AnalyticsConstants.events.button}_${event.name}",
          parameters: parameters);
    } catch (e) {
      LoggerService().logError(e.toString());
    }
  }
}
