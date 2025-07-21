import 'package:sinflix/core/entities/session_entity.dart';

import '/core/data/base_data_source.dart';
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
  Future<MoviesResponseModel?> list() async {
    final response = await handleResponse(() => api.list(sessionEntity.bearerToken));

    if (response?.data != null) {
      return response!.data!;
    } else {
      throw Exception('List response is null');
    }
  }

  @override
  Future<MoviesResponseModel?> favorites() async {
    final response = await handleResponse(() => api.favorites(sessionEntity.bearerToken));

    if (response?.data != null) {
      return response!.data!;
    } else {
      throw Exception('Favorites response is null');
    }
  }

  @override
  Future<MoviesResponseModel?> favorite(String movieId) async {
    final response = await handleResponse(() => api.favorite(sessionEntity.bearerToken, movieId));

    if (response?.data != null) {
      return response!.data!;
    } else {
      throw Exception('Favorite response is null');
    }
  }
}
