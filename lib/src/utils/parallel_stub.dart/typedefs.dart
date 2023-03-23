import 'dart:async';

typedef IsolateComputation<T, Q> = FutureOr<T> Function(Q);
typedef IsolateDataToJson<T> = Map<String, dynamic> Function(T);
typedef IsolateDataFromJson<T> = T Function(String);
