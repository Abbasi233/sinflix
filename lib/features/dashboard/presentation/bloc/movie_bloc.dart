import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sinflix/features/dashboard/domain/entities/movie_entity.dart';
import 'package:sinflix/features/dashboard/domain/repositories/movie_repository.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository movieRepository;

  MovieBloc({required this.movieRepository}) : super(MovieInitial()) {
    on<FetchMoviesEvent>(_onFetchMovies);
    on<FetchFavoritesEvent>(_onFetchFavorites);
    on<FavoriteMovieEvent>(_onFavoriteMovie);
  }

  Future<void> _onFetchMovies(FetchMoviesEvent event, Emitter<MovieState> emit) async {
    emit(MovieLoading());
    final result = await movieRepository.list();
    result.fold(
      (failure) => emit(MovieError(failure.message)),
      (movies) => emit(MoviesLoaded(movies)),
    );
  }

  Future<void> _onFetchFavorites(FetchFavoritesEvent event, Emitter<MovieState> emit) async {
    emit(MovieLoading());
    final result = await movieRepository.favorites();
    result.fold(
      (failure) => emit(MovieError(failure.message)),
      (movies) => emit(FavoritesLoaded(movies)),
    );
  }

  Future<void> _onFavoriteMovie(FavoriteMovieEvent event, Emitter<MovieState> emit) async {
    emit(MovieLoading());
    final result = await movieRepository.favorite(event.movieId);
    result.fold(
      (failure) => emit(MovieError(failure.message)),
      (movie) => emit(MovieFavorited(movie)),
    );
  }
}
