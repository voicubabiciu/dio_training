import 'package:freezed_annotation/freezed_annotation.dart';

part 'resource.freezed.dart';

@freezed
class Resource<T> with _$Resource {
  const factory Resource.initial() = ResourceInitial;
  const factory Resource.loading({T? data, String? test}) = ResourceLoading;
  const factory Resource.error({required String error, T? data}) =
      ResourceError;
  const factory Resource.success({required T data}) = ResourceSuccess;
}

extension ResourceExtensions<T> on Resource<T> {
  T? get data => maybeMap(
      success: (value) => value.data,
      // error: (value) => value.data,
      loading: (value) => value.data,
      orElse: () => null);

  void test() {
    if (this is ResourceLoading) {}
    this.when(
      initial: () {},
      loading: (data, test) {},
      error: (error, data) {},
      success: (data) {},
    );

    map(
      initial: (value) {},
      loading: (value) {},
      error: (value) {},
      success: (value) {},
    );
  }
}
