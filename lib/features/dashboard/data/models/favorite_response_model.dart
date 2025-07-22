import 'package:json_annotation/json_annotation.dart';

import '/features/dashboard/data/models/movie_model.dart';

part 'favorite_response_model.g.dart';

@JsonSerializable(createToJson: false, explicitToJson: true)
class FavoriteResponseModel {
  final MovieModel movie;
  final ActionType action;

  FavoriteResponseModel({
    required this.movie,
    required this.action,
  });

  factory FavoriteResponseModel.fromJson(Map<String, dynamic> json) => _$FavoriteResponseModelFromJson(json);
}

enum ActionType { favorited, unfavorited }
