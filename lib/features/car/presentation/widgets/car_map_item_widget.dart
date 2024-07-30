import 'package:car_tracking_app/core/constants/constants.dart';
import 'package:car_tracking_app/core/managers/localization/app_translation.dart';
import 'package:car_tracking_app/core/widgets/common/app_visibility_widget.dart';
import 'package:car_tracking_app/features/car/domain/entity/car_entity.dart';
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
    return SizedBox(
      height: height,
      child: Card(
        // margin: const EdgeInsets.symmetric(
        //     horizontal: AppDimens.space8, vertical: AppDimens.space16),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.radius12)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.radius12),
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  padding: const EdgeInsets.all(AppDimens.space12),
                  child: Row(
                    children: [
                      car.imageUrl != null
                          ? Hero(
                              tag: '${car.imageUrl!}${car.id}',
                        transitionOnUserGestures: true,
                        flightShuttleBuilder: (flightContext, animation, flightDirection, fromHeroContext, toHeroContext) {

                          return Stack(children: [
                            Positioned.fill(child: FadeTransition(
                                opacity: animation, child: fromHeroContext.widget),
                            ),
                            Positioned.fill(
                                child: FadeTransition(
                                    opacity: ReverseAnimation(ModalRoute.of(context)?.secondaryAnimation ?? animation),
                                    child: toHeroContext.widget)),
                          ]);
                        },
                              child: Image.asset(car.imageUrl!,
                                  width: width * .24),
                            )
                          : Container(width: width * .24, color: Colors.grey),
                      const SizedBox(height: AppDimens.space8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            /// car name
                            Text(
                              car.name,
                              style: appTextStyle.middleTSBasic.copyWith(
                                  color: AppColors.secondaryDarkGrayColor,
                                  fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),

                            /// car main info here (timing, distance ..etc)
                            _carMainInfoSection(),

                            /// vendor information here if they are exist
                            _vendorInfoSection(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: AppDimens.space4,
              ),
              _carStatusBottomSectionStatus(),
              const SizedBox(
                height: AppDimens.space4,
              ),

              /// just a bottom line border its color as car status color
              Container(
                decoration: BoxDecoration(
                    border: BorderDirectional(
                        bottom:
                            BorderSide(color: car.statusColor, width: 2.0))),
              ),
            ],
          ),
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

  Widget _carStatusBottomSectionStatus() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.space12,
      ),
      alignment: Alignment.center,
      child: Text(
        car.statusTextMessage,
        style: appTextStyle.smallTSBasic.copyWith(
          color: car.statusColor,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      ),
    );
  }

  Widget _carMainInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "${translate.car_plate_number}: ${car.carPlate}",
          style: appTextStyle.sub2MinTSBasic
              .copyWith(color: AppColors.secondaryDarkGrayColor),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        AppVisibilityWidget(
          visible: CarStatusType.pending.value == car.status,
          child: Text(
            "${translate.added}: ${car.createdAt?.toDate().getDayStr} at ${car.createdAt?.toDate().getTime}",
            style: appTextStyle.sub2MinTSBasic
                .copyWith(color: AppColors.secondaryDarkGrayColor),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        AppVisibilityWidget(
          visible: car.pickUpTime != null,
          child: Text(
            "${translate.pick_up_time}: ${car.pickUpTime?.toDate().getDayStr} at ${car.pickUpTime?.toDate().getTime}",
            style: appTextStyle.sub2MinTSBasic
                .copyWith(color: AppColors.secondaryDarkGrayColor),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        AppVisibilityWidget(
          visible: car.dropOffTime != null,
          child: Text(
            "${translate.drop_off_time}: ${car.dropOffTime?.toDate().getDayStr} at ${car.dropOffTime?.toDate().getTime}",
            style: appTextStyle.sub2MinTSBasic
                .copyWith(color: AppColors.secondaryDarkGrayColor),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        AppVisibilityWidget(
          visible: car.totalKm.itHasValue,
          replacement: Container(),
          child: Text(
            "${translate.trip_distance}: ${car.totalKm} km",
            style: appTextStyle.sub2MinTSBasic
                .copyWith(color: AppColors.secondaryDarkGrayColor),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        )
      ],
    );
  }

  Widget _vendorInfoSection() {
    return AppVisibilityWidget(
      visible:
          car.vendorUserName.itHasValue || car.vendorContactNumber.itHasValue,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(
            height: 2,
          ),
          Text(
            translate.vendor_info,
            style:
                appTextStyle.minTSBasic.copyWith(fontWeight: FontWeight.w500),
          ),
          AppVisibilityWidget(
            visible: car.vendorUserName.itHasValue,
            replacement: Container(),
            child: _iconWithTitleWidget(
                title: car.vendorUserName ?? "", icon: Icons.person),
          ),
          AppVisibilityWidget(
            visible: car.vendorContactNumber.itHasValue,
            replacement: Container(),
            child: _iconWithTitleWidget(
                title: car.vendorContactNumber ?? "", icon: Icons.call),
          ),
        ],
      ),
    );
  }
}
