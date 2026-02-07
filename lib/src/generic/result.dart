/// Wrapper for values.
final class Result<T, E> {
  final T? value;
  final E? error;

  const Result.success(this.value) : error = null;
  const Result.error(this.error) : value = null;

  bool get hasValue => value != null;
}
