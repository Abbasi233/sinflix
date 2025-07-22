import '/core/error/failures.dart';
import '/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import '../repositories/movie_repository.dart';

class FavoriteMovieUseCase implements UseCase<bool, String> {
  final MovieRepository repository;

  FavoriteMovieUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(String movieId) async {
    return await repository.favorite(movieId);
  }
}
