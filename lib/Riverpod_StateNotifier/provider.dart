import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_api_riverpod/Movie_Api/movie_api_service.dart';
import 'package:movie_api_riverpod/Riverpod_StateNotifier/filter_movie_notifier.dart';
import '../Movie_Api/movie_model.dart';
import 'movie_notifier.dart';

final movieServiceProvider = Provider((ref) => MovieApiService());
final movieProvider = FutureProvider<List<MovieModel>>((ref) async {
  ref.watch(movieServiceProvider);
  return await MovieApiService().featchPopularMovies();
});
// search provider
final searchProvider = StateProvider<String>((ref) => '');
// final filteredMovieProvider = StateNotifierProvider<FilteredMovieNotifier, AsyncValue<List<MovieModel>>>((ref) {
//   final movieNotifier = ref.watch(movieProvider.notifier);
//   return FilteredMovieNotifier(movieNotifier);
// });

final filteredMovieProvider = Provider<List<MovieModel>>((ref) {
  final searchQuery = ref.watch(searchProvider);
  final movies = ref.watch(movieProvider).value ?? [];
  return movies
      .where((movie) =>
          movie.title.toLowerCase().contains(searchQuery.toLowerCase()))
      .toList();
});
