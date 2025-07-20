import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/entities/register_entity.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/entities/upload_photo_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, LoginEntity>> login(String email, String password) async {
    if (await networkInfo.isConnected) {
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
    } else {
      return const Left(NetworkFailure('İnternet bağlantısı yok'));
    }
  }

  @override
  Future<Either<Failure, RegisterEntity>> register(String email, String password, String name) async {
    if (await networkInfo.isConnected) {
      try {
        final registerResponse = await remoteDataSource.register(email, password, name);
        return Right(
          RegisterEntity(
            id: registerResponse.id,
            message: registerResponse.message,
          ),
        );
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return const Left(NetworkFailure('İnternet bağlantısı yok'));
    }
  }

  @override
  Future<Either<Failure, ProfileEntity>> getProfile() async {
    if (await networkInfo.isConnected) {
      try {
        final profileResponse = await remoteDataSource.getProfile();
        return Right(
          ProfileEntity(
            id: profileResponse.id,
            name: profileResponse.name,
            email: profileResponse.email,
            photoUrl: profileResponse.photoUrl,
          ),
        );
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return const Left(NetworkFailure('İnternet bağlantısı yok'));
    }
  }

  @override
  Future<Either<Failure, UploadPhotoEntity>> uploadPhoto(String photoPath) async {
    if (await networkInfo.isConnected) {
      try {
        final uploadResponse = await remoteDataSource.uploadPhoto(photoPath);
        return Right(
          UploadPhotoEntity(
            photoUrl: uploadResponse.photoUrl,
            message: uploadResponse.message,
          ),
        );
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return const Left(NetworkFailure('İnternet bağlantısı yok'));
    }
  }
}
