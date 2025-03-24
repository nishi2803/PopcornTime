import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:popcorn_time/hive/hive_service.dart';
import 'package:popcorn_time/models/movie_list_model.dart';
import 'package:popcorn_time/presentation%20/main_screen/bloc/movie_screen_events.dart';
import 'package:popcorn_time/presentation%20/main_screen/bloc/movie_screen_states.dart';
import 'package:popcorn_time/service/api_service.dart';

class MovieBloc extends Bloc<MovieEvent, MovieListState> {
  HiveService hiveService = HiveService();

  MovieBloc() : super(MovieListState()) {
    on<FetchMoviesEvent>(_fetchMovies);
    on<MarkFavoriteEvent>(_markFavorite);
    on<RemoveFavoriteEvent>(_removeFavorite);
    on<SearchMoviesEvent>(_searchMovies);
  }

  void _fetchMovies(
      FetchMoviesEvent event, Emitter<MovieListState> emit) async {
    emit(MovieListState(isLoadingMovies: true));

    try {
      MovieListModel movies = await ApiService().fetchMoviesList(event.page);
      emit(MovieListState(isLoadingMovies: false, movieList: movies));
    } catch (e) {
      emit(MovieListState(
          isLoadingMovies: false,
          error: e.toString()));
    }
  }

  void _markFavorite(MarkFavoriteEvent event, Emitter<MovieListState> emit) {
    hiveService.addFavorite(event.movieId);
  }

  void _removeFavorite(
      RemoveFavoriteEvent event, Emitter<MovieListState> emit) {
    hiveService.removeFavorite(event.movieId);
  }

  void _searchMovies(
      SearchMoviesEvent event, Emitter<MovieListState> emit) async {
    emit(MovieListState(isLoadingMovies: true));

    try {
      MovieListModel filteredMovies =
          await ApiService().searchMovies(event.query);
      emit(MovieListState(movieList: filteredMovies, isLoadingMovies: false));
    } catch (e) {
      emit(MovieListState(
          isLoadingMovies: false,
          error: e.toString()));
    }
  }
}
