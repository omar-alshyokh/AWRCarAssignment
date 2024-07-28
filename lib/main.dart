import 'package:car_tracking_app/core/constants/app_build_details.dart';
import 'package:car_tracking_app/core/managers/analytics/service/mixpanel_analytics_service.dart';
import 'package:car_tracking_app/core/managers/localization/app_language.dart';
import 'package:car_tracking_app/core/widgets/common/restart_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:car_tracking_app/core/di/di.dart';
import 'package:car_tracking_app/core/managers/localdb/hive_service.dart';
import 'package:car_tracking_app/features/app/presentation/pages/my_app.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await configureDependencies();


  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  // We're using HiveStore for persistence,
  // so we need to initialize Hive.
  await initHiveForFlutter();

  await findDep<MixPanelAnalyticsService>().initMixpanel();
  // await findDep<AmplifyAnalyticsService>().configureAmplify();
  await findDep<HiveService>().registerAdapters();

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  AppLanguage appLanguage = AppLanguage();
  await appLanguage.fetchLocale();
  runApp(RestartWidget(
    child: MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppLanguage()),

      ],
      child: MyApp(
        appLanguage: appLanguage,
      ),
    ),
  ));
}

