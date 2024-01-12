import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_movie_app/models/movie_model.dart';
import 'package:tmdb_movie_app/screens/movie_view.dart';
import 'package:tmdb_movie_app/services/api_services.dart';

class SearchResult extends StatefulWidget {
  const SearchResult({super.key, required this.query});
  final String query;

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text(
          widget.query,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: FutureBuilder(
        future: ApiServices().searchMovie(keyword: widget.query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text("Something went wrong"),
            );
          }
          List<MovieModel> movies = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                childAspectRatio: 0.7,
              ),
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => MovieView(movie: movies[index]),
                      ),
                    );
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(movies[index].posterPath!),
                      ),
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 5,
                          left: 5,
                          child: Chip(
                            label: Text(movies[index].voteAverage!.toString()),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
