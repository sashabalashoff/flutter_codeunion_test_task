import 'dart:async';

extension StreamControllerExtensions<T> on StreamController<T> {
  void maybeAdd(T event) {
    if (!isClosed) {
      add(event);
    }
  }
}
