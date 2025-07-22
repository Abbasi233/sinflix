import 'package:dartz/dartz.dart';
import 'package:sinflix/features/dashboard/data/models/favorite_response_model.dart';
import '/core/error/failures.dart';
import '../../domain/entities/movie_entity.dart';
import '../../domain/repositories/movie_repository.dart';
import '../datasource/movie_remote_data_source.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;

  MovieRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<MovieEntity>>> list({int page = 1}) async {
    try {
      final response = await remoteDataSource.list(page: page);
      if (response != null) {
        final entities = response.movies
            .map(
              (e) => MovieEntity(
                id: e.id,
                title: e.title,
                year: e.year,
                rated: e.rated,
                released: e.released,
                runtime: e.runtime,
                genre: e.genre,
                director: e.director,
                writer: e.writer,
                actors: e.actors,
                plot: e.plot,
                language: e.language,
                country: e.country,
                awards: e.awards,
                poster: e.poster,
                metascore: e.metascore,
                imdbRating: e.imdbRating,
                imdbVotes: e.imdbVotes,
                imdbID: e.imdbID,
                type: e.type,
                response: e.response,
                images: e.images,
                comingSoon: e.comingSoon,
                isFavorite: e.isFavorite,
              ),
            )
            .toList();
        return Right(entities);
      } else {
        return const Left(NotFoundFailure('error.not_found_error_message'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> favorites() async {
    try {
      final response = await remoteDataSource.favorites();
      if (response != null) {
        final entities = response
            .map(
              (e) => MovieEntity(
                id: e.id,
                title: e.title,
                year: e.year,
                rated: e.rated,
                released: e.released,
                runtime: e.runtime,
                genre: e.genre,
                director: e.director,
                writer: e.writer,
                actors: e.actors,
                plot: e.plot,
                language: e.language,
                country: e.country,
                awards: e.awards,
                poster: e.poster,
                metascore: e.metascore,
                imdbRating: e.imdbRating,
                imdbVotes: e.imdbVotes,
                imdbID: e.imdbID,
                type: e.type,
                response: e.response,
                images: e.images,
                comingSoon: e.comingSoon,
                isFavorite: e.isFavorite,
              ),
            )
            .toList();
        return Right(entities);
      } else {
        return const Left(NotFoundFailure('error.not_found_error_message'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> favorite(String movieId) async {
    try {
      final response = await remoteDataSource.favorite(movieId);
      if (response != null) {
        return Right(response.action == ActionType.favorited);
      } else {
        return const Left(NotFoundFailure('error.not_found_error_message'));
      }
    } catch (e) {
      return Left(ServerFailure('Sunucu hatası: ${e.toString()}'));
    }
  }
}
