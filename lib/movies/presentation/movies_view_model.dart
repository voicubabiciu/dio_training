import 'package:dio_training/helpers/resource.dart';
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

  int currentPageIndex = 0;

  @observable
  Resource<List<Movie>> moviesResource = const Resource.initial();

  @action
  Future<void> getMovies() async {
    moviesResource = Resource.loading(data: moviesResource.data);
    if (moviesResource is ResourceLoading) {}
    try {
      moviesResource = Resource.success(
          data: <Movie>[
        ...moviesResource.data ?? [],
        ...(await repository.getPopularMovies(page: ++currentPageIndex))
      ].toList());
    } catch (ex) {
      moviesResource =
          Resource.error(error: ex.toString(), data: moviesResource.data);
    }
  }
}
