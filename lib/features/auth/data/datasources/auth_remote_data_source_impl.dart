import 'dart:io';
import 'package:dio/dio.dart';

import '/core/error/failures.dart';
import '../models/login_response_model.dart';
import '../models/register_response_model.dart';
import '../models/profile_response_model.dart';
import '../models/upload_photo_response_model.dart';
import 'auth_remote_data_source.dart';
import 'auth_rest_api/auth_rest_api.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final AuthRestApi authRestApi;

  AuthRemoteDataSourceImpl({required this.authRestApi});

  @override
  Future<LoginResponseModel> login(String email, String password) async {
    try {
      final response = await authRestApi.login(email, password);

      if (response.data?.body != null) {
        return response.data!.body!;
      } else {
        throw Exception('Login response is null');
      }
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? 'Login failed');
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<RegisterResponseModel> register(String email, String password, String name) async {
    try {
      final response = await authRestApi.register(email, password, name);

      if (response.data?.body != null) {
        return response.data!.body!;
      } else {
        throw Exception('Register response is null');
      }
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? 'Register failed');
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<ProfileResponseModel> getProfile() async {
    try {
      final response = await authRestApi.profile();

      if (response.data?.body != null) {
        return response.data!.body!;
      } else {
        throw Exception('Profile response is null');
      }
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? 'Get profile failed');
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<UploadPhotoResponseModel> uploadPhoto(String photoPath) async {
    try {
      final file = File(photoPath);
      final response = await authRestApi.uploadPhoto(file);

      if (response.data?.body != null) {
        return response.data!.body!;
      } else {
        throw Exception('Upload photo response is null');
      }
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? 'Upload photo failed');
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}
