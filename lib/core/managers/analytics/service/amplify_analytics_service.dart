// import 'package:car_tracking_app/core/managers/analytics/constants/analytics_constants.dart';
// import 'package:car_tracking_app/core/managers/analytics/constants/analytics_enums.dart';
// import 'package:car_tracking_app/core/model/base_model.dart';
// import 'package:car_tracking_app/core/service/logger_service.dart';
// import 'package:car_tracking_app/core/utils/app_utils.dart';
// import 'package:injectable/injectable.dart';
// import 'package:amplify_flutter/amplify_flutter.dart';
// import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
// import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
//
// import 'package:car_tracking_app/amplifyconfiguration.dart';
// import 'analytics_service.dart';
//
// @LazySingleton()
// @Injectable()
// class AmplifyAnalyticsService implements IAnalyticsService {
//   Future<void> configureAmplify() async {
//     // Add any Amplify plugins you want to use
//
//     final storageFactory = AmplifySecureStorage.factoryFrom(
//       // ignore: invalid_use_of_visible_for_testing_member
//       macOSOptions: MacOSSecureStorageOptions(useDataProtection: false),
//     );
//
//     await Amplify.addPlugins([
//       AmplifyAuthCognito(
//         secureStorageFactory: storageFactory,
//       ),
//       AmplifyAnalyticsPinpoint(
//         // ignore: invalid_use_of_visible_for_testing_member
//         secureStorageFactory: storageFactory,
//         options: const AnalyticsPinpointPluginOptions(
//           autoFlushEventsInterval: Duration(seconds: 60),
//         ),
//       ),
//     ]);
//
//     // final analyticsPlugin = AmplifyAnalyticsPinpoint();
//     // final authPlugin = AmplifyAuthCognito();
//     // await Amplify.addPlugins([analyticsPlugin, authPlugin]);
//
//     // Once Plugins are added, configure Amplify
//     // Note: Amplify can only be configured once.
//     try {
//       await Amplify.configure(amplifyconfig);
//     } on AnalyticsException catch (e) {
//       safePrint(e.toString());
//       LoggerService().logDebug(e.toString());
//     }
//   }
//
//   @override
//   Future buttonViewTracker<T extends BaseModel>(
//       {required ButtonAnalyticIdentity event,
//       Map<String, dynamic>? parameters}) async {
//     final analyticsEvent =
//         _compileEventProps(eventName: event.name, parameters: parameters);
//
//     await Amplify.Analytics.recordEvent(event: analyticsEvent);
//
//     AppUtils.mockPrintAnalytics(
//         eventName: "Amplify_${event.name}", parameters: parameters);
//   }
//
//   @override
//   Future registerSuperProperties<T extends BaseModel>(
//       {Map<String, dynamic>? properties}) async {
//     if (properties != null) {
//       final customProps = _compileCustomProperties(parameters: properties);
//
//       await Amplify.Analytics.unregisterGlobalProperties();
//
//       await Amplify.Analytics.registerGlobalProperties(
//         globalProperties: customProps,
//       );
//       AppUtils.mockPrintAnalytics(
//           eventName: "Amplify_registerSuperProperties", parameters: properties);
//     }
//   }
//
//   @override
//   Future setUser<T extends BaseModel>({required String id}) async {
//     await Amplify.Analytics.identifyUser(
//       userId: id,
//     );
//
//     AppUtils.mockPrintAnalytics(
//         eventName: "Amplify_setUser", parameters: {"id": id});
//   }
//
//   AnalyticsEvent _compileEventProps(
//       {required String eventName, Map<String, dynamic>? parameters}) {
//     final analyticsEvent = AnalyticsEvent(eventName);
//     parameters?.forEach((key, value) {
//       if (value != null) {
//         if (value is int) {
//           analyticsEvent.customProperties.addIntProperty(key, value);
//         } else if (value is String) {
//           analyticsEvent.customProperties.addStringProperty(key, value);
//         } else if (value is bool) {
//           analyticsEvent.customProperties.addBoolProperty(key, value);
//         } else if (value is double) {
//           analyticsEvent.customProperties.addDoubleProperty(key, value);
//         } else if (value is DateTime) {
//           analyticsEvent.customProperties
//               .addStringProperty(key, value.toString());
//         }else if (value is Uri) {
//           analyticsEvent.customProperties
//               .addStringProperty(key, value.toString());
//         } else {
//           LoggerService().logDebug(
//             "Amplify Error analytics _compileEventProps key:$key -> type not supported ${value.runtimeType} with value: $value",
//           );
//         }
//       } else {
//         LoggerService().logDebug(
//           "Amplify Error analytics _compileEventProps key:$key -> type not supported ${value.runtimeType} with value: $value",
//         );
//       }
//     });
//
//     return analyticsEvent;
//   }
//
//   CustomProperties _compileCustomProperties(
//       {required Map<String, dynamic> parameters}) {
//     final customProperties = CustomProperties();
//     parameters.forEach((key, value) {
//       if (value != null) {
//         if (value is int) {
//           customProperties.addIntProperty(key, value);
//         } else if (value is String) {
//           customProperties.addStringProperty(key, value);
//         } else if (value is bool) {
//           customProperties.addBoolProperty(key, value);
//         } else if (value is double) {
//           customProperties.addDoubleProperty(key, value);
//         } else if (value is DateTime) {
//           customProperties.addStringProperty(key, value.toString());
//         }else if (value is Uri) {
//           customProperties.addStringProperty(key, value.toString());
//         } else {
//           LoggerService().logDebug(
//             "Amplify Error analytics _compileCustomProperties key:$key -> type not supported ${value.runtimeType} with value: $value",
//           );
//         }
//       } else {
//         LoggerService().logDebug(
//           "Amplify Error analytics _compileCustomProperties key:$key -> type not supported ${value.runtimeType} with value: $value",
//         );
//       }
//     });
//
//     return customProperties;
//   }
// }
