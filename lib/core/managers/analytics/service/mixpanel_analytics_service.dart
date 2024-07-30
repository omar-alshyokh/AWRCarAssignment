import 'package:car_tracking_app/core/constants/app_constants.dart';
import 'package:car_tracking_app/core/managers/analytics/constants/analytics_enums.dart';
import 'package:car_tracking_app/core/model/base_model.dart';
import 'package:car_tracking_app/core/utils/app_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';

import 'analytics_service.dart';

@LazySingleton()
@Injectable()
class MixPanelAnalyticsService implements AnalyticsService {
  late Mixpanel _mixpanel;

  Future<void> initMixpanel() async {
    String devToken = dotenv.env['mixPanel_dev_token'] ?? "";
    String prodToken = "";
    _mixpanel = await Mixpanel.init(kDebugMode ? devToken : prodToken,
        optOutTrackingDefault: false, trackAutomaticEvents: true);
  }

  @override
  Future buttonViewTracker<T extends BaseModel>(
      {required ButtonAnalyticIdentity event,
      Map<String, dynamic>? parameters}) async {
    Map<String, dynamic> param = {};
    if (parameters != null) {
      param.addAll(parameters);
    }
    _mixpanel.track(event.name, properties: param);

    AppUtils.mockPrintAnalytics(
        eventName: "Mixpanel_${event.name}", parameters: param);
  }

  @override
  Future registerSuperProperties<T extends BaseModel>(
      {Map<String, dynamic>? properties}) async {
    if (properties != null) {
      _mixpanel.clearSuperProperties();
      _mixpanel.registerSuperProperties(properties);
      AppUtils.mockPrintAnalytics(
          eventName: "Mixpanel_registerSuperProperties",
          parameters: properties);
    }
  }

  @override
  Future setUser<T extends BaseModel>({required String id}) async {
    _mixpanel.identify(id);

    AppUtils.mockPrintAnalytics(
        eventName: "Mixpanel_setUser", parameters: {"id": id});
  }
}
