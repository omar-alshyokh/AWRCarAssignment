import 'package:car_tracking_app/core/constants/constants.dart';
import 'package:car_tracking_app/core/managers/localization/app_language.dart';
import 'package:car_tracking_app/core/managers/localization/app_translation.dart';
import 'package:car_tracking_app/core/managers/navigation/app_routes.dart';
import 'package:car_tracking_app/features/home/presentation/pages/home_page.dart';
import 'package:car_tracking_app/features/settings/presentation/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainRootPage extends StatefulWidget {
  const MainRootPage({super.key});

  @override
  State<MainRootPage> createState() => _MainRootPageState();
}

class _MainRootPageState extends State<MainRootPage> {
  int _currentIndex = 0;

  late AppLanguage languageManager;

  final List<Widget> _screens = [
    const HomePage(),
    const SizedBox(),
    const SettingsPage(),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    languageManager = context.watch<AppLanguage>();
  }

  @override
  Widget build(BuildContext context) {
    /// widget list
    const double iconActiveSize = 24;
    const double iconUnActiveSize = 18;
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      extendBody: true,
      bottomNavigationBar: Container(
        height: 60,
        margin: const EdgeInsets.symmetric(
            horizontal: AppDimens.space16, vertical: AppDimens.space8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.radius16)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.radius16),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            backgroundColor: AppColors.bottomNavBarColor,
            onTap: (index) {
              if (index == 1) {
                Navigator.pushNamed(context, AppRoutes.addCarPage);
              } else {
                if (mounted) {
                  setState(() {
                    _currentIndex = index;
                  });
                }
              }
            },
            selectedItemColor: AppColors.white,
            unselectedItemColor: AppColors.primaryGrayColor,
            selectedFontSize: AppTextSize.min,
            unselectedFontSize: AppTextSize.sub2Min,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                icon: const Icon(
                  Icons.home_outlined,
                  size: iconUnActiveSize,
                ),
                activeIcon: const Icon(
                  Icons.home,
                  size: iconActiveSize,
                ),
                label: translate.home,
              ),
              const BottomNavigationBarItem(
                icon: Icon(
                  Icons.add_box,
                  size: 34,
                ),
                activeIcon: Icon(
                  Icons.add_box,
                  size: 34,
                ),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: const Icon(
                  Icons.person_2_outlined,
                  size: iconUnActiveSize,
                ),
                activeIcon: const Icon(
                  Icons.person,
                  size: iconActiveSize,
                ),
                label: translate.settings,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
