import 'package:car_tracking_app/core/constants/constants.dart';
import 'package:car_tracking_app/core/managers/localization/app_translation.dart';
import 'package:car_tracking_app/core/managers/navigation/app_routes.dart';
import 'package:car_tracking_app/core/widgets/buttons/custom_elevated_button.dart';
import 'package:flutter/material.dart';

class EmptyCarList extends StatelessWidget {
  const EmptyCarList({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              translate.there_are_no_cars_available_now,
              style: appTextStyle.smallTSBasic
                  .copyWith(color: AppColors.secondaryDarkGrayColor),
            ),
            const SizedBox(
              height: AppDimens.space16,
            ),
            CustomElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.addCarPage);
                },
                backgroundColor: AppColors.primaryOrangeColor,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.add,
                      color: AppColors.white,
                      size: 24,
                    ),
                    Text(
                      translate.lets_add_new_car,
                      style: appTextStyle.middleTSBasic
                          .copyWith(color: AppColors.white),
                    ),
                  ],
                ))
          ],
        ));
  }
}
