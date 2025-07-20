import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import '/core/asset_paths.dart';
import '../bloc/auth_bloc.dart';
import '/core/extensions.dart';
import '/core/service_locator.dart';
import '/core/navigation/app_router.dart';
import '/core/widgets/app_main_button.dart';
import '/core/widgets/app_text_form_field.dart';
import '/features/theme/presentation/bloc/theme_cubit.dart';
import '/features/auth/presentation/utils/oauth_buttons.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final authBloc = sl<AuthBloc>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(39),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              BlocBuilder<ThemeCubit, ThemeMode>(
                builder: (context, state) {
                  return Switch(
                    value: state == ThemeMode.dark,
                    onChanged: (value) {
                      context.read<ThemeCubit>().changeTheme(
                        value ? ThemeMode.dark : ThemeMode.light,
                      );
                    },
                  );
                },
              ),
              Text(
                'login.greeting'.tr(),
                style: context.textTheme.titleLarge,
              ),
              const Gap(8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 44),
                child: Text(
                  'login.description'.tr(),
                  style: context.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              const Gap(40),
              AppTextFormField(
                context,
                controller: emailController,
                hintText: 'keywords.email'.tr(),
                prefixSvgPath: AssetPaths.messageImg,
              ),
              const Gap(16),
              AppTextFormField(
                context,
                controller: passwordController,
                isObscurable: true,
                hintText: 'keywords.password'.tr(),
                prefixSvgPath: AssetPaths.unlockImg,
              ),
              const Gap(30),
              Row(
                children: [
                  Text(
                    'login.forgot_password'.tr(),
                    style: context.textTheme.bodyMedium?.copyWith(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
              const Gap(24),
              AppMainButton(
                context,
                text: 'login.title'.tr(),
                onPressed: () {},
              ),
              const Gap(37),
              const Row(
                spacing: 8,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OAuthButton(imgPath: AssetPaths.googleImg),
                  OAuthButton(imgPath: AssetPaths.appleImg),
                  OAuthButton(imgPath: AssetPaths.facebookImg),
                ],
              ),
              const Gap(32),
              GestureDetector(
                onTap: () {
                  context.router.replace(const RegisterRoute());
                },
                child: Text.rich(
                  TextSpan(
                    text: 'login.no_account'.tr(),
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.textTheme.bodySmall?.color?.withOpacity(0.5),
                    ),
                    children: [
                      const WidgetSpan(child: Text('  ')),
                      TextSpan(
                        text: '${'register.title'.tr()}!',
                        style: context.textTheme.bodySmall?.copyWith(decoration: TextDecoration.underline),
                      ),
                    ],
                  ),
                ),
              ),
              // BlocConsumer<AuthBloc, AuthState>(
              //   bloc: authBloc,
              //   listener: (context, state) {
              //     if (state is AuthError) {
              //       ScaffoldMessenger.of(context).showSnackBar(
              //         SnackBar(content: Text(state.message)),
              //       );
              //     } else if (state is LoginSuccess) {
              //       context.router.push(const DashboardRoute());
              //     }
              //   },
              //   builder: (context, state) {
              //     if (state is AuthLoading) {
              //       return const CircularProgressIndicator();
              //     }

              //     return Column(
              //       children: [
              //         ElevatedButton(
              //           onPressed: () {
              //             authBloc.add(
              //               LoginEvent(
              //                 email: emailController.text,
              //                 password: passwordController.text,
              //               ),
              //             );
              //           },
              //           child: Text('login.title'.tr()),
              //         ),
              //         const SizedBox(height: 16),
              //         TextButton(
              //           onPressed: () {
              //             context.router.push(const RegisterRoute());
              //           },
              //           child: Text('register.title'.tr()),
              //         ),
              //         if (state is LoginSuccess) ...[
              //           const SizedBox(height: 16),
              //           Card(
              //             child: Padding(
              //               padding: const EdgeInsets.all(16.0),
              //               child: Column(
              //                 children: [
              //                   Text('Name: ${state.loginEntity.name}'),
              //                   const SizedBox(height: 8),
              //                   Text('Email: ${state.loginEntity.email}'),
              //                   const SizedBox(height: 8),
              //                   Text('PhotoUrl: ${state.loginEntity.photoUrl}'),
              //                 ],
              //               ),
              //             ),
              //           ),
              //         ],
              //       ],
              //     );
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
