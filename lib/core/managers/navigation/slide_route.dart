import 'package:flutter/material.dart';

class SlideRoute extends PageRouteBuilder {
  final Widget page;
  @override
  // ignore: overridden_fields
  final Duration transitionDuration;

  SlideRoute({required this.page,super.settings, this.transitionDuration = const Duration(milliseconds: 666)})
      : super(
    pageBuilder: (ctx, animation, secondaryAnimation) {
      return page;
    },
    transitionsBuilder: (ctx, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );

    },
    transitionDuration: transitionDuration,
  );
}