import 'package:auto_route/auto_route.dart';

import '../service_locator.dart';
import '/core/entities/session_entity.dart';

import 'app_router.dart';

class AppGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (sl<SessionEntity>().isAuthenticated || resolver.route.name == LoginRoute.name || resolver.route.name == RegisterRoute.name) {
      resolver.next();
    } else {
      resolver.redirectUntil(LoginRoute());
    }
  }
}
