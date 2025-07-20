import 'package:json_annotation/json_annotation.dart';

part 'login_response_model.g.dart';

@JsonSerializable(createToJson: false)
class LoginResponseModel {
  final String id;
  final String name;
  final String email;
  final String photoUrl;
  final String token;

  LoginResponseModel({required this.id, required this.name, required this.email, required this.photoUrl, required this.token});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => _$LoginResponseModelFromJson(json);
}
