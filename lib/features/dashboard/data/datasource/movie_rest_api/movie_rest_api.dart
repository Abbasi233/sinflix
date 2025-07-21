import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '/core/app_constant.dart';
import '/core/model/base_response.dart';
import '/features/dashboard/data/models/movie_response_model.dart';

part 'movie_rest_api.g.dart';

@RestApi(baseUrl: AppConstant.movieUrl)
abstract class MovieRestApi {
  factory MovieRestApi(Dio dio, {String baseUrl, ParseErrorLogger? errorLogger}) = _MovieRestApi;

  @GET('/list')
  Future<HttpResponse<BaseResponse<MoviesResponseModel?>?>> list(
    @Header('Authorization') String token,
  );

  @GET('/favorites')
  Future<HttpResponse<BaseResponse<MoviesResponseModel?>?>> favorites(
    @Header('Authorization') String token,
  );

  @POST('/favorite/{movieId}')
  Future<HttpResponse<BaseResponse<MoviesResponseModel?>?>> favorite(
    @Header('Authorization') String token,
    @Path() String movieId,
  );
}
