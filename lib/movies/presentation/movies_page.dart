import 'package:dio_training/helpers/resource.dart';
import 'package:dio_training/movies/domain/movie.dart';
import 'package:dio_training/movies/presentation/components/movie_widget.dart';
import 'package:dio_training/movies/presentation/movies_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

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
      body: ReactionBuilder(
          child: MoviesList(
            movies: viewModel.moviesResource.data ?? [],
            onEndReached: viewModel.getMovies,
          ),
          builder: (context) {
            return reaction((_) => viewModel.moviesResource, (resource) {
              if (resource is ResourceSuccess) {
                setState(() {});
              }
              if (resource is ResourceError) {
                setState(() {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text((resource as ResourceError).error),
                  ));
                });
              }
            });
          }),
    );
  }
}

class MoviesList extends StatelessWidget {
  const MoviesList({super.key, required this.movies, this.onEndReached});

  final List<Movie> movies;
  final VoidCallback? onEndReached;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: movies.length + 1,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        if (index == movies.length) {
          onEndReached?.call();
          return const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        return MovieItem(
          movie: movies[index],
        );
      },
    );
  }
}
