import 'package:dartz/dartz.dart';

import '/core/error/failures.dart';
import '/core/usecases/usecase.dart';
import '../entities/upload_photo_entity.dart';
import '../repositories/auth_repository.dart';

class UploadPhotoUseCase implements UseCase<UploadPhotoEntity, UploadPhotoParams> {
  final AuthRepository repository;

  UploadPhotoUseCase(this.repository);

  @override
  Future<Either<Failure, UploadPhotoEntity>> call(UploadPhotoParams params) async {
    return await repository.uploadPhoto(params.photoPath);
  }
}

class UploadPhotoParams {
  final String photoPath;

  UploadPhotoParams({required this.photoPath});
}
