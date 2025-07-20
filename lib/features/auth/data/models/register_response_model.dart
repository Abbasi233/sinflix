import 'package:json_annotation/json_annotation.dart';

part 'register_response_model.g.dart';

@JsonSerializable(createToJson: false)
class RegisterResponseModel {
  final String id;
  final String message;

  RegisterResponseModel({required this.id, required this.message});

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) => _$RegisterResponseModelFromJson(json);
}
