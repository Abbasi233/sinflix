import '../../data/datasource/tmdb_remote_data_source.dart';

class GetTmdbPosterUrlUseCase {
  final TmdbRemoteDataSource dataSource;

  GetTmdbPosterUrlUseCase(this.dataSource);

  Future<String?> call(String imdbId) {
    return dataSource.getPosterUrlFromImdbId(imdbId);
  }
}
