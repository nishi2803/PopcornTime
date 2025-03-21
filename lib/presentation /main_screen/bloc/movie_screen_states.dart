import 'package:popcorn_time/models/movie_list_model.dart';

abstract class MovieState {}

class MovieInitialState extends MovieState {}

class MovieListState extends MovieState {
  final bool isLoadingMovies;
  final bool isLoadingFavorites;
  final bool isFavourite;
  final MovieListModel? movieList;
  final MovieListModel? searchedMovies;
  final String? moviesError;
  final String? favoritesError;

  MovieListState({
    this.isLoadingMovies = false,
    this.isLoadingFavorites = false,
    this.isFavourite = false,
    this.movieList,
    this.searchedMovies,
    this.moviesError,
    this.favoritesError,
  });

  MovieListState copyWith({
    bool? isLoadingMovies,
    bool? isLoadingFavorites,
    MovieListModel? movieList,
    MovieListModel? searchedMovies,
    String? moviesError,
    String? favoritesError,
  }) {
    return MovieListState(
      isLoadingMovies: isLoadingMovies ?? this.isLoadingMovies,
      isLoadingFavorites: isLoadingFavorites ?? this.isLoadingFavorites,
      movieList: movieList ?? this.movieList,
      searchedMovies: searchedMovies ?? this.searchedMovies,
      moviesError: moviesError ?? this.moviesError,
      favoritesError: favoritesError ?? this.favoritesError,
    );
  }
}
