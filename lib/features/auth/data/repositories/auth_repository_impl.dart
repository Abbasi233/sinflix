import 'package:dartz/dartz.dart';

import '/core/error/failures.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/entities/register_entity.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/entities/upload_photo_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, LoginEntity>> login(String email, String password) async {
    try {
      final loginResponse = await remoteDataSource.login(email, password);
      return Right(
        LoginEntity(
          id: loginResponse.id,
          name: loginResponse.name,
          email: loginResponse.email,
          photoUrl: loginResponse.photoUrl,
          token: loginResponse.token,
        ),
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, RegisterEntity>> register(String email, String password, String name) async {
    try {
      final registerResponse = await remoteDataSource.register(email, password, name);
      return Right(
        RegisterEntity(
          id: registerResponse.id,
          name: registerResponse.name,
          email: registerResponse.email,
          photoUrl: registerResponse.photoUrl,
          token: registerResponse.token,
        ),
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProfileEntity>> getProfile() async {
    try {
      final profileResponse = await remoteDataSource.getProfile();
      return Right(
        ProfileEntity(
          id: profileResponse.id,
          name: profileResponse.name,
          email: profileResponse.email,
          photoUrl: profileResponse.photoUrl,
          token: profileResponse.token,
        ),
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UploadPhotoEntity>> uploadPhoto(String photoPath) async {
    try {
      final uploadResponse = await remoteDataSource.uploadPhoto(photoPath);
      return Right(
        UploadPhotoEntity(
          id: uploadResponse.id,
          name: uploadResponse.name,
          email: uploadResponse.email,
          photoUrl: uploadResponse.photoUrl,
        ),
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
