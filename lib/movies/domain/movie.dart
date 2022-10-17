import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie.freezed.dart';

@freezed
class Movie with _$Movie {
  factory Movie({
    required int id,
    required String title,
    required String overview,
    required String posterPath,
    required String releaseDate,
  }) = _Movie;
}
