import 'analytics_constants.dart';



enum ButtonAnalyticIdentity {

  close(ButtonAnalyticsKeyValues.closeBtn),
  open(ButtonAnalyticsKeyValues.openBtn),

  /// launch url outside the app events
  launch(ButtonAnalyticsKeyValues.launchBtn),


  userLocation(ButtonAnalyticsKeyValues.userLocationBtn),

  crash(ButtonAnalyticsKeyValues.crashBtn),

;


  // can add more properties or getters/methods if needed
  final int value;

  // can use named parameters if you want
  const ButtonAnalyticIdentity(this.value);

  @override
  String toString() => "The button analytics event: $name value is $value";
}



enum AnalyticCatchIssueType{
  loadAssets,
  dioRequest,
}

enum AnalyticFailedLoadAssetType{
  userImagePic,
  carImagePic,
}