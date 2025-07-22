import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '/core/extensions.dart';
import '/core/service_locator.dart';
import '../../domain/usecases/get_tmdb_poster_url_usecase.dart';

class FavoriteFilmItem extends StatelessWidget {
  final String filmName;
  final String studioName;
  final String imdbID;

  const FavoriteFilmItem({
    super.key,
    required this.filmName,
    required this.studioName,
    required this.imdbID,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: FutureBuilder<String?>(
              future: sl<GetTmdbPosterUrlUseCase>()(imdbID),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(color: Colors.white),
                  );
                }
                if (snapshot.hasError || snapshot.data == null) {
                  return Container(
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.movie, size: 40),
                  );
                }
                return CachedNetworkImage(
                  imageUrl: snapshot.data!,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(color: Colors.white),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.movie, size: 40),
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          filmName,
          style: context.textTheme.titleSmall,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Text(
          studioName,
          style: context.textTheme.bodySmall,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
