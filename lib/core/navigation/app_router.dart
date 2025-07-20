import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';

import '/features/auth/presentation/pages/login_page.dart';
import '/features/auth/presentation/pages/register_page.dart';
import '/features/dashboard/presentation/pages/home_page.dart';
import '/features/dashboard/presentation/pages/profile_page.dart';
import '/features/dashboard/presentation/pages/dashboard_page.dart';
import 'app_guard.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(path: '/login', page: LoginRoute.page),
    AutoRoute(path: '/register', page: RegisterRoute.page),
    AutoRoute(
      path: '/',
      page: DashboardRoute.page,
      initial: true,
      children: [
        AutoRoute(path: 'homepage', page: HomeRoute.page, initial: true),
        AutoRoute(path: 'profile', page: ProfileRoute.page),
      ],
    ),
    RedirectRoute(path: '*', redirectTo: '/'),
  ];

  @override
  final List<AutoRouteGuard> guards = [AppGuard()];
}
