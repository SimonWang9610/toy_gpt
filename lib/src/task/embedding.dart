import 'dart:convert';

import 'package:simple_http_api/simple_http_api.dart';
import 'package:toy_gpt/toy_gpt.dart';

class EmbeddingTask {
  static Future<EmbeddingResponse> create({
    required List<String> inputs,
    required String model,
    String? user,
  }) async {
    final data = {
      "input": inputs,
      "model": model,
      if (user != null) "user": user,
    };

    final res = await Api.post(
      OpenAI.getUri("/embeddings"),
      body: json.encode(data),
      headers: OpenAI.instance.headers,
      options: OpenAI.instance.connectionOption,
    );

    if (res.statusCode != 200) throw Exception(res.body);

    print(res.body);

    return EmbeddingResponse.fromMap(json.decode(res.body));
  }
}
