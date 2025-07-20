import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import '../bloc/auth_bloc.dart';
import '/core/navigation/app_router.dart';
import '/injection/injection_container.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final emailController = TextEditingController(text: "safa@nodelabs.com");
  final passwordController = TextEditingController(text: "123456");
  final authBloc = sl<AuthBloc>();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'keywords.email'.tr(),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'keywords.password'.tr(),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  BlocConsumer<AuthBloc, AuthState>(
                    bloc: authBloc,
                    listener: (context, state) {
                      if (state is AuthError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.message)),
                        );
                      } else if (state is LoginSuccess) {
                        context.router.push(const DashboardRoute());
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
                              authBloc.add(
                                LoginEvent(
                                  email: emailController.text,
                                  password: passwordController.text,
                                ),
                              );
                            },
                            child: Text('login.title'.tr()),
                          ),
                          const SizedBox(height: 16),
                          TextButton(
                            onPressed: () {
                              context.router.push(const RegisterRoute());
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
      },
    );
  }
}
