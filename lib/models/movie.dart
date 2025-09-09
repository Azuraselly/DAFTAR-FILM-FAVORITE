class Movie {
  final String id;
  final String title;
  final String year;
  final String poster;
  final String genre;
  final String synopsis;
  bool isFavorite;

  Movie({
    required this.id,
    required this.title,
    required this.year,
    required this.poster,
    required this.genre,
    required this.synopsis,
    this.isFavorite = false,
  });

  // CopyWith method for immutable updates
  Movie copyWith({
    String? id,
    String? title,
    String? year,
    String? poster,
    String? genre,
    String? synopsis,
    bool? isFavorite,
  }) {
    return Movie(
      id: id ?? this.id,
      title: title ?? this.title,
      year: year ?? this.year,
      poster: poster ?? this.poster,
      genre: genre ?? this.genre,
      synopsis: synopsis ?? this.synopsis,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Movie &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          year == other.year &&
          poster == other.poster &&
          genre == other.genre &&
          synopsis == other.synopsis &&
          isFavorite == other.isFavorite;

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      year.hashCode ^
      poster.hashCode ^
      genre.hashCode ^
      synopsis.hashCode ^
      isFavorite.hashCode;
}