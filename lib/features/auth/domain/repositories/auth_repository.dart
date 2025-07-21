import 'package:dartz/dartz.dart';

import '/core/error/failures.dart';
import '../entities/login_entity.dart';
import '../entities/register_entity.dart';
import '../entities/profile_entity.dart';
import '../entities/upload_photo_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, LoginEntity>> login(String email, String password);
  Future<Either<Failure, RegisterEntity>> register(String email, String password, String name);
  Future<Either<Failure, ProfileEntity>> getProfile();
  Future<Either<Failure, UploadPhotoEntity>> uploadPhoto(String photoPath);
}
