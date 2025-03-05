import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:movie_api_riverpod/Movie_Api/movie_model.dart';
import 'package:movie_api_riverpod/Riverpod_StateNotifier/provider.dart';

class MovieNotifier extends StateNotifier<AsyncValue<List<MovieModel>>> {
  MovieNotifier(this.ref) : super(const AsyncValue.loading()) {
    fetchMovies();
  }
  final Ref ref;
  Future<void> fetchMovies() async {
    try {
      final movies = await ref.read(movieServiceProvider).featchPopularMovies();
      state = AsyncValue.data(movies);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
