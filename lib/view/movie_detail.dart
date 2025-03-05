import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:movie_api_riverpod/Movie_Api/movie_model.dart';

class MovieDetailScreen extends StatelessWidget {
  final MovieModel movie;
  const MovieDetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: SizedBox(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Positioned.fill(
                    child: Hero(
                        tag: movie.id,
                        child: Image.network(
                          "https://image.tmdb.org/t/p/w500${movie.posterPath}",
                          width: double.infinity,
                          // height: double.infinity,
                          fit: BoxFit.fill,
                        ))),
              ),
              Positioned(
                  left: 500,
                  child: Container(
                    padding: const EdgeInsets.all(50),
                    color: Colors.black.withOpacity(0.1),
                    child: Text(
                      movie.title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
              Positioned(
                  left: 130,
                  // width: 1000,
                  // height: 400,
                  top: 400,
                  child: Container(
                    width: 1000,
                    height: 400,
                    padding: const EdgeInsets.all(30),
                    color: Colors.black.withOpacity(0.5),
                    child: SizedBox(
                      height: 300,
                      child: Marquee(
                        text: movie.overview,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 30),
                        scrollAxis: Axis.vertical,
                        blankSpace: 10,
                        velocity: 30,
                        pauseAfterRound: const Duration(seconds: 1),
                        startPadding: 10,
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
