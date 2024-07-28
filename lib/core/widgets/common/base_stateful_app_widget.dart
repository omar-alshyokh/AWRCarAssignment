import 'package:car_tracking_app/core/managers/analytics/central/analytics_mixin.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

abstract class BaseAppStatefulWidget extends StatefulWidget {
  const BaseAppStatefulWidget({super.key});

  @override
  BaseAppState createState() => createBaseState();

  BaseAppState createBaseState();
}

abstract class BaseAppState<T extends BaseAppStatefulWidget> extends State<T>
    with AnalyticsMixin {
  late final CancelToken cancelToken;

  /// in case we don't want to send open and close events
  /// just override this flag and will ignore the close and open events
  bool? ignoreOpenCloseEvents;

  @override
  void initState() {
    super.initState();
    if (ignoreOpenCloseEvents != true) {
      customOpenEventParams();
    }

    cancelToken = CancelToken();
  }

  @override
  void dispose() {
    // Any cleanup code can go here.

    if (ignoreOpenCloseEvents != true) {
      customCloseEventParams();
    }
    cancelToken.cancel();
    super.dispose();
  }

  /// this method help us to pass additional custom params to open event
  Future<void> customOpenEventParams(
      [Map<String, dynamic>? customParam]) async {
    // Base implementation uses customParam if provided
    openPage(page: widget.runtimeType.toString(), parameters: customParam);
  }

  /// this method help us to pass additional custom params to close event
  Future<void> customCloseEventParams(
      [Map<String, dynamic>? customParam]) async {
    // Base implementation uses customParam if provided
    closePage(page: widget.runtimeType.toString(), parameters: customParam);
  }
}
