import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:movie_api_riverpod/Movie_Api/movie_model.dart';

class MovieApiService {
  static const String _baseUrl = 'https://api.themoviedb.org/3';
  static const String _apiKey = '5fe9638dcce9aa675db2843fb2886eb8';

  Future<List<MovieModel>> featchPopularMovies() async {
    final response =
        await http.get(Uri.parse('$_baseUrl/movie/popular?api_key=$_apiKey'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<MovieModel> movies = (data['results'] as List)
          .map((movie) => MovieModel.fromJson(movie))
          .toList();
      return movies;
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
