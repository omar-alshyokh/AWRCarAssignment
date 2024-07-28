class ButtonAnalyticsKeyValues {
  ButtonAnalyticsKeyValues._();
  static const int closeBtn = 1;

  static const int openBtn = 2;
  static const int launchBtn = 3;


  static const int userLocationBtn = 4;

  static const int crashBtn = 5;


}

class AnalyticsConstants {
  AnalyticsConstants._();

  static const Events events = Events();

  static const String pageNameParam = 'page';
  static const String idParam = 'id';
  static const String timeParam = 'eventTime';
  static const String targetParam = 'target';
  static const String statusParam = 'status';


  static const String nameParam = 'name';
  static const String genderParam = 'userGender';
  static const String dateOfBirthParam = 'userDOB';
  static const String locationNameParam = 'locationName';

  static const String valueParam = 'value';
  static const String bodyParam = 'body';
  static const String typeParam = 'type';

  static const String assetUrlParam = 'assetUrl';
  static const String urlParam = 'url';
  static const String queryParam = 'queryParams';
  static const String methodParam = 'method';
  static const String linkParam = 'link';
  static const String headerParam = 'header';
  static const String trackingIdParam = 'trackingId';
  static const String phoneNumberParam = 'phoneNumber';
  static const String countryCodeParam = 'countryCode';
  static const String countryCodeNameParam = 'countryCodeName';
  static const String countryDialParam = 'dialCode';
  static const String enquiryOptionParam = 'enquiryOption';
  static const String codeParam = 'code';
  static const String codeTypeParam = 'codeType';
  static const String channelParam = 'channel';
  static const String accountParam = 'account';

  static const String errorMessageParam = 'errorMessage';
  static const String errorTypeParam = 'errorType';
  static const String statusCodeParam = 'statusCode';
  static const String crashExceptionParam = 'exception';
  static const String crashStackParam = 'stack';
  static const String crashSummaryParam = 'summary';
  static const String crashLibraryParam = 'library';

  static const String titleParam = 'title';
  static const String locationIdParam = 'locationId';

  static const String openFromParam = 'openFrom';
  static const String platformParam = 'platform';

  static const String latitudeParam = 'latitude';
  static const String longitudeParam = 'longitude';
  static const String accuracyParam = 'accuracy';
  static const String altitudeParam = 'altitude';

}

class Events {
  const Events();

  String get listview => "list";

  String get button => "button";
}


