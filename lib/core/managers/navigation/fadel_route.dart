import 'package:flutter/cupertino.dart';

class FadeRoute extends PageRouteBuilder {
  final Widget page;
  @override
  // ignore: overridden_fields
  final Duration transitionDuration;

  FadeRoute({required this.page,super.settings, this.transitionDuration= const Duration(milliseconds: 333)})
      : super(
    pageBuilder: (ctx, animation, secondaryAnimation) {
      return page;
    },
    transitionsBuilder: (ctx, animation, secondaryAnimation, child) => FadeTransition(
        opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: animation,
            curve: const Interval(0.5, 1.0),
          ),
        ),
        child: child),
    transitionDuration: transitionDuration,
  );
}