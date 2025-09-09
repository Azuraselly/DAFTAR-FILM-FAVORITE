import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../component/movie_card.dart';
import 'movie_detail.dart';

class FavoriteScreen extends StatelessWidget {
  final List<Movie> favoriteMovies;
  final Function(Movie) onFavoriteToggle;

  const FavoriteScreen({
    super.key,
    required this.favoriteMovies,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    if (favoriteMovies.isEmpty) {
      return const Center(
        child: Text(
          'Tidak ada film favorit',
          style: TextStyle(fontSize: 16, color: Colors.brown),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: favoriteMovies.length,
      itemBuilder: (context, index) {
        final movie = favoriteMovies[index];
        return MovieCard(
          movie: movie,
          isFavorite: movie.isFavorite,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MovieDetailScreen(
                  movie: movie,
                  onFavorite: () => onFavoriteToggle(movie),
                ),
              ),
            );
          },
          onFavorite: () => onFavoriteToggle(movie),
        );
      },
    );
  }
}
