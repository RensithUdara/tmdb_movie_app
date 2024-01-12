class MovieModel {
  String? backdropPath;
  int? id;
  String? posterPath;
  String? title;
  double? voteAverage;

  MovieModel({
    this.backdropPath,
    this.id,
    this.posterPath,
    this.title,
    this.voteAverage,
  });
  factory MovieModel.fromJson(Map<String, dynamic> map) {
    return MovieModel(
      backdropPath: "https://image.tmdb.org/t/p/w500${map["backdrop_path"]}",
      id: map["id"],
      posterPath: "https://image.tmdb.org/t/p/w500${map["poster_path"]}",
      title: map["title"],
      voteAverage: map["vote_average"].toDouble(),
    );
  }
}
