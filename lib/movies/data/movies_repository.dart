import 'package:dio_training/movies/data/movies_api.dart';
import 'package:dio_training/movies/domain/movie.dart';

class MovieRepository {
  final MoviesApi api = MoviesApi();

  Future<List<Movie>> getPopularMovies({int page = 1}) async {
    return await api.getPopularMovies(page: page);
  }
}
