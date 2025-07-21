import 'package:dartz/dartz.dart';
import '/core/error/failures.dart';
import '../../domain/entities/movie_entity.dart';
import '../../domain/repositories/movie_repository.dart';
import '../datasource/movie_remote_data_source.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;

  MovieRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<MovieEntity>>> list() async {
    try {
      final response = await remoteDataSource.list();
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
        return const Left(ServerFailure('Veri alınamadı.'));
      }
    } catch (e) {
      return Left(ServerFailure('Sunucu hatası: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> favorites() async {
    try {
      final response = await remoteDataSource.favorites();
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
        return const Left(ServerFailure('Favoriler alınamadı.'));
      }
    } catch (e) {
      return Left(ServerFailure('Sunucu hatası: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, MovieEntity?>> favorite(String movieId) async {
    // try {
    //   final response = await remoteDataSource.favorite(movieId);
    //   if (response != null) {
    //     return Right(MovieEntity(
    //           id: response.id,
    //           title: response.title,
    //           year: response.year,
    //           rated: response.rated,
    //           released: response.released,
    //           runtime: response.runtime,
    //           genre: response.genre,
    //           director: response.director,
    //           writer: response.writer,
    //           actors: response.actors,
    //           plot: response.plot,
    //           language: response.language,
    //           country: response.country,
    //           awards: response.awards,
    //           poster: response.poster,
    //           metascore: response.metascore,
    //           imdbRating: response.imdbRating,
    //           imdbVotes: response.imdbVotes,
    //           imdbID: response.imdbID,
    //           type: response.type,
    //           response: response.response,
    //           images: response.images,
    //           comingSoon: response.comingSoon,
    //           isFavorite: response.isFavorite,
    //         ));
    //     } else {
    //     return const Left(ServerFailure('Favori işlemi başarısız.'));
    //   }
    // } catch (e) {
    //   return Left(ServerFailure('Sunucu hatası: ${e.toString()}'));
    // }
    return const Left(ServerFailure('Favori işlemi başarısız.'));
  }
}
