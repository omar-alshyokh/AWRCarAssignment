import 'package:cloud_firestore/cloud_firestore.dart';

class TimestampConverter {
  const TimestampConverter._();

  static Timestamp? fromJson(dynamic json) {
    if (json is Timestamp) {
      return json;
    } else if (json is Map<String, dynamic>) {
      return Timestamp(json['_seconds'], json['_nanoseconds']);
    } else {
      return null;
    }
  }

  static dynamic toJson(Timestamp? object) => object;
}

