import 'package:animate_do/animate_do.dart';
import 'package:car_tracking_app/core/constants/app_assets.dart';
import 'package:car_tracking_app/core/constants/app_colors.dart';
import 'package:car_tracking_app/core/constants/app_dimens.dart';
import 'package:car_tracking_app/core/constants/app_radius.dart';
import 'package:car_tracking_app/core/constants/app_text_style.dart';
import 'package:car_tracking_app/core/managers/navigation/app_routes.dart';
import 'package:car_tracking_app/core/utils/device_utils.dart';

import 'package:car_tracking_app/core/utils/snackbar_utils.dart';
import 'package:car_tracking_app/core/widgets/buttons/custom_elevated_button.dart';

import 'package:car_tracking_app/core/widgets/common/app_loading_indicator.dart';
import 'package:car_tracking_app/core/widgets/common/custom_app_bar.dart';
import 'package:car_tracking_app/features/car/domain/entity/car_entity.dart';
import 'package:car_tracking_app/features/car/presentation/bloc/car_bloc.dart';
import 'package:car_tracking_app/features/car/presentation/widgets/car_item_widget.dart';
import 'package:car_tracking_app/features/car/presentation/widgets/empty_car_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final CarBloc carBloc;

  List<CarEntity> _cars = [];

  @override
  void initState() {
    super.initState();

    carBloc = CarBloc();
    carBloc.add(GetCarsEvent());
  }

  @override
  Widget build(BuildContext context) {
    final width = DeviceUtils.getScaledWidth(context, 1);
    double margins = 0.1013 * width;
    final appBar = CustomAppBar(
      automaticallyImplyLeading: false,
      title: "",
      customTitle: Center(
        child: ZoomIn(
          child: Image.asset(
            AppAssets.appLogo,
            height: 75,
          ),
        ),
      ),
    );

    final double height = DeviceUtils.getScaledHeight(context, 1) -
        appBar.preferredSize.height -
        MediaQuery.of(context).viewPadding.top -
        margins;
    return Scaffold(
      appBar: CustomAppBar(
        automaticallyImplyLeading: false,
        title: "",
        customTitle: Center(
          child: ZoomIn(
            child: Image.asset(
              AppAssets.appLogo,
              height: 75,
            ),
          ),
        ),
      ),
      body: BlocConsumer<CarBloc, CarState>(
        bloc: carBloc,
        listener: (context, state) {
          if (state is GetCarsSuccess) {
            if (mounted) {
              setState(() {
                _cars = state.cars;
              });
            }
          } else if (state is GetCarsFailed) {
            SnackBarUtil.showErrorAlert(error: state.error, context: context);
          }
        },
        builder: (context, state) {
          if (state is CarLoading) {
            return const Center(
                child: AppLoader(
              iconColor: AppColors.primaryOrangeColor,
            ));
          } else if (state is GetCarsSuccess) {
            if (state.cars.isEmpty) return const EmptyCarList();
            return SizedBox(
              height: height,
              child: Stack(
                children: [
                  ListView.builder(
                    itemCount: state.cars.length,
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppDimens.space16),
                    itemBuilder: (context, index) {
                      CarEntity car = state.cars[index];
                      return CarItemWidget(car: car);
                    },
                  ),
                  Positioned(
                    bottom: 40,
                    child: Container(
                      width: width,
                      alignment: AlignmentDirectional.center,
                      child: CustomElevatedButton(
                        borderRadius: AppRadius.radius24,
                        onPressed: () {
                          Navigator.pushNamed(
                              context, AppRoutes.mapLocationsOverviewPage);
                        },
                        backgroundColor: AppColors.white,
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppDimens.space8,
                              vertical: AppDimens.space6),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.map_outlined,
                                color: AppColors.primaryRedColor,
                                size: 24,
                              ),
                              const SizedBox(
                                width: AppDimens.space6,
                              ),
                              Text(
                                "show on map",
                                style: appTextStyle.middleTSBasic
                                    .copyWith(color: AppColors.primaryRedColor,fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
