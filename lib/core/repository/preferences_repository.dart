abstract class PreferencesRepository {
  Future<void> changeLanguage(String value);

  String? get currentLanguage;
}
