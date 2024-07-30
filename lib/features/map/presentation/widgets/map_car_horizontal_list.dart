import 'package:car_tracking_app/core/constants/app_durations.dart';
import 'package:car_tracking_app/core/managers/navigation/app_routes.dart';
import 'package:car_tracking_app/core/widgets/bottom_sheet/app_bottom_sheet.dart';
import 'package:car_tracking_app/core/widgets/buttons/app_inkwell_widget.dart';
import 'package:car_tracking_app/features/car/domain/entity/car_entity.dart';
import 'package:car_tracking_app/features/car/presentation/widgets/car_map_item_widget.dart';
import 'package:car_tracking_app/features/map/presentation/widgets/car_live_tracking_sheet.dart';
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
            height: height,
            alignment: Alignment.bottomCenter,
            child: PageView.builder(
              controller: controller,
              itemCount: cars.length,
              onPageChanged: onPageChanged,
              itemBuilder: (context, index) {
                CarEntity car = cars[index];
                return _buildCarCard(car,context);
              },
            ),
          )
        : Container();
  }

  Widget _buildCarCard(CarEntity car,BuildContext context) {
    return AppInkWellWidget(
      onTap: (){
        if(car.status == CarStatusType.delivering.value) {
          AppBottomSheet.showAppModalBottomSheet(
            context,
            CarLiveTrackingSheet(car: car),
            enableDrag: false,
          );
        }else{
          Navigator.pushNamed(context,
              AppRoutes.carDetailsPage,
              arguments: car);
        }
      },
      child: CarMapItemWidget(
        car: car,
        width: width,
        height: height,
      ),
    );
  }
}
