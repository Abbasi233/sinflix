import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sinflix/core/asset_paths.dart';
import 'package:sinflix/core/colors.dart';
import 'package:sinflix/core/extensions.dart';
import 'package:sinflix/core/widgets/app_back_button.dart';
import 'package:sinflix/core/widgets/app_main_button.dart';
import 'package:sinflix/core/widgets/loading_widget.dart';
import 'package:sinflix/features/auth/presentation/bloc/auth_bloc.dart';
import '../bloc/upload_photo_cubit.dart';

@RoutePage()
class UploadPhotoPage extends StatelessWidget {
  const UploadPhotoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SelectPhotoCubit(),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is PhotoUploading) {
            LoadingWidget.show(context);
          } else if (state is PhotoUploaded) {
            LoadingWidget.hide();

            context.router.maybePop();
            context.showSnackBar("upload_photo.success_message".tr());
          } else if (state is AuthError) {
            LoadingWidget.hide();
            context.showSnackBar(state.message, isError: true);
          }
        },
        child: const _UploadPhotoView(),
      ),
    );
  }
}

class _UploadPhotoView extends StatelessWidget {
  const _UploadPhotoView();

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text('profile.title'.tr()),
        leading: const Padding(
          padding: EdgeInsets.only(left: 12),
          child: AppBackButton(),
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<SelectPhotoCubit, SelectPhotoState>(
          listener: (context, state) {
            LoadingWidget.hide();
            if (state is PhotoSelectLoading) {
              LoadingWidget.show(context);
            } else if (state is PhotoSelectFailure) {
              context.showSnackBar(state.message, isError: true);
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Text(
                    'upload_photo.title'.tr(),
                    style: context.textTheme.titleLarge,
                  ),
                  const Gap(8),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: context.width * .2),
                    child: Text(
                      'upload_photo.desc'.tr(),
                      style: context.textTheme.bodyMedium,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Gap(48),
                  GestureDetector(
                    onTap: () => context.read<SelectPhotoCubit>().pickImage(),
                    child: Container(
                      width: 164,
                      height: 164,
                      decoration: BoxDecoration(
                        color: AppColors.darkInputFill,
                        borderRadius: BorderRadius.circular(31),
                        border: Border.all(
                          color: isDarkMode ? AppColors.darkBorder : AppColors.lightBorder,
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: state is PhotoSelected
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(24),
                                child: Image.file(
                                  state.image,
                                  width: 140,
                                  height: 140,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Image.asset(
                                AssetPaths.plusImg,
                                width: 26,
                                height: 26,
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  AppMainButton(
                    context,
                    onPressed: state is PhotoSelected
                        ? () {
                            context.read<AuthBloc>().add(UploadPhotoEvent(photoPath: state.image.path));
                          }
                        : null,
                    text: 'upload_photo.continue'.tr(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
