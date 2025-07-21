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
  const MoviesLoaded(this.movies);
  @override
  List<Object?> get props => [movies];
}

class FavoritesLoaded extends MovieState {
  final List<MovieEntity> favorites;
  const FavoritesLoaded(this.favorites);
  @override
  List<Object?> get props => [favorites];
}

class MovieFavorited extends MovieState {
  final MovieEntity? movie;
  const MovieFavorited(this.movie);
  @override
  List<Object?> get props => [movie];
}

class MovieError extends MovieState {
  final String message;
  const MovieError(this.message);
  @override
  List<Object?> get props => [message];
}
