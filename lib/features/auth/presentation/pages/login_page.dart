import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import '/core/asset_paths.dart';
import '/core/extensions.dart';
import '/core/navigation/app_router.dart';
import '/core/widgets/app_main_button.dart';
import '/core/widgets/app_text_form_field.dart';
import '/core/widgets/loading_widget.dart';
import '/features/auth/presentation/bloc/auth_bloc.dart';
import '/features/theme/presentation/bloc/theme_cubit.dart';
import '../widgets/oauth_buttons.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 39),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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
                  BlocConsumer<AuthBloc, AuthState>(
                    bloc: authBloc,
                    listener: (context, state) {
                      LoadingWidget.hide();

                      if (state is AuthLoading) {
                        LoadingWidget.show(context);
                      } else if (state is AuthError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.message)),
                        );
                      } else if (state is LoginSuccess) {
                        context.router.replace(const DashboardRoute());
                      }
                    },
                    builder: (context, state) {
                      return AppMainButton(
                        context,
                        text: 'login.title'.tr(),
                        onPressed: state is AuthLoading
                            ? null
                            : () {
                                authBloc.add(
                                  LoginEvent(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  ),
                                );
                              },
                      );
                    },
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
                          color: context.textTheme.bodySmall?.color?.withValues(alpha: 0.5),
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
                ],
              ),
            ),
            Positioned(
              top: 16,
              right: 16,
              child: BlocBuilder<ThemeCubit, ThemeMode>(
                builder: (context, state) {
                  return IconButton(
                    onPressed: () {
                      context.read<ThemeCubit>().changeTheme(
                        state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark,
                      );
                    },
                    icon: Icon(
                      state == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
