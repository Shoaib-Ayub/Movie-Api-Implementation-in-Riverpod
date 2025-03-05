import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_api_riverpod/Movie_Api/movie_model.dart';

import 'movie_notifier.dart';

class FilteredMovieNotifier
    extends StateNotifier<AsyncValue<List<MovieModel>>> {
  FilteredMovieNotifier(this.movieNotifier)
      : super(const AsyncValue.loading()) {
    _filterMovies();
  }

  final MovieNotifier movieNotifier;
  String _searchQuery = '';

  void updateSearchQuery(String query) {
    _searchQuery = query;
    _filterMovies();
  }

  void _filterMovies() {
    movieNotifier.state.when(
      data: (movies) {
        final filteredMovies = movies
            .where((movie) =>
                movie.title.toLowerCase().contains(_searchQuery.toLowerCase()))
            .toList();
        state = AsyncValue.data(filteredMovies);
      },
      loading: () => state = const AsyncValue.loading(),
      error: (error, stackTrace) =>
          state = AsyncValue.error(Text(error.toString()), stackTrace),
    );
  }
}
