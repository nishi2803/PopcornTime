import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popcorn_time/hive/hive_service.dart';
import 'package:popcorn_time/presentation%20/main_screen/bloc/movie_screen_bloc.dart';
import 'package:popcorn_time/presentation%20/main_screen/bloc/movie_screen_events.dart';
import 'package:popcorn_time/presentation%20/main_screen/bloc/movie_screen_states.dart';
import 'package:popcorn_time/presentation%20/main_screen/movie_details_screen.dart';
import 'package:popcorn_time/presentation%20/main_screen/widget/movie_card.dart';

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({super.key});

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    context.read<MovieBloc>().add(FetchMoviesEvent(1));
    super.initState();
  }


  Future<void> _navigateToMovieDetails(BuildContext context, movie) async {
    // Wait for the user to return from the details page
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetailsPage(movie: movie),
      ),
    );

    // Update UI when coming back
    setState(() {}); // Triggers rebuild to update favorite state
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("It's Popcorn Time"), backgroundColor: Colors.white,),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search Movies...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onChanged: (query) {
                if(query.length >2)
                context.read<MovieBloc>().add(SearchMoviesEvent(query));
              },
            ),
          ),

          // Movie Grid
          Expanded(
            child: BlocBuilder<MovieBloc, MovieListState>(
              builder: (context, state) {
                  return state.error != null ? state.isLoadingMovies ? Center(child: CircularProgressIndicator(),) : GridView.builder(
                    padding: EdgeInsets.all(10),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // 2 items per row
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.8, // Adjust aspect ratio
                    ),
                    itemCount: state.movieList?.results.length ?? 0,
                    itemBuilder: (context, index) {
                      final movie = state.movieList?.results[index];
                      final isFavorite = HiveService().isFavorite(movie?.id ?? 0);

                     return GestureDetector(
                       onTap: () => _navigateToMovieDetails(context, movie),

                       child: MovieCard(
                          movie: movie,
                          isFavorite: isFavorite,
                          onFavoriteToggle: () {
                            setState(() {
                              if (isFavorite) {
                                HiveService().removeFavorite(movie?.id ?? 0);
                              } else {
                                HiveService().addFavorite(movie?.id ?? 0);
                              }
                            });
                          },
                        ),
                     );
                    },
                  ) : Text(state.error ?? "Give us a moment. Please come back again");
                // Show loader while fetching
              },
            ),
          ),
        ],
      ),
    );
  }
}

