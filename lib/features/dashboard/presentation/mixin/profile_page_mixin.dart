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
import 'package:shimmer/shimmer.dart';

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

  Widget buildProfileShimmer(BuildContext context) {
    return Row(
      spacing: 10,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Profil resmi shimmer
        ClipOval(
          child: Shimmer.fromColors(
            baseColor: Colors.grey[400]!,
            highlightColor: Colors.grey[100]!,
            period: const Duration(milliseconds: 800),
            child: Container(width: 62, height: 62, color: Colors.white),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // İsim shimmer
              Shimmer.fromColors(
                baseColor: Colors.grey[400]!,
                highlightColor: Colors.grey[100]!,
                period: const Duration(milliseconds: 800),
                child: Container(width: 100, height: 18, color: Colors.white, margin: const EdgeInsets.only(bottom: 8)),
              ),
              // ID shimmer
              Shimmer.fromColors(
                baseColor: Colors.grey[400]!,
                highlightColor: Colors.grey[100]!,
                period: const Duration(milliseconds: 800),
                child: Container(width: 60, height: 14, color: Colors.white),
              ),
            ],
          ),
        ),
        // Buton shimmer
        Shimmer.fromColors(
          baseColor: Colors.grey[400]!,
          highlightColor: Colors.grey[100]!,
          period: const Duration(milliseconds: 800),
          child: Container(
            width: 80,
            height: 32,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget buildFavoriteFilmShimmerItem(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(height: 16, color: Colors.white, margin: const EdgeInsets.only(bottom: 4)),
        ),
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(height: 12, color: Colors.white),
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
          onTap: (moviePoster) {
            context.router.push(MovieDetailRoute(movie: movie, moviePoster: moviePoster ?? ''));
          },
        );
      },
    );
  }
}
