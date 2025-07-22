import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';

import '/core/asset_paths.dart';
import '../widgets/bottom_nav_item.dart';
import '/core/navigation/app_router.dart';

@RoutePage()
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        HomeRoute(),
        ProfileRoute(),
      ],
      bottomNavigationBuilder: (_, tr) {
        return SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BottomNavItem(
                  iconPath: AssetPaths.homeImg,
                  title: 'dashboard.home'.tr(),
                  onTap: () => tr.setActiveIndex(0),
                ),
                const Gap(16),
                BottomNavItem(
                  iconPath: AssetPaths.profileImg,
                  title: 'dashboard.profile'.tr(),
                  onTap: () => tr.setActiveIndex(1),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
