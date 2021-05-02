// Source pulled from async package: https://github.com/dart-lang/async
import 'dart:async';

typedef FutureOrCallback<T> = FutureOr<T> Function();

class AsyncMemoizer<T> {
  Future<T> get future => _completer.future;
  final _completer = Completer<T>();

  bool get hasRun => _completer.isCompleted;

  Future<T> runOnce(FutureOr<T> Function() computation) {
    if (!hasRun) _completer.complete(Future.sync(computation));
    return future;
  }
}

class CancelableOperation<T> {
  final CancelableCompleter<T> _completer;

  CancelableOperation._(this._completer);

  factory CancelableOperation.fromFuture(Future<T> inner,
      {FutureOr Function()? onCancel}) {
    var completer = CancelableCompleter<T>(onCancel: onCancel);
    completer.complete(inner);
    return completer.operation;
  }

  Future<T> get value => _completer._inner.future;

  Stream<T> asStream() {
    var controller =
        StreamController<T>(sync: true, onCancel: _completer._cancel);

    value.then((value) {
      controller.add(value);
      controller.close();
    }, onError: (Object error, StackTrace stackTrace) {
      controller.addError(error, stackTrace);
      controller.close();
    });
    return controller.stream;
  }

  Future<T?> valueOrCancellation([T? cancellationValue]) {
    var completer = Completer<T?>.sync();
    value.then((result) => completer.complete(result),
        onError: completer.completeError);

    _completer._cancelMemo.future.then((_) {
      completer.complete(cancellationValue);
    }, onError: completer.completeError);

    return completer.future;
  }

  CancelableOperation<R> then<R>(FutureOr<R> Function(T) onValue,
      {FutureOr<R> Function(Object, StackTrace)? onError,
      FutureOr<R> Function()? onCancel,
      bool propagateCancel = false}) {
    final completer =
        CancelableCompleter<R>(onCancel: propagateCancel ? cancel : null);

    valueOrCancellation().then((T? result) {
      if (!completer.isCanceled) {
        if (isCompleted) {
          assert(result is T);
          completer.complete(Future.sync(() => onValue(result as T)));
        } else if (onCancel != null) {
          completer.complete(Future.sync(onCancel));
        } else {
          completer._cancel();
        }
      }
    }, onError: (Object error, StackTrace stackTrace) {
      if (!completer.isCanceled) {
        if (onError != null) {
          completer.complete(Future.sync(() => onError(error, stackTrace)));
        } else {
          completer.completeError(error, stackTrace);
        }
      }
    });
    return completer.operation;
  }

  Future cancel() => _completer._cancel();

  bool get isCanceled => _completer.isCanceled;

  bool get isCompleted => _completer.isCompleted;
}

class CancelableCompleter<T> {
  final _inner = Completer<T>();

  final FutureOrCallback? _onCancel;

  CancelableCompleter({FutureOr Function()? onCancel}) : _onCancel = onCancel;

  late final operation = CancelableOperation<T>._(this);

  bool get isCompleted => _isCompleted;
  bool _isCompleted = false;

  bool get isCanceled => _isCanceled;
  bool _isCanceled = false;

  final _cancelMemo = AsyncMemoizer();

  void complete([FutureOr<T>? value]) {
    if (_isCompleted) throw StateError('Operation already completed');
    _isCompleted = true;

    if (value is! Future) {
      if (_isCanceled) return;
      _inner.complete(value);
      return;
    }

    final future = value as Future<T>;
    if (_isCanceled) {
      future.catchError((_) {});
      return;
    }

    future.then((result) {
      if (_isCanceled) return;
      _inner.complete(result);
    }, onError: (Object error, StackTrace stackTrace) {
      if (_isCanceled) return;
      _inner.completeError(error, stackTrace);
    });
  }

  void completeError(Object error, [StackTrace? stackTrace]) {
    if (_isCompleted) throw StateError('Operation already completed');
    _isCompleted = true;

    if (_isCanceled) return;
    _inner.completeError(error, stackTrace);
  }

  Future _cancel() {
    if (_inner.isCompleted) return Future.value();

    return _cancelMemo.runOnce(() {
      _isCanceled = true;
      var onCancel = _onCancel;
      if (onCancel != null) return onCancel();
    });
  }
}
