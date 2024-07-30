import 'package:car_tracking_app/core/constants/app_constants.dart';
import 'package:car_tracking_app/core/di/di.dart';
import 'package:car_tracking_app/core/helper/shared_preference_helper.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class AppLanguage extends ChangeNotifier {
  Locale _appLocale = const Locale(AppConstants.langEN);
  String _langCode = AppConstants.langEN;

  Locale get appLocal => _appLocale;

  String get langCode => _langCode;

  String getLangLabel() {
    final language = AppConstants.listOfLanguages
        .firstWhere((element) => element.code == _langCode);

    return language.label;
  }

  fetchLocale() async {
    SharedPreferenceHelper prefs = findDep<SharedPreferenceHelper>();

    /// todo: uncomment these line when you want to change language working
    // if (prefs.getString(AppStrings.prefLanguageCode) == null) {
    //   String deviceLang = await getDeviceLang();
    //   if (deviceLang == AppStrings.LANG_AR) {
    //     _appLocale = const Locale(AppStrings.LANG_AR);
    //     _langCode = AppStrings.LANG_AR;
    //   } else {
    //     _appLocale = const Locale(AppStrings.LANG_EN);
    //     _langCode = AppStrings.LANG_EN;
    //   }
    //
    //   return Null;
    // }
    _appLocale = Locale(
        prefs.getString(AppConstants.prefLanguageCode) ?? AppConstants.langEN);
    _langCode =
        prefs.getString(AppConstants.prefLanguageCode) ?? AppConstants.langEN;
    return Null;
  }

  void changeLanguage(Locale type) async {
    SharedPreferenceHelper prefs = findDep<SharedPreferenceHelper>();

    if (_appLocale == type) {
      return;
    }
    if (type == const Locale(AppConstants.langAR)) {
      _appLocale = const Locale(AppConstants.langAR);
      _langCode = AppConstants.langAR;
      await prefs.saveString(
          AppConstants.prefLanguageCode, AppConstants.langAR);
    } else {
      _appLocale = const Locale(AppConstants.langEN);
      _langCode = AppConstants.langEN;
      await prefs.saveString(
          AppConstants.prefLanguageCode, AppConstants.langEN);
    }
    if (!_disposed) {
      notifyListeners();
    }
  }

  bool _disposed = false;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  /// get default device language
// Future<String> getDeviceLang() async {
//   String? locale = await Devicelocale.currentLocale;
//   String str;
//   if (locale.toString().contains("_")) {
//     str = locale.toString().substring(0, locale.toString().indexOf('_'));
//   } else if (locale.toString().contains("-")) {
//     str = locale.toString().substring(0, locale.toString().indexOf('-'));
//   } else {
//     str = locale.toString();
//   }
//   return str;
// }
}
