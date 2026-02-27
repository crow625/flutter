/// Wrapper for values.
final class Result<T, E> {
  /// The value returned by this result.
  final T? value;

  /// The error thrown by this result.
  final E? error;

  /// Whether this result is an error.
  final bool _isError;

  /// Create a successful result with the provided value.
  const Result.success(this.value)
      : error = null,
        _isError = false;

  /// Create an error result with the provided error.
  const Result.error(this.error)
      : value = null,
        _isError = true;

  /// Whether this result has a value.
  ///
  /// `false` does not necessarily mean that the result is an error.
  /// To check for an error, use `hasError` or `isError`.
  bool get hasValue => value != null;

  /// Whether this result has an error.
  bool get hasError => error != null;

  /// Whether this result returned an error or not.
  bool get isError => _isError;
}
