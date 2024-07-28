import 'package:car_tracking_app/core/constants/app_colors.dart';
import 'package:car_tracking_app/core/constants/app_dimens.dart';
import 'package:car_tracking_app/core/constants/app_durations.dart';
import 'package:car_tracking_app/core/constants/app_text_style.dart';
import 'package:car_tracking_app/features/car/domain/entity/car_entity.dart';
import 'package:car_tracking_app/features/car/presentation/widgets/car_item_widget.dart';
import 'package:car_tracking_app/features/car/presentation/widgets/car_map_item_widget.dart';
import 'package:flutter/material.dart';

class MapCarHorizontalList extends StatelessWidget {
  final PageController controller;
  final List<CarEntity> cars;
  final void Function(int)? onPageChanged;
  final bool visible;
  final double width;
  final double height;

  const MapCarHorizontalList(
      {super.key,
      required this.controller,
      required this.cars,
      required this.height,
      required this.width,
      this.onPageChanged,
      this.visible = false});

  @override
  Widget build(BuildContext context) {
    return visible
        ? AnimatedContainer(
            duration: const Duration(
                milliseconds: AppDurations.longAnimationDuration),
            alignment: Alignment.bottomCenter, // Animation speed
            child: PageView.builder(
              controller: controller,
              itemCount: cars.length,
              onPageChanged: onPageChanged,
              itemBuilder: (context, index) {
                CarEntity car = cars[index];
                return _buildCarCard(car);
              },
            ),
          )
        : Container();
  }

  Widget _buildCarCard(CarEntity car) {
    return CarMapItemWidget(
      car: car,
      width: width,
      height: height,
    );
  }
}
