import 'package:car_tracking_app/core/managers/localization/app_language.dart';
import 'package:car_tracking_app/core/managers/localization/generated/l10n.dart';
import 'package:car_tracking_app/core/managers/navigation/app_navigation_service.dart';
import 'package:car_tracking_app/core/managers/navigation/app_routes.dart';
import 'package:car_tracking_app/core/widgets/error/custom_crash_error_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:car_tracking_app/core/constants/app_colors.dart';
import 'package:car_tracking_app/core/constants/app_constants.dart';
import 'package:car_tracking_app/core/di/di.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appLanguageManager = findDep<AppLanguage>();

  @override
  void initState() {
    super.initState();
    _appLanguageManager.fetchLocale();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => _appLanguageManager),
      ],
      child: ChangeNotifierProvider<AppLanguage?>(
        create: (_) => _appLanguageManager,
        child: Consumer<AppLanguage>(builder: (context, model, child) {
          return MaterialApp(
            locale: model.appLocal,
            supportedLocales: Translations.delegate.supportedLocales,
            localizationsDelegates: const [
              // A class which loads the translations from JSON files
              Translations.delegate,
              // Built-in localization of basic text for Material widgets
              GlobalMaterialLocalizations.delegate,
              // Built-in localization for text direction LTR/RTL
              GlobalWidgetsLocalizations.delegate,
              // Built-in localization of basic text for Cupertino widgets
              GlobalCupertinoLocalizations.delegate,
            ],
            debugShowCheckedModeBanner: false,
            navigatorKey: findDep<AppNavigationService>().navigatorKey,
            title: AppConstants.appName,
            initialRoute: AppRoutes.splash,
            theme: ThemeData(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                primaryColor: AppColors.primaryOrangeColor,
                useMaterial3: false,
                scaffoldBackgroundColor: AppColors.lightGray,
                appBarTheme: const AppBarTheme(
                  elevation: 0.0,
                  iconTheme: IconThemeData(
                    color:
                        AppColors.primaryOrangeColor, //change your color here
                  ),
                ),
                pageTransitionsTheme: const PageTransitionsTheme(builders: {
                  TargetPlatform.android: CupertinoPageTransitionsBuilder(),
                  TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                })),
            onGenerateRoute: AppRoutes.generateRoute,
            builder: (context, child) {
              if (!kDebugMode) {
                ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
                  return CustomCrashErrorPage(errorDetails: errorDetails);
                };
              }
              return child!;
            },
          );
        }),
      ),
    );
  }
}
