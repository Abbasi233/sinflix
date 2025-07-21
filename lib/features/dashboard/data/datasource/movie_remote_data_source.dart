import '../models/movie_response_model.dart';

abstract class MovieRemoteDataSource {
  Future<MoviesResponseModel?> list();
  Future<MoviesResponseModel?> favorites();
  Future<MoviesResponseModel?> favorite(String movieId);
}
