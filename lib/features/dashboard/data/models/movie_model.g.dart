// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieModel _$MovieModelFromJson(Map<String, dynamic> json) => MovieModel(
  id: json['id'] as String,
  title: json['Title'] as String,
  year: json['Year'] as String,
  rated: json['Rated'] as String,
  released: json['Released'] as String,
  runtime: json['Runtime'] as String,
  genre: json['Genre'] as String,
  director: json['Director'] as String,
  writer: json['Writer'] as String,
  actors: json['Actors'] as String,
  plot: json['Plot'] as String,
  language: json['Language'] as String,
  country: json['Country'] as String,
  awards: json['Awards'] as String,
  poster: json['Poster'] as String,
  metascore: json['Metascore'] as String,
  imdbRating: json['imdbRating'] as String,
  imdbVotes: json['imdbVotes'] as String,
  imdbID: json['imdbID'] as String,
  type: json['Type'] as String,
  response: json['Response'] as String,
  images: (json['Images'] as List<dynamic>?)?.map((e) => e as String).toList(),
  comingSoon: json['ComingSoon'] as bool?,
  isFavorite: json['isFavorite'] as bool?,
);
