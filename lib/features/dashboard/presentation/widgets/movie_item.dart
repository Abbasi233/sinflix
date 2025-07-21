import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

import '../../domain/entities/movie_entity.dart';
import '/core/extensions.dart';

class MovieItem extends StatelessWidget {
  final MovieEntity movie;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;

  const MovieItem({
    super.key,
    required this.movie,
    this.onTap,
    this.onFavoriteTap,
  });

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
                  child: CachedNetworkImage(
                    imageUrl: movie.poster,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        color: Colors.white,
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.movie, size: 40),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      movie.year,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      movie.genre,
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
                          movie.imdbRating,
                          style: context.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (onFavoriteTap != null)
                IconButton(
                  onPressed: onFavoriteTap,
                  icon: Icon(
                    movie.isFavorite == true ? Icons.favorite : Icons.favorite_border,
                    color: movie.isFavorite == true ? Colors.red : Colors.grey.shade400,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
