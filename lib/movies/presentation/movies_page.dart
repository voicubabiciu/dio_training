import 'package:dio_training/movies/presentation/components/movie_widget.dart';
import 'package:dio_training/movies/presentation/movies_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({super.key});

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  final viewModel = MoviesViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TMDB demo app'),
      ),
      body: Observer(builder: (context) {
        if (viewModel.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (viewModel.error != null) {
          return Center(
            child: Text(viewModel.error!),
          );
        }
        return ListView.builder(
          itemCount: viewModel.movies.length,
          padding: const EdgeInsets.all(16),
          itemBuilder: (context, index) {
            return MovieItem(
              movie: viewModel.movies[index],
            );
          },
        );
      }),
    );
  }
}
