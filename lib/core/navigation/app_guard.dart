import 'package:auto_route/auto_route.dart';

import '/injection/injection_container.dart';
import '/features/auth/presentation/bloc/auth_bloc.dart';

import 'app_router.dart';

class AppGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final authBloc = sl<AuthBloc>();

    if (authBloc.isAuthenticated || resolver.route.name == LoginRoute.name) {
      resolver.next();
    } else {
      resolver.redirect(const LoginRoute());
    }
  }
}
