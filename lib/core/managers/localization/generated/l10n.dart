// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class Translations {
  Translations();

  static Translations? _current;

  static Translations get current {
    assert(_current != null,
        'No instance of Translations was loaded. Try to initialize the Translations delegate before accessing Translations.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<Translations> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = Translations();
      Translations._current = instance;

      return instance;
    });
  }

  static Translations of(BuildContext context) {
    final instance = Translations.maybeOf(context);
    assert(instance != null,
        'No instance of Translations present in the widget tree. Did you add Translations.delegate in localizationsDelegates?');
    return instance!;
  }

  static Translations? maybeOf(BuildContext context) {
    return Localizations.of<Translations>(context, Translations);
  }

  /// `Sorry!`
  String get sorry {
    return Intl.message(
      'Sorry!',
      name: 'sorry',
      desc: '',
      args: [],
    );
  }

  /// `Check your internet connection`
  String get something_went_wrong_check_connection {
    return Intl.message(
      'Check your internet connection',
      name: 'something_went_wrong_check_connection',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong`
  String get something_went_wrong {
    return Intl.message(
      'Something went wrong',
      name: 'something_went_wrong',
      desc: '',
      args: [],
    );
  }

  /// `Unexpected Error happened`
  String get error_unexpected {
    return Intl.message(
      'Unexpected Error happened',
      name: 'error_unexpected',
      desc: '',
      args: [],
    );
  }

  /// `You're not authorized, Please auth again.`
  String get un_authorized_error {
    return Intl.message(
      'You\'re not authorized, Please auth again.',
      name: 'un_authorized_error',
      desc: '',
      args: [],
    );
  }

  /// `Connection Error`
  String get connection_error {
    return Intl.message(
      'Connection Error',
      name: 'connection_error',
      desc: '',
      args: [],
    );
  }

  /// `Canceled by the user`
  String get user_cancel_error {
    return Intl.message(
      'Canceled by the user',
      name: 'user_cancel_error',
      desc: '',
      args: [],
    );
  }

  /// `Unknown error`
  String get unknown_error {
    return Intl.message(
      'Unknown error',
      name: 'unknown_error',
      desc: '',
      args: [],
    );
  }

  /// `Internal server error`
  String get error_internal_server {
    return Intl.message(
      'Internal server error',
      name: 'error_internal_server',
      desc: '',
      args: [],
    );
  }

  /// `Please Verify Your email First`
  String get error_unverified_email {
    return Intl.message(
      'Please Verify Your email First',
      name: 'error_unverified_email',
      desc: '',
      args: [],
    );
  }

  /// `Request to API server was cancelled`
  String get dio_cancel_error {
    return Intl.message(
      'Request to API server was cancelled',
      name: 'dio_cancel_error',
      desc: '',
      args: [],
    );
  }

  /// `Connection timeout with API server`
  String get dio_connection_timeout_error {
    return Intl.message(
      'Connection timeout with API server',
      name: 'dio_connection_timeout_error',
      desc: '',
      args: [],
    );
  }

  /// `Receive timeout in connection with API server`
  String get dio_receive_connection_timeout_error {
    return Intl.message(
      'Receive timeout in connection with API server',
      name: 'dio_receive_connection_timeout_error',
      desc: '',
      args: [],
    );
  }

  /// `Send timeout in connection with API server`
  String get dio_send_timeout_to_the_server {
    return Intl.message(
      'Send timeout in connection with API server',
      name: 'dio_send_timeout_to_the_server',
      desc: '',
      args: [],
    );
  }

  /// `Bad Request!`
  String get dio_bad_request_error {
    return Intl.message(
      'Bad Request!',
      name: 'dio_bad_request_error',
      desc: '',
      args: [],
    );
  }

  /// `Not found error!`
  String get dio_not_found_error {
    return Intl.message(
      'Not found error!',
      name: 'dio_not_found_error',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Invalid data`
  String get invalid_data {
    return Intl.message(
      'Invalid data',
      name: 'invalid_data',
      desc: '',
      args: [],
    );
  }

  /// `Whoops!!`
  String get woops {
    return Intl.message(
      'Whoops!!',
      name: 'woops',
      desc: '',
      args: [],
    );
  }

  /// `There seems to be a problem with\n your Network Connection.`
  String get noNetErrorDesc {
    return Intl.message(
      'There seems to be a problem with\n your Network Connection.',
      name: 'noNetErrorDesc',
      desc: '',
      args: [],
    );
  }

  /// `Try again`
  String get try_again {
    return Intl.message(
      'Try again',
      name: 'try_again',
      desc: '',
      args: [],
    );
  }

  /// `========================================================`
  String get end_error_strings {
    return Intl.message(
      '========================================================',
      name: 'end_error_strings',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Add Car`
  String get add_car {
    return Intl.message(
      'Add Car',
      name: 'add_car',
      desc: '',
      args: [],
    );
  }

  /// `Select the car brand`
  String get hint_select_brand {
    return Intl.message(
      'Select the car brand',
      name: 'hint_select_brand',
      desc: '',
      args: [],
    );
  }

  /// `Select the car model`
  String get hint_select_car_model {
    return Intl.message(
      'Select the car model',
      name: 'hint_select_car_model',
      desc: '',
      args: [],
    );
  }

  /// `Select Item`
  String get select_item {
    return Intl.message(
      'Select Item',
      name: 'select_item',
      desc: '',
      args: [],
    );
  }

  /// `Car Brand`
  String get car_brand {
    return Intl.message(
      'Car Brand',
      name: 'car_brand',
      desc: '',
      args: [],
    );
  }

  /// `Car Model`
  String get car_model {
    return Intl.message(
      'Car Model',
      name: 'car_model',
      desc: '',
      args: [],
    );
  }

  /// `Current Car Kilometers`
  String get current_car_kilometers {
    return Intl.message(
      'Current Car Kilometers',
      name: 'current_car_kilometers',
      desc: '',
      args: [],
    );
  }

  /// `Entre current car's driven kilometers`
  String get current_car_kilometers_hint {
    return Intl.message(
      'Entre current car\'s driven kilometers',
      name: 'current_car_kilometers_hint',
      desc: '',
      args: [],
    );
  }

  /// `Location permission is required`
  String get location_permission_is_required {
    return Intl.message(
      'Location permission is required',
      name: 'location_permission_is_required',
      desc: '',
      args: [],
    );
  }

  /// `Direction`
  String get direction {
    return Intl.message(
      'Direction',
      name: 'direction',
      desc: '',
      args: [],
    );
  }

  /// `Clear`
  String get clear {
    return Intl.message(
      'Clear',
      name: 'clear',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Select Location`
  String get select_location {
    return Intl.message(
      'Select Location',
      name: 'select_location',
      desc: '',
      args: [],
    );
  }

  /// `Pick-Up Location`
  String get pick_up_location {
    return Intl.message(
      'Pick-Up Location',
      name: 'pick_up_location',
      desc: '',
      args: [],
    );
  }

  /// `Drop-Off Location`
  String get drop_off_location {
    return Intl.message(
      'Drop-Off Location',
      name: 'drop_off_location',
      desc: '',
      args: [],
    );
  }

  /// `Tap to edite`
  String get tap_to_edit {
    return Intl.message(
      'Tap to edite',
      name: 'tap_to_edit',
      desc: '',
      args: [],
    );
  }

  /// `Tap to pick the location on the map`
  String get tap_to_pick_the_location_on_the_map {
    return Intl.message(
      'Tap to pick the location on the map',
      name: 'tap_to_pick_the_location_on_the_map',
      desc: '',
      args: [],
    );
  }

  /// `Car Plate Number`
  String get car_plate_number {
    return Intl.message(
      'Car Plate Number',
      name: 'car_plate_number',
      desc: '',
      args: [],
    );
  }

  /// `Entre car's plate number`
  String get car_plate_number_hint {
    return Intl.message(
      'Entre car\'s plate number',
      name: 'car_plate_number_hint',
      desc: '',
      args: [],
    );
  }

  /// `Car Model Year`
  String get car_model_year {
    return Intl.message(
      'Car Model Year',
      name: 'car_model_year',
      desc: '',
      args: [],
    );
  }

  /// `Entre car's model year`
  String get car_model_year_hint {
    return Intl.message(
      'Entre car\'s model year',
      name: 'car_model_year_hint',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Please, fill the car details information.`
  String get please_fill_the_car_details_info {
    return Intl.message(
      'Please, fill the car details information.',
      name: 'please_fill_the_car_details_info',
      desc: '',
      args: [],
    );
  }

  /// `Missing Information`
  String get missing_info {
    return Intl.message(
      'Missing Information',
      name: 'missing_info',
      desc: '',
      args: [],
    );
  }

  /// `Add new car`
  String get add_new_car {
    return Intl.message(
      'Add new car',
      name: 'add_new_car',
      desc: '',
      args: [],
    );
  }

  /// `{name} has been successfully added`
  String add_new_car_success_body(String name) {
    return Intl.message(
      '$name has been successfully added',
      name: 'add_new_car_success_body',
      desc: 'This is the text car name',
      args: [name],
    );
  }

  /// `There are no cars available now.`
  String get there_are_no_cars_available_now {
    return Intl.message(
      'There are no cars available now.',
      name: 'there_are_no_cars_available_now',
      desc: '',
      args: [],
    );
  }

  /// `Let's add a new car`
  String get lets_add_new_car {
    return Intl.message(
      'Let\'s add a new car',
      name: 'lets_add_new_car',
      desc: '',
      args: [],
    );
  }

  /// `Year`
  String get year {
    return Intl.message(
      'Year',
      name: 'year',
      desc: '',
      args: [],
    );
  }

  /// `Current KM`
  String get current_km {
    return Intl.message(
      'Current KM',
      name: 'current_km',
      desc: '',
      args: [],
    );
  }

  /// `Added`
  String get added {
    return Intl.message(
      'Added',
      name: 'added',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get status {
    return Intl.message(
      'Status',
      name: 'status',
      desc: '',
      args: [],
    );
  }

  /// `Pending`
  String get pending {
    return Intl.message(
      'Pending',
      name: 'pending',
      desc: '',
      args: [],
    );
  }

  /// `Delivering`
  String get delivering {
    return Intl.message(
      'Delivering',
      name: 'delivering',
      desc: '',
      args: [],
    );
  }

  /// `Delivered`
  String get delivered {
    return Intl.message(
      'Delivered',
      name: 'delivered',
      desc: '',
      args: [],
    );
  }

  /// `Unknown`
  String get unknown {
    return Intl.message(
      'Unknown',
      name: 'unknown',
      desc: '',
      args: [],
    );
  }

  /// `The car is eagerly waiting to start its journey`
  String get pending_message {
    return Intl.message(
      'The car is eagerly waiting to start its journey',
      name: 'pending_message',
      desc: '',
      args: [],
    );
  }

  /// `The car is on the road`
  String get delivering_message {
    return Intl.message(
      'The car is on the road',
      name: 'delivering_message',
      desc: '',
      args: [],
    );
  }

  /// `The car has safely reached its destination`
  String get delivered_message {
    return Intl.message(
      'The car has safely reached its destination',
      name: 'delivered_message',
      desc: '',
      args: [],
    );
  }

  /// `The car's status is a mystery!`
  String get unknown_message {
    return Intl.message(
      'The car\'s status is a mystery!',
      name: 'unknown_message',
      desc: '',
      args: [],
    );
  }

  /// `Pick-Up time`
  String get pick_up_time {
    return Intl.message(
      'Pick-Up time',
      name: 'pick_up_time',
      desc: '',
      args: [],
    );
  }

  /// `Drop-Off time`
  String get drop_off_time {
    return Intl.message(
      'Drop-Off time',
      name: 'drop_off_time',
      desc: '',
      args: [],
    );
  }

  /// `Vendor name`
  String get vendor_name {
    return Intl.message(
      'Vendor name',
      name: 'vendor_name',
      desc: '',
      args: [],
    );
  }

  /// `Vendor contact number`
  String get vendor_contact_number {
    return Intl.message(
      'Vendor contact number',
      name: 'vendor_contact_number',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<Translations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar', countryCode: 'EG'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<Translations> load(Locale locale) => Translations.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
