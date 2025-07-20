import 'package:equatable/equatable.dart';

class UploadPhotoEntity extends Equatable {
  final String photoUrl;
  final String message;

  const UploadPhotoEntity({
    required this.photoUrl,
    required this.message,
  });

  @override
  List<Object?> get props => [photoUrl, message];
}
