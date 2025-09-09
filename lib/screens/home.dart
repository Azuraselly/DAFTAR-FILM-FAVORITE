import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../component/movie_card.dart';
import 'movie_detail.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Movie> _allMovies = [
    Movie(
      id: '1',
      title: 'Laskar Pelangi',
      year: '2008',
      poster: 'assets/laskar_pelangi.jpeg',
      genre: 'Drama, Inspiratif',
      synopsis: 'Film ini menceritakan kehidupan sekelompok anak di Belitung yang bersekolah di SD Muhammadiyah, sebuah sekolah kecil dengan fasilitas seadanya. Meski menghadapi keterbatasan ekonomi dan sarana belajar, mereka tidak pernah menyerah untuk menuntut ilmu. Dibimbing oleh guru Bu Muslimah dan Pak Harfan, mereka membentuk kelompok bernama \'Laskar Pelangi\'. Kisah ini sarat akan persahabatan, perjuangan, dan harapan, sekaligus mengkritik kesenjangan pendidikan di Indonesia.',
      isFavorite: false,
    ),
    Movie(
      id: '2',
      title: 'Habibie & Ainun',
      year: '2012',
      poster: 'assets/habibie_ainun.jpeg',
      genre: 'Drama, Biografi, Romantis',
      synopsis: 'Film ini mengisahkan perjalanan cinta Presiden ke-3 RI, B.J. Habibie, dengan istrinya Hasri Ainun Besari. Dimulai dari pertemuan mereka di masa muda, kisah ini memperlihatkan bagaimana Ainun selalu menjadi pendamping setia dalam kehidupan Habibie, mulai dari masa kuliah, perjuangan membangun industri pesawat Indonesia, hingga saat Habibie menjabat sebagai Presiden RI. Cinta mereka penuh pengorbanan dan ketulusan.',
      isFavorite: false,
    ),
    Movie(
      id: '3',
      title: 'Dilan 1990',
      year: '2018',
      poster: 'assets/dilan_1990.jpeg',
      genre: 'Romantis, Drama',
      synopsis: 'Berlatar di Bandung tahun 1990, film ini mengisahkan hubungan antara Milea, siswi pindahan dari Jakarta, dengan Dilan, seorang panglima geng motor yang terkenal nakal namun unik. Dilan tidak mendekati Milea dengan cara biasa, melainkan lewat kata-kata manis khas dan tingkah laku yang tidak terduga. Perjalanan cinta mereka menghadirkan kisah romansa remaja yang manis, lucu, dan penuh kenangan.',
      isFavorite: false,
    ),
    Movie(
      id: '4',
      title: 'KKN di Desa Penari',
      year: '2022',
      poster: 'assets/kkn_desa_penari.jpeg',
      genre: 'Horor, Misteri',
      synopsis: 'Film ini mengikuti enam mahasiswa yang melakukan Kuliah Kerja Nyata (KKN) di desa terpencil. Awalnya disambut ramah, ternyata desa menyimpan aturan adat ketat. Ketika dilanggar, satu per satu mengalami gangguan mistis. Teror datang dari sosok penari misterius yang membawa mereka ke dalam peristiwa mengerikan. Nuansa horor khas Indonesia dengan adat Jawa yang kuat.',
      isFavorite: false,
    ),
    Movie(
      id: '5',
      title: 'Susah Sinyal',
      year: '2017',
      poster: 'assets/susah_sinyal.jpeg',
      genre: 'Drama, Komedi',
      synopsis: 'Ellen, pengacara sukses, terlalu sibuk dengan pekerjaannya sehingga jarang meluangkan waktu untuk putrinya, Kiara. Setelah nenek yang membesarkan Kiara meninggal, hubungan mereka semakin renggang. Demi memperbaiki hubungan, Ellen membawa Kiara berlibur ke Sumba. Perjalanan ini tidak mulus karena keterbatasan sinyal, menghasilkan momen haru sekaligus lucu tentang kebersamaan keluarga.',
      isFavorite: false,
    ),
  ];

  late List<Movie> _movies;
  late List<Movie> _favoriteMovies;

  @override
  void initState() {
    super.initState();
    _movies = List.from(_allMovies);
    _favoriteMovies = _movies.where((m) => m.isFavorite).toList();
  }

  void _toggleFavorite(Movie movie) {
    setState(() {
      final updatedMovie = movie.copyWith(isFavorite: !movie.isFavorite);

      final index = _movies.indexWhere((m) => m.id == movie.id);
      if (index != -1) {
        _movies[index] = updatedMovie;
      }

      final favIndex = _favoriteMovies.indexWhere((m) => m.id == movie.id);
      if (updatedMovie.isFavorite) {
        if (favIndex == -1) {
          _favoriteMovies.add(updatedMovie);
        }
      } else {
        if (favIndex != -1) {
          _favoriteMovies.removeAt(favIndex);
        }
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            updatedMovie.isFavorite
                ? '${movie.title} ditambahkan ke favorit'
                : '${movie.title} dihapus dari favorit',
          ),
          backgroundColor: const Color(0xFFD2691E),
          duration: const Duration(seconds: 2),
        ),
      );
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildMovieList(List<Movie> movieList, {bool isFavoriteTab = false}) {
    if (movieList.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isFavoriteTab ? Icons.favorite_border : Icons.movie_outlined,
              size: 80,
              color: Colors.brown[300],
            ),
            const SizedBox(height: 16),
            Text(
              isFavoriteTab ? 'Belum ada film favorit' : 'Tidak ada film tersedia',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.brown[600],
              ),
            ),
            if (isFavoriteTab) ...[
              const SizedBox(height: 8),
              Text(
                'Tambahkan film favorit Anda',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.brown[400],
                ),
              ),
            ],
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(milliseconds: 1000));
      },
      color: const Color(0xFFD2691E),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        itemCount: movieList.length,
        itemBuilder: (context, idx) {
          final movie = movieList[idx];
          return MovieCard(
            key: ValueKey(movie.id),
            movie: movie,
            isFavorite: movie.isFavorite,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MovieDetailScreen(
                    movie: movie,
                    onFavorite: () => _toggleFavorite(movie),
                  ),
                ),
              );
            },
            onFavorite: () => _toggleFavorite(movie),
          );
        },
      ),
    );
  }
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFFFF3E0),
                Color(0xFFFFE0B2),
              ],
            ),
          ),
          child: Column(
            children: [
              // Judul halaman
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  _selectedIndex == 0 ? 'Daftar Film' : 'Film Favorit',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Color(0xFF6D4C41),
                  ),
                ),
              ),
              Expanded(
                child: _buildMovieList(
                  _selectedIndex == 0 ? _movies : _favoriteMovies,
                  isFavoriteTab: _selectedIndex == 1,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFFFF3E0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xFFD2691E),
          unselectedItemColor: const Color(0xFFA1887F),
          backgroundColor: Colors.transparent,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              activeIcon: Icon(Icons.favorite),
              label: 'Favorit',
            ),
          ],
        ),
      ),
    );
  }
}