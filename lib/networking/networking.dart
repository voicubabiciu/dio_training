import 'package:dio/dio.dart';

class NetworkModule {
  NetworkModule() {
    _addInterceptors();
  }
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
    ),
  );
  static const String _apiKey = '7fc978cef2bcf866d1621b3f67e98723';

  void _addInterceptors() {
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      return handler.next(options
        ..queryParameters = {
          'api_key': _apiKey,
        });
    }));
  }
}
