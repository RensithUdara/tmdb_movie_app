import 'package:tmdb_movie_app/models/company_models.dart';
import 'package:tmdb_movie_app/models/genres_model.dart';

class MovieDetailsModel {
  String? overview;
  List<CompanyModel>? companies;
  String? tagline;
  List<GenresModel>? genres;

  MovieDetailsModel(
      {required this.companies,
      required this.overview,
      required this.genres,
      required this.tagline});

  factory MovieDetailsModel.fromJson(Map<String, dynamic> map) {
    List<CompanyModel> companies = (map["production_companies"] as List)
        .map((company) => CompanyModel.fromJson(company))
        .toList();
    List<GenresModel> genres =
        (map["genres"] as List).map((e) => GenresModel.fromJson(e)).toList();

    return MovieDetailsModel(
        companies: companies,
        genres: genres,
        overview: map['overview'],
        tagline: map['tagline'] ?? "");
  }
}
