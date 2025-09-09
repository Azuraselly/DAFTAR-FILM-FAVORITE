class Movie {
  final String title;
  final String year;
  final String poster;
  final String genre;
  final String synopsis;

  Movie({
    required this.title,
    required this.year,
    required this.poster,
    this.genre = "",
    this.synopsis = "",
  });
}
