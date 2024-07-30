class AppLanguageMetaData {
  final String flag;
  final String label;
  final String code;

  const AppLanguageMetaData(
      this.label,
      this.code,
      this.flag,
      );

  @override
  int get hashCode => flag.hashCode ^ label.hashCode ^ code.hashCode;

  @override
  bool operator ==(Object other) {
    return other is AppLanguageMetaData &&
        other.flag == flag &&
        other.label == label &&
        other.code == code;
  }
}