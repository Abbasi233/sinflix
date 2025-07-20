import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import '/core/navigation/app_router.dart';
import '../bloc/auth_bloc.dart';
import '/injection/injection_container.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthBloc>(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'keywords.email'.tr(),
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'keywords.password'.tr(),
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  } else if (state is LoginSuccess) {
                    // Login başarılı olduğunda ana sayfaya git
                    sl<AppRouter>().push(const DashboardRoute());
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return const CircularProgressIndicator();
                  }

                  return Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(const LoginEvent(email: '', password: ''));
                        },
                        child: Text('login.title'.tr()),
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () {
                          sl<AppRouter>().push(const RegisterRoute());
                        },
                        child: Text('register.title'.tr()),
                      ),
                      if (state is LoginSuccess) ...[
                        const SizedBox(height: 16),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text('Name: ${state.loginEntity.name}'),
                                const SizedBox(height: 8),
                                Text('Email: ${state.loginEntity.email}'),
                                const SizedBox(height: 8),
                                Text('PhotoUrl: ${state.loginEntity.photoUrl}'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
