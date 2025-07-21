import '/core/error/failures.dart';
import '/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import '../entities/movie_entity.dart';
import '../repositories/movie_repository.dart';

class FavoriteMovieUseCase implements UseCase<MovieEntity?, String> {
  final MovieRepository repository;

  FavoriteMovieUseCase(this.repository);

  @override
  Future<Either<Failure, MovieEntity?>> call(String movieId) async {
    return await repository.favorite(movieId);
  }
}
