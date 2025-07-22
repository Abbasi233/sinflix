import '/features/dashboard/data/models/movie_model.dart';
import '/features/dashboard/data/models/movie_response_model.dart';
import '/features/dashboard/data/models/favorite_response_model.dart';

abstract class MovieRemoteDataSource {
  Future<MoviesResponseModel?> list({int page = 1});
  Future<FavoriteResponseModel?> favorite(String movieId);
  Future<List<MovieModel>?> favorites();
}
