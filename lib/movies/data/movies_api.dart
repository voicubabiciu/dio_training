import 'package:dio_training/movies/data/models/popular_movies_response.dart';
import 'package:dio_training/movies/domain/movie.dart';
import 'package:dio_training/networking/networking.dart';

class MoviesApi {
  final NetworkModule networkModule = NetworkModule();

  Future<List<Movie>> getPopularMovies({final int page = 1}) async {
    final response = await networkModule.dio
        .get('/movie/popular', queryParameters: {'page': page});
    return PopularMoviesResponse.fromJson(response.data).toDomainList();
  }
}
