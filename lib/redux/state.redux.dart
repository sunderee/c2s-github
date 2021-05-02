import 'package:meta/meta.dart';

abstract class State<T extends Object> {
  @internal
  @protected
  final T? data;

  @internal
  @protected
  final bool isLoading;

  @internal
  @protected
  final String? exception;

  State({
    this.data,
    this.isLoading = false,
    this.exception,
  });
}
