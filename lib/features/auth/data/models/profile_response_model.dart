import 'package:json_annotation/json_annotation.dart';

part 'profile_response_model.g.dart';

@JsonSerializable(createToJson: false)
class ProfileResponseModel {
  final String id;
  final String name;
  final String email;
  final String photoUrl;
  final String token;

  ProfileResponseModel({
    required this.id,
    required this.name,
    required this.email,
    required this.photoUrl,
    required this.token,
  });

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json) => _$ProfileResponseModelFromJson(json);
}
