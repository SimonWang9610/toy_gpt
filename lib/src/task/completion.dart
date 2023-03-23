import 'dart:async';
import 'dart:convert';

import 'package:simple_http_api/simple_http_api.dart';
import 'package:toy_gpt/toy_gpt.dart';

class CompletionTask {
  static const _path = "/completions";
  static const _streamPrefix = "data: ";

  static const _turboModel = "gpt-3.5-turbo";

  static Future<CompletionResponse> async({
    required String model,
    ChatCompletionParams? params,
    String? prompt,
  }) async {
    final data = {
      "model": model,
      "prompt": prompt,
      ...?params?.toMap(),
    };

    final res = await Api.post(
      OpenAI.getUri(_path),
      body: json.encode(data),
      headers: OpenAI.instance.headers,
      options: OpenAI.instance.connectionOption,
    );

    if (res.statusCode != 200) throw Exception(res.body);

    return CompletionResponse.fromJson(res.body);
  }

  static Future<CompletionResponse> asyncChat({
    List<dynamic> messages = const [],
    ChatCompletionParams? params,
  }) async {
    final data = {
      "model": _turboModel,
      "messages": messages,
      ...?params?.toMap(),
    };

    final res = await Api.post(
      OpenAI.getUri("/chat$_path"),
      body: json.encode(data),
      headers: OpenAI.instance.headers,
      options: OpenAI.instance.connectionOption,
    );

    if (res.statusCode != 200) throw Exception(res.body);

    return CompletionResponse.fromJson(res.body);
  }

  static Stream<CompletionResponse> stream({
    required String model,
    String? prompt,
    ChatCompletionParams? params,
  }) {
    final data = {
      "model": model,
      "prompt": prompt,
      "stream": true,
      ...?params?.toMap(),
    };

    final eventSource = EventSource(OpenAI.getUri(_path), ApiMethod.post);

    eventSource.setHeaders(OpenAI.instance.headers);

    final stream = eventSource.send(body: json.encode(data));

    return _transform(stream, eventSource);
  }

  static Stream<CompletionResponse> streamChat({
    List<Map<String, String>> messages = const [],
    ChatCompletionParams? params,
  }) {
    final data = {
      "model": _turboModel,
      "messages": messages,
      "stream": true,
      ...?params?.toMap(),
    };

    final eventSource =
        EventSource(OpenAI.getUri("/chat$_path"), ApiMethod.post);

    eventSource.setHeaders(OpenAI.instance.headers);

    final stream = eventSource.send(body: json.encode(data));

    return _transform(stream, eventSource);
  }

  static Stream<CompletionResponse> _transform(
      Stream<BaseChunk> stream, EventSource eventSource) {
    return stream.transform(
      StreamTransformer.fromHandlers(
        handleData: (data, sink) {
          final chunkJson = _extractData(data, eventSource.isWeb);

          if (chunkJson != null) {
            if (chunkJson["error"] != null) {
              sink.addError(chunkJson);
              sink.close();
              eventSource.close(force: true);
            } else {
              sink.add(CompletionResponse.fromMap(chunkJson));
            }
          } else {
            sink.close();
            eventSource.close();
          }
        },
      ),
    );
  }

  static Map<String, dynamic>? _extractData(BaseChunk chunk, bool isWeb) {
    String decoded;
    if (isWeb) {
      decoded = chunk.chunk as String;
    } else {
      final encoding = chunk.getEncoding();

      decoded = encoding.decode(chunk.chunk as List<int>);
    }

    // the error message would not have 'data: ' prefix
    if (decoded.startsWith(_streamPrefix)) {
      decoded = decoded.substring(_streamPrefix.length);
    }

    // the final chunk would come with 'data: [DONE]' together
    // instead of have a separated chunk for 'data: [DONE]'
    try {
      return json.decode(decoded);
    } catch (e) {
      return null;
    }
  }
}
