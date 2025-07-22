import 'dart:convert';
import 'package:http/http.dart' as http;
import 'tmdb_remote_data_source.dart';

class TmdbRemoteDataSourceImpl implements TmdbRemoteDataSource {
  final String apiKey;

  TmdbRemoteDataSourceImpl({required this.apiKey});

  @override
  Future<String?> getPosterUrlFromImdbId(String imdbId) async {
    final url = Uri.parse(
      'https://api.themoviedb.org/3/find/$imdbId?api_key=$apiKey&external_source=imdb_id',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      String? posterPath;
      final data = json.decode(response.body);
      if (data['movie_results'] != null && data['movie_results'].isNotEmpty) {
        posterPath = data['movie_results'][0]['poster_path'];
      } else if (data['tv_results'] != null && data['tv_results'].isNotEmpty) {
        posterPath = data['tv_results'][0]['poster_path'];
      } else if (data['person_results'] != null && data['person_results'].isNotEmpty) {
        posterPath = data['person_results'][0]['poster_path'];
      }

      if (posterPath != null) {
        return 'https://image.tmdb.org/t/p/w500$posterPath';
      }
    }
    return null;
  }
}
