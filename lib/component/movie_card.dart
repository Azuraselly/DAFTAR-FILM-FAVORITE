import 'package:flutter/material.dart';
import '../models/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onFavorite;

  const MovieCard({
    Key? key,
    required this.movie,
    required this.isFavorite,
    required this.onTap,
    required this.onFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      color: Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Poster
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  movie.poster,
                  width: 90,
                  height: 130,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(width: 12),

              // Detail Film
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Judul + Favorite
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            movie.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4E342E),
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.redAccent,
                          ),
                          onPressed: onFavorite,
                        ),
                      ],
                    ),

                    const SizedBox(height: 4),

                    // Tahun & Genre
                    Text(
                      '${movie.year} • ${movie.genre}',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.brown,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 6),

                    // Durasi + Rating + Usia
                    Row(
                      children: [
                        Icon(Icons.access_time,
                            size: 16, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            movie.duration ?? '',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Icon(Icons.star,
                            size: 16, color: Colors.amber[700]),
                        const SizedBox(width: 4),
                        Text(
                          movie.rating.toString(),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[700],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Icon(Icons.person,
                            size: 16, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(
                          movie.ageRating ?? '',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // Sinopsis
                    Text(
                      movie.synopsis,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF5D4037),
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
