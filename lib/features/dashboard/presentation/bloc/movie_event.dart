part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();
  @override
  List<Object?> get props => [];
}

class FetchMoviesEvent extends MovieEvent {
  final int page;
  const FetchMoviesEvent({this.page = 1});
  @override
  List<Object?> get props => [page];
}

class LoadMoreMoviesEvent extends MovieEvent {
  final int page;
  const LoadMoreMoviesEvent(this.page);
  @override
  List<Object?> get props => [page];
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
