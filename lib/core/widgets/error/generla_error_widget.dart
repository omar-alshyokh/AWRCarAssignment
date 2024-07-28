import 'package:car_tracking_app/core/error/base_error.dart';
import 'package:car_tracking_app/core/error/dio_error.dart';
import 'package:car_tracking_app/core/widgets/error/unexpected_error_widget.dart';
import 'package:flutter/material.dart';
import 'connection_error_widget.dart';

class GeneralErrorWidget extends StatelessWidget {
  final double? width;
  final Function() callback;
  final BaseError? error;

  const GeneralErrorWidget(
      {super.key, this.width, required this.callback, this.error});

  @override
  Widget build(BuildContext context) {
    return error is ConnectionDioError
        ? ConnectionErrorWidget(
            callback: callback,
          )
        : UnExpectedErrorWidget(
            callback: callback,
          );
  }
}
