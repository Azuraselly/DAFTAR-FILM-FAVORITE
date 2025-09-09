import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../component/movie_card.dart';
import 'movie_detail.dart';

class FavoriteScreen extends StatelessWidget {
  final List<Movie> favoriteMovies;
  final Function(Movie) onFavoriteTap;

  const FavoriteScreen({
    super.key,
    required this.favoriteMovies,
    required this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    if (favoriteMovies.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.favorite_border, size: 80, color: Colors.brown),
            SizedBox(height: 16),
            Text(
              'Belum ada film favorit',
              style: TextStyle(fontSize: 20, color: Colors.brown),
            ),
          ],
        ),
      );
    }

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFFF3E0), Color(0xFFFFE0B2)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: favoriteMovies.length,
        itemBuilder: (context, index) {
          final movie = favoriteMovies[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MovieDetailScreen(
                    movie: movie,
                    onFavorite: () => onFavoriteTap(movie),
                  ),
                ),
              );
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.brown.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Poster
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20)),
                    child: Image.asset(
                      movie.poster,
                      width: 100,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Info Film
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF6D4C41),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            movie.genre,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.brown,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.star,
                                  color: Colors.orange, size: 16),
                              const SizedBox(width: 4),
                              Text(
                                movie.rating.toString(),
                                style: const TextStyle(
                                    color: Colors.brown, fontSize: 14),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () => onFavoriteTap(movie),
                                child: Icon(
                                  movie.isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Colors.redAccent,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
