class Movie {
  final int id;
  final String title;
  final String? overview;
  final String? posterPath;   // TMDB uses poster_path
  final String? backdropPath; // TMDB uses backdrop_path
  final String? releaseDate;
  final double voteAverage;   // TMDB uses vote_average
  final int voteCount;
  final bool isFeatured;
  final bool isTrending;
  final bool isTopRated;
  final bool isUpcoming;

  Movie({
    required this.id,
    required this.title,
    this.overview,
    this.posterPath,
    this.backdropPath,
    this.releaseDate,
    this.voteAverage = 0.0,
    this.voteCount = 0,
    this.isFeatured = false,
    this.isTrending = false,
    this.isTopRated = false,
    this.isUpcoming = false,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'] ?? 'Unknown',
      overview: json['overview'],
      posterPath: json['poster_path'] ?? json['poster_url'],
      backdropPath: json['backdrop_path'] ?? json['backdrop_url'],
      releaseDate: json['release_date'],
      voteAverage: (json['vote_average'] ?? json['rating'] ?? 0.0).toDouble(),
      voteCount: json['vote_count'] ?? json['vote_count'] ?? 0,
      isFeatured: json['is_featured'] ?? false,
      isTrending: json['is_trending'] ?? false,
      isTopRated: json['is_top_rated'] ?? false,
      isUpcoming: json['is_upcoming'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'overview': overview,
      'poster_path': posterPath,
      'backdrop_path': backdropPath,
      'release_date': releaseDate,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'is_featured': isFeatured,
      'is_trending': isTrending,
      'is_top_rated': isTopRated,
      'is_upcoming': isUpcoming,
    };
  }
}