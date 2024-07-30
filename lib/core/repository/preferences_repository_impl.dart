import 'dart:async';

import 'package:car_tracking_app/core/helper/shared_preference_helper.dart';
import 'package:injectable/injectable.dart';

import 'preferences_repository.dart';

@Singleton(as: PreferencesRepository)
class PreferencesRepositoryImpl extends PreferencesRepository {
  final SharedPreferenceHelper _sharedPrefsHelper;

  PreferencesRepositoryImpl(
    this._sharedPrefsHelper,
  );

  @override
  Future<void> changeLanguage(String value) =>
      _sharedPrefsHelper.changeLanguage(value);

  @override
  String? get currentLanguage => _sharedPrefsHelper.currentLanguage;
}
