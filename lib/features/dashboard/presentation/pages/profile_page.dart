import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sinflix/core/widgets/loading_widget.dart';
import 'package:sinflix/core/widgets/refresh_indicator.dart';

import '/core/asset_paths.dart';
import '/core/colors.dart';
import '/core/extensions.dart';
import '/core/service_locator.dart';
import '/core/navigation/app_router.dart';
import '/core/entities/session_entity.dart';
import '/core/widgets/cached_circle_avatar_widget.dart';
import '/features/auth/presentation/bloc/auth_bloc.dart';
import '../widgets/favorite_film_item.dart';
import '/features/theme/presentation/bloc/theme_cubit.dart';
import '../widgets/special_offer_bottom_sheet.dart';
import 'dart:ui';

@RoutePage()
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final sessionEntity = sl<SessionEntity>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          LoadingWidget.show(context);
        } else if (state is ProfileLoaded) {
          LoadingWidget.hide();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('profile.title'.tr()),
          leading: IconButton(
            onPressed: () {
              context.router.push(const SettingsRoute());
            },
            icon: const Icon(Icons.settings),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ElevatedButton(
                onPressed: () {
                  showGeneralDialog(
                    context: context,
                    barrierColor: Colors.black.withValues(alpha: 0.3),
                    transitionDuration: const Duration(milliseconds: 200),
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return Stack(
                        children: [
                          GestureDetector(
                            onTap: () => context.router.maybePop(),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                              child: Container(color: Colors.black.withValues(alpha: 0.3)),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: DraggableScrollableSheet(
                              initialChildSize: 0.75,
                              minChildSize: 0.1,
                              maxChildSize: 0.75,
                              expand: true,
                              shouldCloseOnMinExtent: true,
                              builder: (context, scrollController) {
                                return NotificationListener<DraggableScrollableNotification>(
                                  onNotification: (notification) {
                                    if (notification.extent <= notification.minExtent && notification.shouldCloseOnMinExtent) {
                                      context.router.pop();
                                      return true;
                                    }
                                    return false;
                                  },
                                  child: SpecialOfferBottomSheet(scrollController: scrollController),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    },
                    transitionBuilder: (context, animation, secondaryAnimation, child) {
                      return Transform.translate(
                        offset: Offset(0, 60 * (1 - animation.value)),
                        child: Opacity(
                          opacity: animation.value,
                          child: child,
                        ),
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(53),
                  ),
                ),
                child: Row(
                  spacing: 4,
                  children: [
                    Image.asset(AssetPaths.diamondImg, width: 14, height: 14),
                    Text("profile.limited_offer".tr()),
                  ],
                ),
              ),
            ),
            const Gap(16),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 16),
          child: AppRefreshIndicator(
            onRefresh: () async {
              context.read<AuthBloc>().add(const GetProfileEvent());
            },
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProfileInfo(),
                  const Gap(29),
                  Text('profile.favorite_movies'.tr(), style: context.textTheme.labelMedium),
                  const Gap(24),
                  GridView.builder(
                    itemCount: 10,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.58,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                    ),
                    itemBuilder: (context, index) => FavoriteFilmItem(
                      imageUrl: 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=400&q=80',
                      filmName: 'Film $index',
                      studioName: 'Studio $index',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileInfo() {
    return Row(
      spacing: 10,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CachedCircleAvatar(imageUrl: sessionEntity.photoUrl, radius: 31),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(sessionEntity.name ?? '~', style: context.textTheme.titleMedium),
              Text(
                "ID: ${sessionEntity.id?.substring(0, 6)}",
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.textTheme.bodySmall?.color?.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.accent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () {
            context.router.push(const UploadPhotoRoute());
          },
          child: Text('profile.add_photo'.tr()),
        ),
      ],
    );
  }
}
