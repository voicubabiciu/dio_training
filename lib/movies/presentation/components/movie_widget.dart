import 'package:dio_training/movies/domain/movie.dart';
import 'package:dio_training/networking/networking.dart';
import 'package:flutter/material.dart';

class MovieItem extends StatelessWidget {
  const MovieItem({super.key, required this.movie});
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Flexible(
                child: Image.network(
                    '${NetworkModule.imagesBaseUrl}${movie.posterPath}')),
            const SizedBox(
              width: 8,
            ),
            Expanded(flex: 3, child: Text(movie.title)),
          ],
        ),
      ),
    );
  }
}
