import 'dart:ui';
import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import '/core/colors.dart';
import '/core/extensions.dart';
import '/core/asset_paths.dart';
import '../bloc/movie_bloc.dart';
import '/core/service_locator.dart';
import '/core/navigation/app_router.dart';
import '/core/entities/session_entity.dart';
import '/core/widgets/refresh_indicator.dart';
import '../widgets/special_offer_bottom_sheet.dart';
import '/features/auth/presentation/bloc/auth_bloc.dart';
import '/features/dashboard/presentation/mixin/profile_page_mixin.dart';

@RoutePage()
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with ProfilePageMixin {
  final sessionEntity = sl<SessionEntity>();

  @override
  void initState() {
    super.initState();
    context.read<MovieBloc>().add(const FetchFavoritesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Scaffold(
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
                  onPressed: _showLimitedOfferBottomSheet,
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
                context.read<MovieBloc>().add(const FetchFavoritesEvent());
              },
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildProfileInfo(context, sessionEntity),
                    const Gap(29),
                    Text('profile.favorite_movies'.tr(), style: context.textTheme.labelMedium),
                    const Gap(24),
                    BlocBuilder<MovieBloc, MovieState>(
                      buildWhen: (previous, current) {
                        switch (current) {
                          case FavoritesLoading():
                          case FavoritesError():
                          case FavoritesNotFound():
                          case FavoritesLoaded():
                            return true;
                          default:
                            return false;
                        }
                      },
                      builder: (context, state) {
                        if (state is FavoritesLoading) {
                          return GridView.builder(
                            itemCount: 4,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.58,
                              mainAxisSpacing: 16,
                              crossAxisSpacing: 16,
                            ),
                            itemBuilder: (context, index) {
                              return buildFavoriteFilmShimmerItem(context);
                            },
                          );
                        }
                        if (state is FavoritesError) return Center(child: Text(state.message.tr()));
                        if (state is FavoritesNotFound) return buildNoFavorites(context);
                        if (state is FavoritesLoaded) {
                          final favorites = state.favorites;
                          if (favorites.isEmpty) return buildNoFavorites(context);
                          return buildFavorites(context, favorites);
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showLimitedOfferBottomSheet() {
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
  }
}
