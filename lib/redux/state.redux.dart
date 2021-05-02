import 'package:meta/meta.dart';

abstract class State<T extends Object, E extends Exception> {
  @internal
  @protected
  final T? data;

  @internal
  @protected
  final bool isLoading;

  @internal
  @protected
  final E? exception;

  State({
    this.data,
    this.isLoading = false,
    this.exception,
  });
}
