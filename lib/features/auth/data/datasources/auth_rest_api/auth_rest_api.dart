import 'dart:io';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '/core/app_constant.dart';
import '../../../../../core/model/base_response.dart';
import '../../models/login_response_model.dart';
import '../../models/register_response_model.dart';
import '../../models/profile_response_model.dart';
import '../../models/upload_photo_response_model.dart';

part 'auth_rest_api.g.dart';

@RestApi(baseUrl: AppConstant.authUrl)
abstract class AuthRestApi {
  factory AuthRestApi(Dio dio, {String baseUrl, ParseErrorLogger? errorLogger}) = _AuthRestApi;

  @POST('/login')
  Future<HttpResponse<BaseResponse<LoginResponseModel?>?>> login(
    @Field('email') String email,
    @Field('password') String password,
  );

  @POST('/register')
  Future<HttpResponse<BaseResponse<RegisterResponseModel?>?>> register(
    @Field('email') String email,
    @Field('password') String password,
    @Field('name') String name,
  );

  @GET('/profile')
  Future<HttpResponse<BaseResponse<ProfileResponseModel?>?>> profile(
    @Header('Authorization') String token,
  );

  @POST('/upload_photo')
  Future<HttpResponse<BaseResponse<UploadPhotoResponseModel?>?>> uploadPhoto(
    @Header('Authorization') String token,
    @Part() File file,
  );
}
