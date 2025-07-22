part of 'movie_bloc.dart';

abstract class MovieState extends Equatable {
  const MovieState();
  @override
  List<Object?> get props => [];
}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MoviesLoaded extends MovieState {
  final List<MovieEntity> movies;
  final int page;
  final bool isLoadingMore;
  const MoviesLoaded(this.movies, {this.page = 1, this.isLoadingMore = false});
  @override
  List<Object?> get props => [movies, page, isLoadingMore];
}

class MovieError extends MovieState {
  final String message;
  const MovieError(this.message);
  @override
  List<Object?> get props => [message];
}

class FavoritesLoading extends MovieState {}

class FavoritesLoaded extends MovieState {
  final List<MovieEntity> favorites;
  const FavoritesLoaded(this.favorites);
  @override
  List<Object?> get props => [favorites];
}

class MovieFavorited extends MovieState {
  final List<MovieEntity> movies;
  final String movieId;
  final bool isFavorited;
  const MovieFavorited(this.movies, this.movieId, this.isFavorited);
  @override
  List<Object?> get props => [movies, movieId, isFavorited];
}

class FavoritesNotFound extends MovieState {
  const FavoritesNotFound();
  @override
  List<Object?> get props => [];
}

class FavoritesError extends MovieState {
  final String message;
  const FavoritesError(this.message);
  @override
  List<Object?> get props => [message];
}
