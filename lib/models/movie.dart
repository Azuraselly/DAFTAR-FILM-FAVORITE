class Movie {
  final String id;
  final String title;
  final String year;
  final String poster;
  final String genre;
  final String synopsis;
  bool isFavorite;
  final double? rating;
  final String? duration;
  final String? ageRating;

  Movie({
    required this.id,
    required this.title,
    required this.year,
    required this.poster,
    required this.genre,
    required this.synopsis,
    this.isFavorite = false,
    this.rating,
    this.duration,
    this.ageRating,
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
    double? rating,
    String? duration,
    String? ageRating,
  }) {
    return Movie(
      id: id ?? this.id,
      title: title ?? this.title,
      year: year ?? this.year,
      poster: poster ?? this.poster,
      genre: genre ?? this.genre,
      synopsis: synopsis ?? this.synopsis,
      isFavorite: isFavorite ?? this.isFavorite,
      rating: rating ?? this.rating,
      duration: duration ?? this.duration,
      ageRating: ageRating ?? this.ageRating,
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
          isFavorite == other.isFavorite &&
          rating == other.rating &&
          duration == other.duration &&
          ageRating == other.ageRating;

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      year.hashCode ^
      poster.hashCode ^
      genre.hashCode ^
      synopsis.hashCode ^
      isFavorite.hashCode ^
      rating.hashCode ^
      duration.hashCode ^
      ageRating.hashCode;
}