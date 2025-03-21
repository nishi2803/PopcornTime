import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popcorn_time/hive/hive_service.dart';
import 'package:popcorn_time/presentation%20/main_screen/bloc/movie_screen_bloc.dart';
import 'package:popcorn_time/presentation%20/main_screen/bloc/movie_screen_events.dart';
import 'package:popcorn_time/presentation%20/main_screen/bloc/movie_screen_states.dart';
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Movies")),
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
                context.read<MovieBloc>().add(SearchMoviesEvent(query));
              },
            ),
          ),

          // Movie Grid
          Expanded(
            child: BlocBuilder<MovieBloc, MovieState>(
              builder: (context, state) {
                if (state is MovieListState) {
                  return GridView.builder(
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

                      return MovieCard(
                        movieName: movie?.title ?? "",
                        isFavorite: isFavorite,
                        onFavoriteToggle: () {
                          if (isFavorite) {
                            context.read<MovieBloc>().add(RemoveFavoriteEvent(movie?.id ?? 0));
                          } else {
                            context.read<MovieBloc>().add(MarkFavoriteEvent(movie?.id ?? 0));
                          }
                        },
                      );
                    },
                  );
                }
                return Center(child: CircularProgressIndicator()); // Show loader while fetching
              },
            ),
          ),
        ],
      ),
    );
  }
}

