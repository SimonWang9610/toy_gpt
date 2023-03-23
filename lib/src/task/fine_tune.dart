import 'dart:convert';

import 'package:simple_http_api/simple_http_api.dart';
import 'package:toy_gpt/toy_gpt.dart';

class FineTuneTask {
  static const _path = "/fine-tunes";

  static Future<FineTuneResponse> create({
    required String fileId,
    String? model,
    String? suffix,
    String? validationFileId,
    HyperParameter? hyperParameter,
  }) async {
    final data = {
      "training_file": fileId,
      if (model != null) "model": model,
      if (suffix != null) "suffix": suffix,
      if (validationFileId != null) "validation_file": validationFileId,
      if (hyperParameter != null) ...hyperParameter.toMap(),
    };

    final res = await Api.post(
      OpenAI.getUri(_path),
      headers: OpenAI.instance.headers,
      options: OpenAI.instance.connectionOption,
      body: json.encode(data),
    );

    if (res.statusCode != 200) throw Exception(res.body);

    return FineTuneResponse.fromJson(res.body);
  }

  static Future<List<FineTuneResponse>> retrieveTasks() async {
    final res = await Api.get(
      OpenAI.getUri(_path),
      headers: OpenAI.instance.headers,
      options: OpenAI.instance.connectionOption,
    );

    if (res.statusCode != 200) throw Exception(res.body);

    final dataList =
        json.decode(res.body)["data"] as List<Map<String, dynamic>>;

    return dataList.map((task) => FineTuneResponse.fromMap(task)).toList();
  }

  static Future<FineTuneResponse> retrieveTask(String taskId) async {
    final res = await Api.get(
      OpenAI.getUri("$_path/$taskId"),
      headers: OpenAI.instance.headers,
      options: OpenAI.instance.connectionOption,
    );

    return FineTuneResponse.fromJson(res.body);
  }

  static Future<FineTuneResponse> cancel(String taskId) async {
    final res = await Api.post(
      OpenAI.getUri(_path),
      headers: OpenAI.instance.headers,
      options: OpenAI.instance.connectionOption,
      body: json.encode({
        "fine_tune_id": taskId,
      }),
    );

    if (res.statusCode != 200) throw Exception(res.body);

    return FineTuneResponse.fromJson(res.body);
  }

  static Future<List<FineTuneEvent>> retrieveEvents(String taskId) async {
    final res = await Api.get(
      OpenAI.getUri("$_path/$taskId/events"),
      headers: OpenAI.instance.headers,
      options: OpenAI.instance.connectionOption,
    );

    if (res.statusCode != 200) throw Exception(res.body);

    final eventList =
        json.decode(res.body)["data"] as List<Map<String, dynamic>>;

    return eventList.map((e) => FineTuneEvent.fromMap(e)).toList();
  }

  static Future<Map<String, dynamic>> deleteModel(String model) async {
    final res = await Api.delete(
      OpenAI.getUri("/models/$model"),
      headers: OpenAI.instance.headers,
      options: OpenAI.instance.connectionOption,
    );

    if (res.statusCode != 200) throw Exception(res.body);

    return json.decode(res.body);
  }
}
