import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_api_riverpod/Riverpod_StateNotifier/provider.dart';
import 'package:movie_api_riverpod/view/text_field.dart';

import '../Riverpod_StateNotifier/movie_notifier.dart';
import 'movie_detail.dart';

class MovieListScreen extends ConsumerWidget {
  const MovieListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieState = ref.watch(movieProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: SearchField(),
          ),
        ),
      ),
      body: movieState.when(
          data: (movies) => GridView.builder(
                // padding: const EdgeInsets.all(10),
                itemCount: movies.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 30,
                    // mainAxisSpacing: 5,
                    crossAxisCount: 2,
                    childAspectRatio: 0.6),
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 500),
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      MovieDetailScreen(movie: movie),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              }));
                    },
                    child: Hero(
                      tag: movie.id,
                      child: Column(
                        children: [
                          Image.network(
                              "https://image.tmdb.org/t/p/w500${movie.posterPath}"),
                          Text(movie.title)
                        ],
                      ),
                    ),
                  );
                },
              ),
          error: (error, StackTrace) => Center(
                child: Text("Error: $error"),
              ),
          loading: () => const Center(
                child: CircularProgressIndicator(),
              )),
    );
  }
}
