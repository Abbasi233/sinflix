import '/core/error/failures.dart';
import '/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import '../entities/movie_entity.dart';
import '../repositories/movie_repository.dart';

class GetMoviesUseCase implements UseCase<List<MovieEntity>, NoParams> {
  final MovieRepository repository;

  GetMoviesUseCase(this.repository);

  @override
  Future<Either<Failure, List<MovieEntity>>> call(NoParams params) async {
    return await repository.list();
  }
}
