import 'package:flutter/material.dart';

class MovieCard extends StatefulWidget {
  final String movieName;
  final bool isFavorite;
  final Function onFavoriteToggle;

  const MovieCard({
    required this.movieName,
    required this.isFavorite,
    required this.onFavoriteToggle,
  });

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){

      }, // Toggle favorite on tap
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Movie Name
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.movieName,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            // Favorite Button
            IconButton(
              icon: Icon(
                widget.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: widget.isFavorite ? Colors.red : Colors.black,
                size: 30,
              ),
              onPressed:() => widget.onFavoriteToggle, // Toggle favorite
            ),
          ],
        ),
      ),
    );
  }
}
