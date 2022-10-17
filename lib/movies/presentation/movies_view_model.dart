import 'package:dio_training/movies/data/movies_repository.dart';
import 'package:dio_training/movies/domain/movie.dart';
import 'package:mobx/mobx.dart';

part 'movies_view_model.g.dart';

class MoviesViewModel = MoviesViewModelBase with _$MoviesViewModel;

abstract class MoviesViewModelBase with Store {
  MoviesViewModelBase() {
    getMovies();
  }

  final repository = MovieRepository();
  @observable
  bool isLoading = false;

  @observable
  String? error;

  @observable
  ObservableList<Movie> movies = <Movie>[].asObservable();

  @action
  Future<void> getMovies({final int page = 1}) async {
    isLoading = true;
    try {
      await Future.delayed(const Duration(seconds: 3));
      movies = (await repository.getPopularMovies()).asObservable();
    } catch (ex) {
      error = ex.toString();
    } finally {
      isLoading = false;
    }
  }
}
