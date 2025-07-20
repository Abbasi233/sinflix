import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:gap/gap.dart';

import '/core/navigation/app_router.dart';
import '../utils/bottom_nav_item.dart';

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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BottomNavItem(
                icon: Icons.home,
                title: 'home'.tr(),
                onTap: () => tr.setActiveIndex(0),
              ),
              const Gap(16),
              BottomNavItem(
                icon: Icons.person,
                title: 'profile'.tr(),
                onTap: () => tr.setActiveIndex(1),
              ),
            ],
          ),
        );
      },
    );
  }
}
