import 'package:equatable/equatable.dart';

class UploadPhotoEntity extends Equatable {
  final String photoUrl;

  const UploadPhotoEntity({
    required this.photoUrl,
  });

  @override
  List<Object?> get props => [photoUrl];
}
