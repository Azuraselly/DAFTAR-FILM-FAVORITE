import 'package:flutter/material.dart';
import '../models/movie.dart';
import 'dart:ui';

class MovieDetailScreen extends StatefulWidget {
  final Movie movie;
  final VoidCallback onFavorite;

  const MovieDetailScreen({
    super.key,
    required this.movie,
    required this.onFavorite,
  });

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.movie.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF3E0),
      body: Stack(
        children: [
          // ===== Background poster =====
          Hero(
            tag: 'movie_poster_${widget.movie.id}',
            child: Container(
              height: screenHeight * 0.5,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(widget.movie.poster),
                  fit: BoxFit.cover,
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.1),
                      Colors.black.withOpacity(0.7),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
              ),
            ),
          ),

          // ===== Konten scrollable =====
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.42), // spasi di bawah poster
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(22),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(
                            color: Colors.brown.withOpacity(0.1),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.brown.withOpacity(0.3),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ShaderMask(
                              shaderCallback: (bounds) => const LinearGradient(
                                colors: [Color(0xFFD2691E), Color(0xFF6D4C41)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ).createShader(bounds),
                              child: Text(
                                widget.movie.title,
                                style: const TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                for (int i = 1; i <= 5; i++)
                                  Icon(
                                    i <= (widget.movie.rating ?? 3)
                                        ? Icons.star
                                        : Icons.star_border,
                                    color: const Color(0xFFD2691E),
                                    size: 20,
                                  ),
                                const SizedBox(width: 10),
                                Text(
                                  "${widget.movie.rating ?? 3}/5.0",
                                  style: const TextStyle(
                                    color: Color(0xFFD2691E),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),
                            Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children: [
                                _buildChip(widget.movie.year),
                                _buildChip(widget.movie.genre),
                                _buildChip(widget.movie.duration ?? '120 min'),
                                _buildChip(widget.movie.ageRating ?? 'PG-13'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.95),
                      borderRadius: BorderRadius.circular(36),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.brown.withOpacity(0.2),
                          blurRadius: 12,
                          offset: const Offset(0, -3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Sinopsis",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF6D4C41),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          widget.movie.synopsis,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.brown,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),

          // ===== Tombol Favorite =====
          Positioned(
            bottom: 30,
            right: 24,
            child: FloatingActionButton(
              backgroundColor: isFavorite
                  ? Colors.pinkAccent
                  : const Color(0xFFD2691E),
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  isFavorite = !isFavorite;
                });
                widget.onFavorite(); // update status di home
              },
              elevation: 8,
            ),
          ),

          // Tombol Back
          Positioned(
            top: 40,
            left: 16,
            child: CircleAvatar(
              backgroundColor: Colors.black.withOpacity(0.6),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.25),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFD2691E).withOpacity(0.6)),
        boxShadow: [
          BoxShadow(
            color: Colors.brown.withOpacity(0.15),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFFD2691E),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
