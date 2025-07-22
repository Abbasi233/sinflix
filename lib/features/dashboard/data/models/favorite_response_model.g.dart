// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteResponseModel _$FavoriteResponseModelFromJson(
  Map<String, dynamic> json,
) => FavoriteResponseModel(
  movie: MovieModel.fromJson(json['movie'] as Map<String, dynamic>),
  action: $enumDecode(_$ActionTypeEnumMap, json['action']),
);

const _$ActionTypeEnumMap = {
  ActionType.favorited: 'favorited',
  ActionType.unfavorited: 'unfavorited',
};
