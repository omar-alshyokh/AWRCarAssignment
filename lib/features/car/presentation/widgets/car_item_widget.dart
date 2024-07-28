import 'package:car_tracking_app/core/constants/app_colors.dart';
import 'package:car_tracking_app/core/constants/app_radius.dart';
import 'package:car_tracking_app/core/constants/constants.dart';
import 'package:car_tracking_app/core/managers/localization/app_translation.dart';
import 'package:car_tracking_app/core/utils/device_utils.dart';
import 'package:car_tracking_app/core/widgets/buttons/app_inkwell_widget.dart';
import 'package:car_tracking_app/features/car/domain/entity/car_entity.dart';
import 'package:flutter/material.dart';

class CarItemWidget extends StatelessWidget {
  final CarEntity car;

  const CarItemWidget({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    final double width = DeviceUtils.getScaledWidth(context, 1.0);
    final double height = DeviceUtils.getScaledHeight(context, 1.0);
    final double itemHeight = height * 0.16;
    return AppInkWellWidget(
      onTap: () {},
      splashAppInkWellColor: AppColors.transparent,
      child: Card(
        color: AppColors.white,
        elevation: 2,
        shadowColor: car.statusColor.withOpacity(0.7),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.radius12)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.radius12),
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.space8, vertical: AppDimens.space6),
            width: width,
            height: itemHeight,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    width: 110,
                    height: 120,
                    child: Center(
                      child: Image.asset(
                        car.imageUrl ?? "",
                      ),
                    )),
                const SizedBox(
                  width: AppDimens.space14,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        car.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: appTextStyle.middleTSBasic.copyWith(
                            color: AppColors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: AppDimens.space4,
                      ),
                      Text(
                        '${translate.year}: ${car.modelYear}',
                        style: appTextStyle.smallTSBasic
                            .copyWith(color: AppColors.black),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: AppDimens.space4,
                      ),
                      RichText(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          text: '${translate.status}: ',
                          style: appTextStyle.smallTSBasic
                              .copyWith(color: AppColors.black),
                          children: <TextSpan>[
                            TextSpan(
                                text: car.statusText,
                                style: appTextStyle.smallTSBasic.copyWith(
                                    color: car.statusColor,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: AppDimens.space4,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time_outlined,
                            color: AppColors.primaryGrayColor,
                            size: 12,
                          ),
                          const SizedBox(
                            width: AppDimens.space2,
                          ),
                          Text(
                            '${car.createdAt?.toDate().getDayStr} at ${car.createdAt?.toDate().getTime}',
                            style: appTextStyle.sub2MinTSBasic
                                .copyWith(color: AppColors.primaryGrayColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
