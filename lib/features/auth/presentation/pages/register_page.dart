import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import '/core/utils.dart';
import '/core/extensions.dart';
import '/core/asset_paths.dart';
import '/core/navigation/app_router.dart';
import '/core/widgets/app_main_button.dart';
import '/core/widgets/app_text_form_field.dart';
import '/features/auth/presentation/bloc/auth_bloc.dart';
import '/features/theme/presentation/bloc/theme_cubit.dart';
import '../widgets/oauth_buttons.dart';

@RoutePage()
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final authBloc = context.read<AuthBloc>();

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _register() {
    if (_formKey.currentState!.validate()) {
      authBloc.add(
        RegisterEvent(
          name: _nameController.text,
          email: _emailController.text,
          password: _passwordController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 39),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'register.greeting'.tr(),
                      style: context.textTheme.titleLarge,
                    ),
                    const Gap(8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 44),
                      child: Text(
                        'register.description'.tr(),
                        style: context.textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Gap(40),
                    AppTextFormField(
                      context,
                      controller: _nameController,
                      hintText: 'keywords.full_name'.tr(),
                      prefixSvgPath: AssetPaths.addUserImg,
                      textCapitalization: TextCapitalization.words,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '';
                        }
                        return null;
                      },
                    ),
                    const Gap(16),
                    AppTextFormField(
                      context,
                      controller: _emailController,
                      hintText: 'keywords.email'.tr(),
                      prefixSvgPath: AssetPaths.messageImg,
                      keyboardType: TextInputType.emailAddress,
                      validator: Utils.validateEmail,
                    ),
                    const Gap(16),
                    AppTextFormField(
                      context,
                      controller: _passwordController,
                      hintText: 'keywords.password'.tr(),
                      prefixSvgPath: AssetPaths.unlockImg,
                      isObscurable: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '';
                        }
                        if (value.length < 6) {
                          return '';
                        }
                        return null;
                      },
                    ),
                    const Gap(16),
                    AppTextFormField(
                      context,
                      controller: _confirmPasswordController,
                      hintText: 'keywords.confirm_password'.tr(),
                      prefixSvgPath: AssetPaths.unlockImg,
                      isObscurable: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '';
                        }
                        if (value != _passwordController.text) {
                          return '';
                        }
                        return null;
                      },
                    ),
                    const Gap(16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text.rich(
                        TextSpan(
                          text: 'register.terms_agreement'.tr(),
                          style: context.textTheme.bodySmall?.copyWith(
                            color: context.textTheme.bodySmall?.color?.withValues(alpha: 0.7),
                          ),
                          children: [
                            TextSpan(
                              text: 'register.terms_agreement_bold'.tr(),
                              style: context.textTheme.bodySmall?.copyWith(
                                color: context.textTheme.bodySmall?.color?.withValues(alpha: 1),
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            TextSpan(
                              text: 'register.terms_agreement_end'.tr(),
                              style: context.textTheme.bodySmall?.copyWith(
                                color: context.textTheme.bodySmall?.color?.withValues(alpha: 0.7),
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Gap(30),
                    BlocConsumer<AuthBloc, AuthState>(
                      bloc: authBloc,
                      listener: (context, state) {
                        if (state is AuthError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message)),
                          );
                        } else if (state is RegisterSuccess) {
                          context.router.push(const DashboardRoute());
                        }
                      },
                      builder: (context, state) {
                        if (state is AuthLoading) {
                          return const CircularProgressIndicator();
                        }
                        return AppMainButton(
                          context,
                          text: 'register.title'.tr(),
                          onPressed: _register,
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
                        context.router.replace(LoginRoute());
                      },
                      child: Text.rich(
                        TextSpan(
                          text: 'register.have_account'.tr(),
                          style: context.textTheme.bodySmall?.copyWith(
                            color: context.textTheme.bodySmall?.color?.withValues(alpha: 0.5),
                          ),
                          children: [
                            const WidgetSpan(child: Text('  ')),
                            TextSpan(
                              text: '${'login.title'.tr()}!',
                              style: context.textTheme.bodySmall?.copyWith(decoration: TextDecoration.underline),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
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
