import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sinflix/core/colors.dart';
import 'package:sinflix/core/entities/session_entity.dart';
import 'package:sinflix/core/extensions.dart';
import 'package:sinflix/core/navigation/app_router.dart';
import 'package:sinflix/core/widgets/cached_circle_avatar_widget.dart';
import 'package:sinflix/features/dashboard/domain/entities/movie_entity.dart';
import 'package:sinflix/features/dashboard/presentation/widgets/favorite_film_item.dart';

mixin ProfilePageMixin {
  Widget buildProfileInfo(BuildContext context, SessionEntity sessionEntity) {
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

  Widget buildNoFavorites(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.favorite_border, size: 64, color: AppColors.accent),
          const SizedBox(height: 16),
          Text(
            'profile.no_favorites'.tr(),
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.textTheme.bodyMedium?.color?.withOpacity(0.7),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget buildFavorites(BuildContext context, List<MovieEntity> favorites) {
    return GridView.builder(
      itemCount: favorites.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.58,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      itemBuilder: (context, index) {
        final movie = favorites[index];
        return FavoriteFilmItem(
          imdbID: movie.imdbID,
          filmName: movie.title,
          studioName: movie.director,
        );
      },
    );
  }
}
