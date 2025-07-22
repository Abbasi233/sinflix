import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '/core/extensions.dart';
import '../../domain/entities/movie_entity.dart';
import '/core/service_locator.dart';
import '../../domain/usecases/get_tmdb_poster_url_usecase.dart';

class MovieListItem extends StatelessWidget {
  final MovieEntity? movie;
  final bool isFavorited;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;

  const MovieListItem({
    super.key,
    this.movie,
    this.isFavorited = false,
    this.onTap,
    this.onFavoriteTap,
  });

  bool get isFavorite => isFavorited || (movie?.isFavorite ?? false);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  width: 80,
                  height: 120,
                  child: movie != null
                      ? FutureBuilder<String?>(
                          future: sl<GetTmdbPosterUrlUseCase>()(movie!.imdbID),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return shimmerBox(width: 80, height: 120);
                            }

                            if (snapshot.hasError) {
                              return Container(
                                color: Colors.grey.shade300,
                                child: const Icon(Icons.movie, size: 40),
                              );
                            }

                            return CachedNetworkImage(
                              imageUrl: snapshot.data!,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => shimmerBox(width: 80, height: 120),
                              errorWidget: (context, url, error) => Container(
                                color: Colors.grey.shade300,
                                child: const Icon(Icons.movie, size: 40),
                              ),
                            );
                          },
                        )
                      : shimmerBox(width: 80, height: 120),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: movie != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie?.title ?? '',
                            style: context.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            movie?.year ?? '',
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            movie?.genre ?? '',
                            style: context.textTheme.bodySmall?.copyWith(
                              color: Colors.grey.shade500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                size: 16,
                                color: Colors.amber.shade600,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                movie?.imdbRating ?? '',
                                style: context.textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          shimmerBox(height: 20),
                          const SizedBox(height: 4),
                          shimmerBox(width: 60, height: 16),
                          const SizedBox(height: 4),
                          shimmerBox(width: 80, height: 14),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                size: 16,
                                color: Colors.amber.shade600,
                              ),
                              const SizedBox(width: 4),
                              shimmerBox(width: 30, height: 14),
                            ],
                          ),
                        ],
                      ),
              ),
              if (onFavoriteTap != null && movie != null)
                IconButton(
                  onPressed: onFavoriteTap,
                  icon: Icon(
                    isFavorite == true ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite == true ? Colors.red : Colors.grey.shade400,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget shimmerBox({double width = double.infinity, double height = 20}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
