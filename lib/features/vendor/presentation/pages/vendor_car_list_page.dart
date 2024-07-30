import 'package:animate_do/animate_do.dart';
import 'package:car_tracking_app/core/constants/constants.dart';
import 'package:car_tracking_app/core/di/di.dart';
import 'package:car_tracking_app/core/managers/navigation/app_routes.dart';
import 'package:car_tracking_app/core/utils/device_utils.dart';
import 'package:car_tracking_app/core/utils/snackbar_utils.dart';
import 'package:car_tracking_app/core/widgets/buttons/app_inkwell_widget.dart';
import 'package:car_tracking_app/core/widgets/common/app_loading_indicator.dart';
import 'package:car_tracking_app/core/widgets/common/base_stateful_app_widget.dart';
import 'package:car_tracking_app/core/widgets/common/custom_app_bar.dart';
import 'package:car_tracking_app/features/car/domain/entity/car_entity.dart';
import 'package:car_tracking_app/features/car/presentation/widgets/car_item_widget.dart';
import 'package:car_tracking_app/features/car/presentation/widgets/empty_car_list.dart';
import 'package:car_tracking_app/features/vendor/presentation/bloc/vendor_home/vendor_car_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class VendorCarListPage extends BaseAppStatefulWidget {
  const VendorCarListPage({super.key});

  @override
  BaseAppState<BaseAppStatefulWidget> createBaseState() =>
      _VendorCarListPageState();
}

class _VendorCarListPageState extends BaseAppState<VendorCarListPage> {
  late VendorCarListBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = findDep<VendorCarListBloc>();
    _bloc.add(VendorLoadCars());
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
        statusBarColor: AppColors.white,
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
      body: BlocConsumer<VendorCarListBloc, VendorCarListState>(
        bloc: _bloc,
        listener: (context, state) {
          if (state is VendorCarListLoaded) {
          } else if (state is VendorCarListError) {
            SnackBarUtil.showErrorAlert(error: state.error, context: context);
          }
        },
        builder: (context, state) {
          if (state is VendorCarListLoading) {
            return const Center(
                child: AppLoader(
              iconColor: AppColors.primaryOrangeColor,
            ));
          } else if (state is VendorCarListLoaded) {
            if (state.cars.isEmpty) return const EmptyCarList();
            return SizedBox(
              height: height,
              child: AnimationLimiter(
                child: ListView.builder(
                  itemCount: state.cars.length,
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppDimens.space16),
                  itemBuilder: (context, index) {
                    CarEntity car = state.cars[index];
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(
                          milliseconds: AppDurations.longAnimationDuration),
                      child: SlideAnimation(
                        verticalOffset: 70.0,
                        child: FadeInAnimation(
                          child: AppInkWellWidget(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.vendorCarDetailsPage,
                                    arguments: car);
                              },
                              child: CarItemWidget(car: car)),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }
}
