import 'package:flutter/cupertino.dart';

class AppVisibilityWidget extends StatelessWidget {
  final Widget child;
  final Widget? replacement;
  final bool visible;

  const AppVisibilityWidget(
      {super.key, required this.child, this.replacement, this.visible = true});

  @override
  Widget build(BuildContext context) {
    return visible ? child : replacement ?? const SizedBox();
  }
}
