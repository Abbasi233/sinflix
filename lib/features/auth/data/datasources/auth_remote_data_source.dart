import '../models/login_response_model.dart';
import '../models/register_response_model.dart';
import '../models/profile_response_model.dart';
import '../models/upload_photo_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponseModel> login(String email, String password);
  Future<RegisterResponseModel> register(String email, String password, String name);
  Future<ProfileResponseModel> getProfile();
  Future<UploadPhotoResponseModel> uploadPhoto(String photoPath);
}
