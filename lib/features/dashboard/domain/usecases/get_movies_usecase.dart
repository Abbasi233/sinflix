import '/core/error/failures.dart';
import '/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import '../entities/movie_entity.dart';
import '../repositories/movie_repository.dart';

class GetMoviesParams {
  final int page;
  const GetMoviesParams({this.page = 1});
}

class GetMoviesUseCase implements UseCase<List<MovieEntity>, GetMoviesParams> {
  final MovieRepository repository;

  GetMoviesUseCase(this.repository);

  @override
  Future<Either<Failure, List<MovieEntity>>> call(GetMoviesParams params) async {
    return await repository.list(page: params.page);
  }
}
