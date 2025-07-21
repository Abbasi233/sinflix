import 'package:dartz/dartz.dart';

import '/core/error/failures.dart';
import '../entities/movie_entity.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<MovieEntity>>> list();
  Future<Either<Failure, List<MovieEntity>>> favorites();
  Future<Either<Failure, MovieEntity?>> favorite(String movieId);
}
