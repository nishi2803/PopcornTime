import 'package:json_annotation/json_annotation.dart';
part 'movie_list_model.g.dart';


@JsonSerializable()
class Movie {
  final bool adult;
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath; // Nullable
  @JsonKey(name: 'genre_ids')
  final List<int>? genreIds; // Nullable
  final int id;
  @JsonKey(name: 'original_language')
  final String? originalLanguage; // Nullable
  @JsonKey(name: 'original_title')
  final String? originalTitle; // Nullable
  final String? overview; // Nullable
  final double? popularity; // Nullable
  @JsonKey(name: 'poster_path')
  final String? posterPath; // Nullable
  @JsonKey(name: 'release_date')
  final String? releaseDate; // Nullable
  final String? title; // Nullable
  final bool video;
  @JsonKey(name: 'vote_average')
  final double? voteAverage; // Nullable
  @JsonKey(name: 'vote_count')
  final int? voteCount; // Nullable

  Movie({
    required this.adult,
    this.backdropPath,
    this.genreIds,
    required this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    required this.video,
    this.voteAverage,
    this.voteCount,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
  Map<String, dynamic> toJson() => _$MovieToJson(this);
}

@JsonSerializable()
class MovieListModel {
  final int page;
  final List<Movie> results;
  @JsonKey(name: 'total_pages')
  final int totalPages;
  @JsonKey(name: 'total_results')
  final int totalResults;


  MovieListModel({required this.page, required this.results, required this.totalPages, required this.totalResults});

  factory MovieListModel.fromJson(Map<String, dynamic> json) => _$MovieListModelFromJson(json);
  Map<String, dynamic> toJson() => _$MovieListModelToJson(this);
}


