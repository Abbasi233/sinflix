import 'package:equatable/equatable.dart';

class UploadPhotoEntity extends Equatable {
  final String id;
  final String name;
  final String email;
  final String photoUrl;

  const UploadPhotoEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.photoUrl,
  });

  @override
  List<Object?> get props => [photoUrl];
}
