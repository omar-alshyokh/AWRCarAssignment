// ignore: unused_import
import 'package:car_tracking_app/core/error/base_error.dart';
import 'package:car_tracking_app/core/error/custom_error.dart';

class EndpointsConfig {
  EndpointsConfig._();

  /// receiveTimeout config
  static const Duration receiveTimeout = Duration(milliseconds: 15000);

  /// connectTimeout config
  static const Duration connectionTimeout = Duration(milliseconds: 15000);

  static const Map<String, dynamic> defaultHeaderValues = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
}

enum Endpoints {
  /// base url
  baseUrl,
  posts,
}

extension EndpointsString on Endpoints {

  static const valueMap = {
    Endpoints.baseUrl: 'https://jsonplaceholder.typicode.com',
    Endpoints.posts: '/posts',
  };

  String get value {
    if (!valueMap.containsKey(this)) {
      throw const CustomError(message: "EndPoint value not found");
    }
    return valueMap[this]!;
  }
}
