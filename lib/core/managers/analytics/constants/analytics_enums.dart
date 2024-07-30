import 'analytics_constants.dart';

enum ButtonAnalyticIdentity {
  close(ButtonAnalyticsKeyValues.closeBtn),
  open(ButtonAnalyticsKeyValues.openBtn),

  /// launch url outside the app events
  launch(ButtonAnalyticsKeyValues.launchBtn),
  userLocation(ButtonAnalyticsKeyValues.userLocationBtn),
  crash(ButtonAnalyticsKeyValues.crashBtn),
  startTrip(ButtonAnalyticsKeyValues.startTripBtn),
  endTrip(ButtonAnalyticsKeyValues.endTripBtn),
  showLiveLocation(ButtonAnalyticsKeyValues.showLiveLocationBtn),
  addCar(ButtonAnalyticsKeyValues.addCarBtn),
  adminSignIn(ButtonAnalyticsKeyValues.adminSignInBtn),
  vendorSignUp(ButtonAnalyticsKeyValues.vendorSignUpBtn),
  continueAsAdmin(ButtonAnalyticsKeyValues.continueAsAdminBtn),
  continueAsVendor(ButtonAnalyticsKeyValues.continueAsVendorBtn),
  carListFilter(ButtonAnalyticsKeyValues.carListFilterBtn),
  ;

  // can add more properties or getters/methods if needed
  final int value;

  // can use named parameters if you want
  const ButtonAnalyticIdentity(this.value);

  @override
  String toString() => "The button analytics event: $name value is $value";
}

enum AnalyticCatchIssueType {
  loadAssets,
  dioRequest,
}

enum AnalyticFailedLoadAssetType {
  userImagePic,
  carImagePic,
}
