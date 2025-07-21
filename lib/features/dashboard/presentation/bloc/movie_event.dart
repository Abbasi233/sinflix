part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();
  @override
  List<Object?> get props => [];
}

class FetchMoviesEvent extends MovieEvent {
  const FetchMoviesEvent();
  @override
  List<Object?> get props => [];
}

class FetchFavoritesEvent extends MovieEvent {
  const FetchFavoritesEvent();
  @override
  List<Object?> get props => [];
}

class FavoriteMovieEvent extends MovieEvent {
  final String movieId;
  const FavoriteMovieEvent(this.movieId);
  @override
  List<Object?> get props => [movieId];
}
