import 'dart:async';

import 'typedefs.dart';

typedef FutureOrComputation<T, Q> = FutureOr<T> Function(Q);

FutureOr<T> useIsolate<T, Q>(
  Q message,
  IsolateComputation<T, Q> computation, {
  IsolateDataToJson<T>? toJson,
  IsolateDataFromJson<T>? fromJson,
}) =>
    throw UnimplementedError("Not supported on the current platform");
