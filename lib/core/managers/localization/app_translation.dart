
import 'package:car_tracking_app/core/di/di.dart';
import 'package:car_tracking_app/core/managers/localization/generated/l10n.dart';
import 'package:car_tracking_app/core/managers/navigation/app_navigation_service.dart';



Translations get translate =>Translations.of(
  findDep<AppNavigationService>().navigatorKey.currentContext!,
    );
// flutter packages pub run intl_translation:generate_from_arb  --no-use-deferred-loading
