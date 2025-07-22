import 'package:sinflix/core/entities/session_entity.dart';

import '/core/data/base_data_source.dart';
import '/features/dashboard/data/models/favorite_response_model.dart';
import '/features/dashboard/data/models/movie_model.dart';
import '../models/movie_response_model.dart';
import 'movie_rest_api/movie_rest_api.dart';
import 'movie_remote_data_source.dart';

class MovieRemoteDataSourceImpl extends BaseDataSource implements MovieRemoteDataSource {
  final MovieRestApi api;
  final SessionEntity sessionEntity;

  MovieRemoteDataSourceImpl({
    required this.api,
    required this.sessionEntity,
  });

  @override
  Future<MoviesResponseModel?> list({int page = 1}) async {
    final response = await handleResponse(() => api.list(sessionEntity.bearerToken, page));

    if (response?.data != null) {
      return response!.data!;
    } else {
      throw Exception('List response is null');
    }
  }

  @override
  Future<List<MovieModel>?> favorites() async {
    final response = await handleResponse(() => api.favorites(sessionEntity.bearerToken));
    return response?.data;
  }

  @override
  Future<FavoriteResponseModel?> favorite(String movieId) async {
    final response = await handleResponse(() => api.favorite(sessionEntity.bearerToken, movieId));

    if (response?.data != null) {
      return response!.data!;
    } else {
      throw Exception('Favorite response is null');
    }
  }
}
