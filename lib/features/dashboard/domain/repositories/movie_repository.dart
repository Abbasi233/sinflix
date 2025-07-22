import 'package:dartz/dartz.dart';

import '/core/error/failures.dart';
import '../entities/movie_entity.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<MovieEntity>>> list({int page = 1});
  Future<Either<Failure, List<MovieEntity>>> favorites();
  Future<Either<Failure, bool>> favorite(String movieId);
}
