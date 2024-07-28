import 'package:car_tracking_app/core/constants/app_colors.dart';
import 'package:car_tracking_app/core/constants/app_radius.dart';
import 'package:car_tracking_app/core/constants/constants.dart';
import 'package:car_tracking_app/core/managers/localization/app_translation.dart';
import 'package:car_tracking_app/core/utils/device_utils.dart';
import 'package:car_tracking_app/core/widgets/buttons/app_inkwell_widget.dart';
import 'package:car_tracking_app/features/car/domain/entity/car_entity.dart';
import 'package:car_tracking_app/features/car/domain/entity/car_status_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CarMapItemWidget extends StatelessWidget {
  final CarEntity car;
  final double width;
  final double height;

  const CarMapItemWidget(
      {super.key,
      required this.car,
      required this.width,
      required this.height});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
          horizontal: AppDimens.space8, vertical: AppDimens.space16),
      child: SizedBox(
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: Container(
                padding: const EdgeInsets.all(AppDimens.space12),
                child: Row(
                  children: [
                    car.imageUrl != null
                        ? Image.asset(car.imageUrl!, width: width * .24)
                        : Container(width: width * .24, color: Colors.grey),
                    const SizedBox(height: AppDimens.space8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            car.name,
                            style: appTextStyle.middleTSBasic.copyWith(
                                color: AppColors.secondaryDarkGrayColor,
                                fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Text(
                            "${translate.car_plate_number}: ${car.carPlate}",
                            style: appTextStyle.sub2MinTSBasic.copyWith(
                                color: AppColors.secondaryDarkGrayColor),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Visibility(
                            visible: 1 == car.status,
                            replacement: Container(),
                            child: Text(
                              "${translate.added}: ${car.createdAt?.toDate().getDayStr} at ${car.createdAt?.toDate().getTime}",
                              style: appTextStyle.sub2MinTSBasic.copyWith(
                                  color: AppColors.secondaryDarkGrayColor),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          Visibility(
                            visible: car.pickUpTime != null,
                            replacement: Container(),
                            child: Text(
                              "${translate.pick_up_time}: ${car.pickUpTime?.toDate().getDayStr} at ${car.pickUpTime?.toDate().getTime}",
                              style: appTextStyle.sub2MinTSBasic.copyWith(
                                  color: AppColors.secondaryDarkGrayColor),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          Visibility(
                            visible: car.dropOffTime != null,
                            replacement: Container(),
                            child: Text(
                              "${translate.drop_off_time}: ${car.dropOffTime?.toDate().getDayStr} at ${car.dropOffTime?.toDate().getTime}",
                              style: appTextStyle.sub2MinTSBasic.copyWith(
                                  color: AppColors.secondaryDarkGrayColor),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          Visibility(
                            visible: car.vendorUserName.itHasValue,
                            replacement: Container(),
                            child: _iconWithTitleWidget(
                                title: car.vendorUserName ?? "",
                                icon: Icons.person),
                          ),
                          Visibility(
                            visible: car.vendorContactNumber.itHasValue,
                            replacement: Container(),
                            child: _iconWithTitleWidget(
                                title: car.vendorContactNumber ?? "",
                                icon: Icons.call),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: AppDimens.space6,
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimens.space12,
                ),
                color: car.statusColor,
                alignment: Alignment.center,
                child: Text(
                  car.statusTextMessage,
                  style: appTextStyle.smallTSBasic.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _iconWithTitleWidget({required String title, required IconData icon}) {
    return Row(
      children: [
        Icon(
          icon,
          size: 10,
          color: AppColors.black,
        ),
        const SizedBox(
          width: AppDimens.space4,
        ),
        Text(
          title,
          style: appTextStyle.sub2MinTSBasic
              .copyWith(color: AppColors.secondaryDarkGrayColor),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
