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
  String _searchQuery = '';
  String _selectedGenre = 'Semua Genre';

  // ===================== DATA FILM =====================
  final List<Movie> _allMovies = [
    Movie(
      id: '1',
      title: 'Laskar Pelangi',
      year: '2008',
      poster: 'assets/laskar_pelangi.jpeg',
      genre: 'Drama, Inspiratif',
      synopsis:
          'Film ini menceritakan kehidupan sekelompok anak di Belitung yang bersekolah di SD Muhammadiyah, sebuah sekolah kecil dengan fasilitas seadanya. Meski menghadapi keterbatasan ekonomi dan sarana belajar, mereka tidak pernah menyerah untuk menuntut ilmu. Dibimbing oleh guru Bu Muslimah dan Pak Harfan, mereka membentuk kelompok bernama \'Laskar Pelangi\'. Kisah ini sarat akan persahabatan, perjuangan, dan harapan, sekaligus mengkritik kesenjangan pendidikan di Indonesia.',
      isFavorite: false,
      rating: 4.5,
      duration: '130 min',
      ageRating: 'PG',
    ),
    Movie(
      id: '2',
      title: 'Habibie & Ainun',
      year: '2012',
      poster: 'assets/habibie_ainun.jpeg',
      genre: 'Drama, Biografi, Romantis',
      synopsis:
          'Film ini mengisahkan perjalanan cinta Presiden ke-3 RI, B.J. Habibie, dengan istrinya Hasri Ainun Besari. Dimulai dari pertemuan mereka di masa muda, kisah ini memperlihatkan bagaimana Ainun selalu menjadi pendamping setia dalam kehidupan Habibie, mulai dari masa kuliah, perjuangan membangun industri pesawat Indonesia, hingga saat Habibie menjabat sebagai Presiden RI. Cinta mereka penuh pengorbanan dan ketulusan.',
      isFavorite: false,
      rating: 4.2,
      duration: '125 min',
      ageRating: 'PG-13',
    ),
    Movie(
      id: '3',
      title: 'Dilan 1990',
      year: '2018',
      poster: 'assets/dilan_1990.jpeg',
      genre: 'Romantis, Drama',
      synopsis:
          'Berlatar di Bandung tahun 1990, film ini mengisahkan hubungan antara Milea, siswi pindahan dari Jakarta, dengan Dilan, seorang panglima geng motor yang terkenal nakal namun unik. Dilan tidak mendekati Milea dengan cara biasa, melainkan lewat kata-kata manis khas dan tingkah laku yang tidak terduga. Perjalanan cinta mereka menghadirkan kisah romansa remaja yang manis, lucu, dan penuh kenangan.',
      isFavorite: false,
      rating: 4.0,
      duration: '110 min',
      ageRating: 'PG',
    ),
    Movie(
      id: '4',
      title: 'KKN di Desa Penari',
      year: '2022',
      poster: 'assets/kkn_desa_penari.jpeg',
      genre: 'Horor, Misteri',
      synopsis:
          'Film ini mengikuti enam mahasiswa yang melakukan Kuliah Kerja Nyata (KKN) di desa terpencil. Awalnya disambut ramah, ternyata desa menyimpan aturan adat ketat. Ketika dilanggar, satu per satu mengalami gangguan mistis. Teror datang dari sosok penari misterius yang membawa mereka ke dalam peristiwa mengerikan. Nuansa horor khas Indonesia dengan adat Jawa yang kuat.',
      isFavorite: false,
      rating: 3.8,
      duration: '135 min',
      ageRating: 'R',
    ),
    Movie(
      id: '5',
      title: 'Susah Sinyal',
      year: '2017',
      poster: 'assets/susah_sinyal.jpeg',
      genre: 'Drama, Komedi',
      synopsis:
          'Ellen, pengacara sukses, terlalu sibuk dengan pekerjaannya sehingga jarang meluangkan waktu untuk putrinya, Kiara. Setelah nenek yang membesarkan Kiara meninggal, hubungan mereka semakin renggang. Demi memperbaiki hubungan, Ellen membawa Kiara berlibur ke Sumba. Perjalanan ini tidak mulus karena keterbatasan sinyal, menghasilkan momen haru sekaligus lucu tentang kebersamaan keluarga.',
      isFavorite: false,
      rating: 4.1,
      duration: '105 min',
      ageRating: 'PG',
    ),
  ];

  late List<Movie> _movies;
  late List<Movie> _favoriteMovies;
  late List<Movie> _filteredMovies;
  late List<String> _genres;

  @override
  void initState() {
    super.initState();
    _movies = List.from(_allMovies);
    _favoriteMovies = _movies.where((m) => m.isFavorite).toList();
    _filteredMovies = List.from(_movies);
    _genres = [
      'Semua Genre',
      ..._allMovies.expand((movie) => movie.genre.split(', ')).toSet().toList()
    ];
  }

  // ===================== FAVORIT =====================
  void _toggleFavorite(Movie movie) {
    setState(() {
      final updatedMovie = movie.copyWith(isFavorite: !movie.isFavorite);

      final index = _movies.indexWhere((m) => m.id == movie.id);
      if (index != -1) _movies[index] = updatedMovie;

      final favIndex = _favoriteMovies.indexWhere((m) => m.id == movie.id);
      if (updatedMovie.isFavorite) {
        if (favIndex == -1) _favoriteMovies.add(updatedMovie);
      } else {
        if (favIndex != -1) _favoriteMovies.removeAt(favIndex);
      }

      _updateFilteredMovies();
    });
  }

  // ===================== SEARCH & FILTER =====================
  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
      _updateFilteredMovies();
    });
  }

  void _onGenreSelected(String genre) {
    setState(() {
      _selectedGenre = genre;
      _updateFilteredMovies();
    });
  }

  void _updateFilteredMovies() {
    _filteredMovies = _movies.where((movie) {
      final matchesSearch = _searchQuery.isEmpty ||
          movie.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          movie.genre.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesGenre =
          _selectedGenre == 'Semua Genre' || movie.genre.contains(_selectedGenre);
      return matchesSearch && matchesGenre;
    }).toList();
  }

  // ===================== NAVIGATION =====================
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 0) _updateFilteredMovies();
    });
  }

  // ===================== UI SEARCH & FILTER =====================
  Widget _buildSearchAndFilter() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          // Search Bar
          TextField(
            onChanged: _onSearchChanged,
            decoration: InputDecoration(
              hintText: 'Cari film atau genre...',
              prefixIcon: const Icon(Icons.search, color: Color(0xFFD2691E)),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear, color: Color(0xFFD2691E)),
                      onPressed: () => _onSearchChanged(''),
                    )
                  : null,
              filled: true,
              fillColor: Colors.white,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Filter Genre
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _genres.length,
              itemBuilder: (context, index) {
                final genre = _genres[index];
                final isSelected = _selectedGenre == genre;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(genre),
                    selected: isSelected,
                    onSelected: (_) => _onGenreSelected(genre),
                    selectedColor: const Color(0xFFD2691E),
                    backgroundColor: Colors.white,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : const Color(0xFFD2691E),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ===================== CAROUSEL =====================
  Widget _buildCarousel() {
    final PageController controller = PageController(viewportFraction: 0.8);

    return SizedBox(
      height: 260,
      child: PageView.builder(
        controller: controller,
        itemCount: _filteredMovies.length,
        itemBuilder: (context, index) {
          final movie = _filteredMovies[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: MovieCard(
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
            ),
          );
        },
      ),
    );
  }

  // ===================== LIST FILM =====================
  Widget _buildMovieList(List<Movie> movieList, {bool isFavoriteTab = false}) {
    if (movieList.isEmpty) {
      return const Center(
        child: Text(
          'Tidak ada film tersedia',
          style: TextStyle(fontSize: 16, color: Colors.brown),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: movieList.length,
      itemBuilder: (context, index) {
        final movie = movieList[index];
        return MovieCard(
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
    );
  }

  // ===================== BUILD =====================
  @override
  Widget build(BuildContext context) {
    final currentMovies =
        _selectedIndex == 0 ? _filteredMovies : _favoriteMovies;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFFF3E0), Color(0xFFFFE0B2)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              // Header
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _selectedIndex == 0 ? 'Jelajahi Film' : 'Film Favorit',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF6D4C41),
                      ),
                    ),
                    if (_selectedIndex == 0)
                      const Icon(Icons.filter_list, color: Color(0xFFD2691E)),
                  ],
                ),
              ),

              if (_selectedIndex == 0) _buildSearchAndFilter(),

              Expanded(
                child: _selectedIndex == 0
                    ? Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 16, bottom: 8),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Film Unggulan',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF6D4C41),
                                ),
                              ),
                            ),
                          ),
                          _buildCarousel(),
                          const Padding(
                            padding:
                                EdgeInsets.only(left: 16, top: 12, bottom: 8),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Semua Film',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF6D4C41),
                                ),
                              ),
                            ),
                          ),
                          Expanded(child: _buildMovieList(currentMovies)),
                        ],
                      )
                    : _buildMovieList(currentMovies, isFavoriteTab: true),
              ),
            ],
          ),
        ),
      ),

      // Bottom Nav
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFFD2691E),
        unselectedItemColor: const Color(0xFFA1887F),
        backgroundColor: const Color(0xFFFFF3E0),
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.movie_outlined),
            activeIcon: Icon(Icons.movie),
            label: 'Film',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            activeIcon: Icon(Icons.favorite),
            label: 'Favorit',
          ),
        ],
      ),
    );
  }
}
