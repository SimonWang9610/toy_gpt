import 'dart:convert';

import 'package:toy_gpt/toy_gpt.dart';
import 'package:simple_http_api/simple_http_api.dart';

class ModerationTask {
  static Future<ModerationResponse> create({
    required String input,
    String? model,
  }) async {
    final data = {
      "input": input,
      if (model != null) "model": model,
    };

    final res = await Api.post(
      OpenAI.getUri("/moderations"),
      headers: OpenAI.instance.headers,
      options: OpenAI.instance.connectionOption,
      body: json.encode(data),
    );

    print(res.body);

    if (res.statusCode != 200) throw Exception(res.body);

    return ModerationResponse.fromJson(res.body);
  }
}
