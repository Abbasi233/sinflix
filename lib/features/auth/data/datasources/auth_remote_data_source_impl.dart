import 'dart:io';

import '/core/data/base_data_source.dart';
import '../models/login_response_model.dart';
import '../models/register_response_model.dart';
import '../models/profile_response_model.dart';
import '../models/upload_photo_response_model.dart';
import 'auth_remote_data_source.dart';
import 'auth_rest_api/auth_rest_api.dart';

class AuthRemoteDataSourceImpl extends BaseDataSource implements AuthRemoteDataSource {
  final AuthRestApi authRestApi;

  AuthRemoteDataSourceImpl({required this.authRestApi});

  @override
  Future<LoginResponseModel> login(String email, String password) async {
    final response = await handleResponse(() => authRestApi.login(email, password));

    if (response?.data != null) {
      return response!.data!;
    } else {
      throw Exception('Login response is null');
    }
  }

  @override
  Future<RegisterResponseModel> register(String email, String password, String name) async {
    final response = await handleResponse(() => authRestApi.register(email, password, name));

    if (response?.data != null) {
      return response!.data!;
    } else {
      throw Exception('Register response is null');
    }
  }

  @override
  Future<ProfileResponseModel> getProfile() async {
    final response = await handleResponse(() => authRestApi.profile());

    if (response?.data != null) {
      return response!.data!;
    } else {
      throw Exception('Profile response is null');
    }
  }

  @override
  Future<UploadPhotoResponseModel> uploadPhoto(String photoPath) async {
    final file = File(photoPath);
    final response = await handleResponse(() => authRestApi.uploadPhoto(file));

    if (response?.data != null) {
      return response!.data!;
    } else {
      throw Exception('Upload photo response is null');
    }
  }
}
