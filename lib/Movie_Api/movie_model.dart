class MovieModel {
  final int id;
  final String title;
  final String posterPath;
  final String overview;

  MovieModel({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title'],
      posterPath: "https://image.tmdb.org/t/p/w500" + json['poster_path'],
      overview: json['overview'],
    );
  }
}
