import 'package:flutter/material.dart';
import '../models/movie.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;
  final VoidCallback onFavorite;

  const MovieDetailScreen({super.key, required this.movie, required this.onFavorite});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF8F0),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF8B5E3C)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Poster
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  movie.poster,
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Judul & Tahun
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF8B5E3C)),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Tahun: ${movie.year}",
                    style: TextStyle(fontSize: 18, color: Colors.brown[400]),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Genre: ${movie.genre}",
                    style: TextStyle(fontSize: 18, color: Colors.brown[400]),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    movie.synopsis,
                    style: TextStyle(fontSize: 16, color: Colors.brown[600], height: 1.5),
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: onFavorite,
                      icon: const Icon(Icons.favorite),
                      label: const Text("Tambah ke Favorite"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8B5E3C),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
