import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:car_tracking_app/core/constants/app_colors.dart';

class BouncingButton extends StatefulWidget {
  final ButtonStyle? buttonStyle;
  final Color? disableBGColor;
  final Color? disableTextColor;
  final Widget? child;
  final VoidCallback? onPressed;
  final double radius;

  const BouncingButton(
      {super.key,
      this.child,
      this.disableBGColor,
      this.disableTextColor,
      this.radius = 8.0,
      this.onPressed,
      this.buttonStyle});

  @override
  State<BouncingButton> createState() => _BouncingButtonState();
}

class _BouncingButtonState extends State<BouncingButton>
    with SingleTickerProviderStateMixin {
  bool get isEnabled => widget.onPressed != null;
  late final buttonStyle = widget.buttonStyle ?? ElevatedButton.styleFrom();
  final _distanceThreshold = 64.0;
  final GlobalKey _rootKey = GlobalKey();
  final _animationDuration = const Duration(milliseconds: 60);
  late final _animationController = AnimationController(
    vsync: this,
    duration: _animationDuration,
  )..addListener(() {
      setState(() {});
    });

  late final _scaleAnimation = Tween<double>(
    begin: 1.0,
    end: 0.95,
  ).animate(_animationController);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      key: _rootKey,
      child: GestureDetector(
        onTapDown: (_) {
          // _log('onTapDown');
          _tapDown();
        },
        onTapUp: (d) {
          // _log('onTapUp');
          _tapUp();
        },
        onTap: () {
          if (_isInOrTowardsEnd ||
              _animationController.isAnimating ||
              !isEnabled) {
            // print('onTap NO');
            return;
          }
          // _log('onTap\n    ${_animationController.isAnimating}\n    ${_animationController.isCompleted}\n    ${_animationController.isDismissed}');
          HapticFeedback.lightImpact();
          final tickerFuture = _animationController.repeat(reverse: true);
          tickerFuture.timeout(
            _animationDuration * 2,
            onTimeout: () {
              _animationController.forward(from: 0);
              _animationController.stop(canceled: true);
            },
          );
        },
        onLongPressEnd: (d) {
          // _log('onLongPressEnd');
          final isInRange = _isPositionInRange(localPosition: d.localPosition);
          if (isInRange) {
            _tapUp();
          }
        },
        onLongPressMoveUpdate: (details) {
          _onHoldButtonUpdated(localPosition: details.localPosition);
        },
        onPanUpdate: (details) {
          _onHoldButtonUpdated(localPosition: details.localPosition);
        },
        onPanEnd: (_) {
          // _log('onPanEnd');
          _animationController.reverse();
        },
        child: Transform.scale(
          scale: _scaleAnimation.value,
          child: _animatedButton(),
        ),
      ),
    );
  }

  Widget _animatedButton() {
    final enabledBackgroundColor = buttonStyle.backgroundColor
            ?.resolve((<WidgetState>[WidgetState.selected]).toSet()) ??
        AppColors.primaryOrangeColor;
    final disabledBackgroundColor = widget.disableBGColor ??
        buttonStyle.backgroundColor
            ?.resolve((<WidgetState>[WidgetState.disabled]).toSet()) ??
        AppColors.lightGray;


    return Container(
      height: 48,
      width: double.infinity,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        color: isEnabled ? enabledBackgroundColor : disabledBackgroundColor,
        borderRadius: BorderRadius.circular(widget.radius),
      ),
      child: Center(
        child: widget.child,
      ),
    );
  }

  bool _isPositionInRange({required Offset localPosition}) {
    final rootSize = _rootKey.currentContext?.size;
    if (rootSize == null) return false;
    final dx = localPosition.dx;
    final dy = localPosition.dy;
    final isXInRange = dx > (0 - _distanceThreshold) &&
        dx < (rootSize.width + _distanceThreshold);
    final isYInRange = dy > (0 - _distanceThreshold) &&
        dy < (rootSize.height + _distanceThreshold);
    return isXInRange && isYInRange;
  }

  void _onHoldButtonUpdated({required Offset localPosition}) {
    if (!isEnabled) return;
    final isInRange = _isPositionInRange(localPosition: localPosition);
    if (isInRange) {
      if (_animationController.isDismissed) {
        _animationController.forward();
      }
    } else {
      if (_animationController.isCompleted) {
        _animationController.reverse();
      }
    }
  }

  void _tapDown() {
    if (!isEnabled) return;
    _animationController.forward();
    HapticFeedback.lightImpact();
  }

  void _tapUp() {
    if (!isEnabled) return;
    HapticFeedback.lightImpact();
    _animationController.reverse();
    widget.onPressed?.call();
  }

  bool get _isInOrTowardsEnd {
    return _scaleAnimation.status == AnimationStatus.forward ||
        _scaleAnimation.status == AnimationStatus.completed;
  }
}
