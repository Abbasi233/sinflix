import 'package:json_annotation/json_annotation.dart';

part 'upload_photo_response_model.g.dart';

@JsonSerializable(createToJson: false)
class UploadPhotoResponseModel {
  final String photoUrl;
  final String message;

  UploadPhotoResponseModel({required this.photoUrl, required this.message});

  factory UploadPhotoResponseModel.fromJson(Map<String, dynamic> json) => _$UploadPhotoResponseModelFromJson(json);
}
