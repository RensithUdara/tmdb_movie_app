import 'dart:convert';

import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:tmdb_movie_app/models/actor_model.dart';
import 'package:tmdb_movie_app/models/movie_details.dart';
import 'package:tmdb_movie_app/models/movie_model.dart';

class ApiServices {
  String popularMovies = "https://api.themoviedb.org/3/movie/popular";
  String topRatedMovies = "https://api.themoviedb.org/3/movie/top_rated";
  String upcomingMovies = "https://api.themoviedb.org/3/movie/upcoming";
  String movieDetails = "https://api.themoviedb.org/3/movie/";
  String cast = "https://api.themoviedb.org/3/movie/";
  String search = "https://api.themoviedb.org/3/search/movie?query=";

  String apiKey = "?api_key=722e938974ed2869ee301410ce44f68c";

  Future<List<MovieModel>> getPopularMovies() async {
    Response response = await get(Uri.parse("$popularMovies$apiKey"));
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      List<dynamic> results = body["results"];
      List<MovieModel> movies =
          results.map((movie) => MovieModel.fromJson(movie)).toList();
      return movies;
      // Logger().d(results[0]);
    } else {
      Logger().e(response.statusCode);
      return [];
    }
  }

  Future<List<MovieModel>> getTopRatedMovies() async {
    Response response = await get(Uri.parse("$topRatedMovies$apiKey"));
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      List<dynamic> results = body["results"];
      List<MovieModel> movies =
          results.map((movie) => MovieModel.fromJson(movie)).toList();
      return movies;
    } else {
      Logger().e(response.statusCode);
      return [];
    }
  }

  Future<List<MovieModel>> getUpcomingMovies() async {
    Response response = await get(Uri.parse("$upcomingMovies$apiKey"));
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      List<dynamic> results = body["results"];
      List<MovieModel> movies =
          results.map((movie) => MovieModel.fromJson(movie)).toList();
      return movies;
    } else {
      Logger().e(response.statusCode);
      return [];
    }
  }

  Future<MovieDetailsModel?> getMovieDetails(int id) async {
    Response response = await get(Uri.parse("$cast$id$apiKey"));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      MovieDetailsModel movieData = MovieDetailsModel.fromJson(data);
      return movieData;
    } else {
      Logger().e(response.statusCode);
      return null;
    }
  }

  Future<List<ActorModel>?> getActorsDetails(int id) async {
    Response response = await get(Uri.parse("$movieDetails$id/credits$apiKey"));
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      List<dynamic> cast = body['cast'];
      List<ActorModel> actors =
          cast.map((e) => ActorModel.fromJson(e)).toList();
      return actors;
    } else {
      Logger().e(response.statusCode);
      return null;
    }
  }

  Future<List<MovieModel>?> searchMovie({required String keyword}) async {
    Response response =
        await get(Uri.parse("$search$keyword${apiKey.replaceAll("?", "&")}"));
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      List<dynamic> results = body['results'];
      List<MovieModel> movies = results
          .map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
          .toList();
      // Logger().f(movies[0]);
      return movies;
    } else {
      Logger().e(response.statusCode);
      return null;
    }
  }
}
