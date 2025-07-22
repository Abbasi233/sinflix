import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sinflix/features/dashboard/domain/entities/movie_entity.dart';
import 'package:sinflix/features/dashboard/presentation/widgets/movie_list_item.dart';
import 'package:sinflix/features/dashboard/presentation/bloc/movie_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:sinflix/core/navigation/app_router.dart';

mixin HomePageMixin {
  Widget buildMovieShimmer() {
    return ListView.builder(
      itemCount: 5,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => const MovieListItem(),
    );
  }

  Widget buildMovieList(BuildContext context, List<MovieEntity> movies, {String? movieId, bool isFavorited = false}) {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.only(bottom: 16),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return MovieListItem(
          movie: movie,
          isFavorited: movieId == movie.id && isFavorited,
          onTap: (moviePoster) {
            context.router.push(
              MovieDetailRoute(movie: movie, moviePoster: moviePoster ?? ''),
            );
          },
          onFavoriteTap: () {
            context.read<MovieBloc>().add(FavoriteMovieEvent(movie.id));
          },
        );
      },
    );
  }
}
