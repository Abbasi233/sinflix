import 'package:json_annotation/json_annotation.dart';
import 'package:sinflix/core/model/pagination_model.dart';
import 'package:sinflix/features/dashboard/data/models/movie_model.dart';

part 'movie_response_model.g.dart';

@JsonSerializable(createToJson: false)
class MoviesResponseModel {
  final List<MovieModel> movies;
  final PaginationModel pagination;

  MoviesResponseModel({
    required this.movies,
    required this.pagination,
  });

  factory MoviesResponseModel.fromJson(Map<String, dynamic> json) => _$MoviesResponseModelFromJson(json);
}
