
abstract class MovieEvent {}


class FetchMoviesEvent extends MovieEvent {
  int page;
  FetchMoviesEvent(this.page);
}

class MarkFavoriteEvent extends MovieEvent {
  final int movieId;
  MarkFavoriteEvent(this.movieId);
}

class RemoveFavoriteEvent extends MovieEvent {
  final int movieId;
  RemoveFavoriteEvent(this.movieId);
}

class SearchMoviesEvent extends MovieEvent {
  final String query;
  SearchMoviesEvent(this.query);
}
