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

  List<Movie> movies = [
    Movie(
      title: "Laskar Pelangi",
      year: "2008",
      poster: "assets/laskar_pelangi.jpeg",
      genre: "Drama, Inspiratif",
      synopsis: "Sekelompok anak di Belitung menghadapi tantangan belajar...",
    ),
    Movie(
      title: "Habibie & Ainun",
      year: "2012",
      poster: "assets/habibie_ainun.jpeg",
      genre: "Drama, Biografi, Romantis",
      synopsis: "Kisah cinta BJ Habibie dan Ainun dari masa muda hingga tua...",
    ),
    Movie(
      title: "Dilan 1990",
      year: "2018",
      poster: "assets/dilan_1990.jpeg",
      genre: "Romantis, Drama",
      synopsis: "Cerita cinta Dilan dan Milea di SMA tahun 1990...",
    ),
    Movie(
      title: "KKN di Desa Penari",
      year: "2022",
      poster: "assets/kkn_desa_penari.jpeg",
      genre: "Horor, Thriller",
      synopsis: "Sekelompok mahasiswa mengalami kejadian misterius di desa...",
    ),
    Movie(
      title: "Susah Sinyal",
      year: "2017",
      poster: "assets/susah_sinyal.jpeg",
      genre: "Drama, Komedi",
      synopsis: "Kisah keluarga yang harus menghadapi jarak dan komunikasi...",
    ),
  ];

  List<Movie> favoriteMovies = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _getPage(int index) {
    if (index == 0) {
      return ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        itemCount: movies.length,
        itemBuilder: (context, idx) {
          return MovieCard(
            movie: movies[idx],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MovieDetailScreen(
                    movie: movies[idx],
                    onFavorite: () {
                      setState(() {
                        if (!favoriteMovies.contains(movies[idx])) {
                          favoriteMovies.add(movies[idx]);
                        }
                      });
                      Navigator.pop(context);
                    },
                  ),
                ),
              );
            },
          );
        },
      );
    } else if (index == 1) {
      return favoriteMovies.isEmpty
          ? const Center(
              child: Text(
                "Belum ada film favorit",
                style: TextStyle(fontSize: 20, color: Colors.brown),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              itemCount: favoriteMovies.length,
              itemBuilder: (context, idx) {
                return MovieCard(
                  movie: favoriteMovies[idx],
                  onTap: () {},
                );
              },
            );
    }
    return const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),
      appBar: AppBar(
        title: const Text(
          "Daftar Film Favorit",
          style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF8B5E3C)),
        ),
        backgroundColor: const Color(0xFFFFF8F0),
        centerTitle: true,
        elevation: 0,
      ),
      body: _getPage(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF8B5E3C),
        unselectedItemColor: Colors.brown[300],
        backgroundColor: Colors.white,
        showUnselectedLabels: true,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorite"),
        ],
      ),
    );
  }
}
