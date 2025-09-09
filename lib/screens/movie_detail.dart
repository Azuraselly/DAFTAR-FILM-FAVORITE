import 'package:flutter/material.dart';
import '../models/movie.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;
  final VoidCallback onFavorite;

  const MovieDetailScreen({
    super.key,
    required this.movie,
    required this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Latar belakang dengan gradasi warna hangat
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFF9ECE0),
                  Color(0xFFE8D7B8),
                ],
                stops: [0.0, 1.0],
              ),
            ),
          ),

          // Konten yang dapat discroll
          CustomScrollView(
            slivers: [
              // AppBar dengan gambar poster film
              SliverAppBar(
                expandedHeight: 520,
                floating: false,
                pinned: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: Container(
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, size: 24),
                    color: const Color(0xFFD4A017),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding:
                      const EdgeInsets.only(bottom: 28, left: 16, right: 16),
                  title: AnimatedOpacity(
                    opacity: 1.0,
                    duration: const Duration(milliseconds: 500),
                    child: Text(
                      movie.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 30,
                        letterSpacing: 1.2,
                        shadows: [
                          Shadow(
                            offset: const Offset(2, 2),
                            blurRadius: 12,
                            color: Colors.black.withOpacity(0.8),
                          ),
                        ],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  background: Hero(
                    tag: 'movie_poster_${movie.id}',
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        // Poster film
                        Image.asset(
                          movie.poster,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.grey[600]!,
                                  Colors.grey[800]!,
                                ],
                              ),
                            ),
                            child: const Icon(
                              Icons.movie_filter_rounded,
                              size: 160,
                              color: Color(0xFFD4A017),
                            ),
                          ),
                        ),
                        // Lapisan gelap agar teks lebih mudah dibaca
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0.05),
                                Colors.black.withOpacity(0.85),
                              ],
                              stops: const [0.0, 0.9],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                iconTheme: const IconThemeData(color: Color(0xFFD4A017)),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: AnimatedFavoriteButton(
                      onFavorite: onFavorite,
                      isFavorited: movie.isFavorite,
                    ),
                  ),
                ],
              ),

              // Bagian konten detail film
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Judul dengan efek gradasi emas
                      ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: [
                            const Color(0xFFD4A017),
                            const Color(0xFF8B5E3C),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ).createShader(bounds),
                        child: Text(
                          movie.title,
                          style: const TextStyle(
                            fontSize: 38,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            letterSpacing: 1.3,
                            height: 1.3,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Rating bintang
                      Row(
                        children: [
                          for (int i = 1; i <= 5; i++)
                            Icon(
                              i <= (movie.rating ?? 3)
                                  ? Icons.star
                                  : Icons.star_border,
                              color: const Color(0xFFD4A017),
                              size: 24,
                            ),
                          const SizedBox(width: 8),
                          Text(
                            '${movie.rating ?? 3.0}/5.0',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xFFD4A017),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Informasi tambahan (tahun, genre, durasi, rating usia)
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          _buildChip(movie.year),
                          _buildChip(movie.genre),
                          _buildChip(movie.duration ?? '120 min'),
                          _buildChip(movie.ageRating ?? 'PG-13'),
                        ],
                      ),
                      const SizedBox(height: 36),

                      // Bagian sinopsis film
                      Text(
                        'Sinopsis',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: Colors.black.withOpacity(0.9),
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        movie.synopsis,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black.withOpacity(0.85),
                          height: 1.7,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.6,
                        ),
                      ),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget chip dekoratif untuk informasi tambahan
  Widget _buildChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.15),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFD4A017).withOpacity(0.6),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          color: Color(0xFFD4A017),
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}

// ===================== Animated Favorite Button =====================
class AnimatedFavoriteButton extends StatefulWidget {
  final VoidCallback onFavorite;
  final bool isFavorited;

  const AnimatedFavoriteButton({
    super.key,
    required this.onFavorite,
    required this.isFavorited,
  });

  @override
  State<AnimatedFavoriteButton> createState() => _AnimatedFavoriteButtonState();
}

class _AnimatedFavoriteButtonState extends State<AnimatedFavoriteButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late bool _isFavorited;

  @override
  void initState() {
    super.initState();
    _isFavorited = widget.isFavorited;
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
    );
  }

  @override
  void didUpdateWidget(covariant AnimatedFavoriteButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isFavorited != widget.isFavorited) {
      _isFavorited = widget.isFavorited;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorited = !_isFavorited;
      if (_isFavorited) {
        _controller.forward().then((_) => _controller.reverse());
      }
      widget.onFavorite();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: InkWell(
        onTap: _toggleFavorite,
        borderRadius: BorderRadius.circular(50),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFD4A017).withOpacity(0.9),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            transitionBuilder: (child, animation) => ScaleTransition(
              scale: animation,
              child: child,
            ),
            child: Icon(
              _isFavorited ? Icons.favorite : Icons.favorite_border,
              key: ValueKey<bool>(_isFavorited),
              color: Colors.white,
              size: 28,
            ),
          ),
        ),
      ),
    );
  }
}
