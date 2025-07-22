import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sinflix/core/error/failures.dart';

import '/features/dashboard/domain/entities/movie_entity.dart';
import '/features/dashboard/domain/repositories/movie_repository.dart';
import '/core/services/logger_service.dart';
import '/core/service_locator.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository movieRepository;

  List<MovieEntity> _movies = [];
  int _currentPage = 1;
  bool _isLoadingMore = false;

  MovieBloc({required this.movieRepository}) : super(MovieInitial()) {
    on<FetchMoviesEvent>(_onFetchMovies);
    on<FetchFavoritesEvent>(_onFetchFavorites);
    on<FavoriteMovieEvent>(_onFavoriteMovie);
    on<LoadMoreMoviesEvent>(_onLoadMoreMovies);
  }

  Future<void> _onFetchMovies(FetchMoviesEvent event, Emitter<MovieState> emit) async {
    emit(MovieLoading());
    _currentPage = event.page;
    final result = await movieRepository.list(page: _currentPage);
    result.fold(
      (failure) {
        sl<LoggerService>().e('FetchMovies error:  ${failure.message}', error: failure);
        emit(MovieError(failure.message));
      },
      (movies) {
        _movies = movies;
        emit(MoviesLoaded(_movies, page: _currentPage));
      },
    );
  }

  Future<void> _onLoadMoreMovies(LoadMoreMoviesEvent event, Emitter<MovieState> emit) async {
    if (_isLoadingMore) return;
    _isLoadingMore = true;
    emit(MoviesLoaded(_movies, page: _currentPage, isLoadingMore: true));
    final nextPage = event.page;
    final result = await movieRepository.list(page: nextPage);
    result.fold(
      (failure) {
        _isLoadingMore = false;
        sl<LoggerService>().e('LoadMoreMovies error:  ${failure.message}', error: failure);
        emit(MovieError(failure.message));
      },
      (movies) {
        if (movies.isNotEmpty) {
          _currentPage = nextPage;
          _movies = List.from(_movies)..addAll(movies);
        }
        _isLoadingMore = false;
        emit(MoviesLoaded(_movies, page: _currentPage));
      },
    );
  }

  Future<void> _onFetchFavorites(FetchFavoritesEvent event, Emitter<MovieState> emit) async {
    emit(FavoritesLoading());
    final result = await movieRepository.favorites();
    result.fold(
      (failure) {
        if (failure is NotFoundFailure) {
          emit(const FavoritesNotFound());
          return;
        }
        sl<LoggerService>().e('FetchFavorites error:  ${failure.message}', error: failure);
        emit(MovieError(failure.message));
      },
      (movies) => emit(FavoritesLoaded(movies)),
    );
  }

  Future<void> _onFavoriteMovie(FavoriteMovieEvent event, Emitter<MovieState> emit) async {
    final result = await movieRepository.favorite(event.movieId);
    result.fold(
      (failure) {
        sl<LoggerService>().e('FavoriteMovie error:  ${failure.message}', error: failure);
        emit(MovieError(failure.message));
      },
      (isFavorited) {
        if (isFavorited) {
          _movies.firstWhere((movie) => movie.id == event.movieId).isFavorite = true;
        } else {
          _movies.firstWhere((movie) => movie.id == event.movieId).isFavorite = false;
        }
        emit(MovieFavorited(_movies, event.movieId, isFavorited));
      },
    );
  }
}
