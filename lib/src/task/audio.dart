import 'package:path/path.dart';
import 'package:simple_http_api/simple_http_api.dart';
import 'package:toy_gpt/toy_gpt.dart';

class AudioTask {
  static const _audioModel = "whisper-1";

  static Future<dynamic> transcript({
    required String filePath,
    required TranscriptionParams params,
  }) async {
    final audioFile = await FormData.fileFromPath(
      filePath,
      field: "file",
      filename: basename(filePath),
    );

    final formData = FormData();

    formData.addFile(audioFile);
    formData.addFields({
      "model": _audioModel,
      ...params.toMap(),
    });

    final res = await Api.upload(
      OpenAI.getUri("/audio/transcriptions"),
      formData,
      headers: OpenAI.instance.headers,
      options: OpenAI.instance.connectionOption,
    );

    if (res.statusCode != 200) throw Exception(res.body);

    return res.body;
  }

  static Future<dynamic> translate({
    required String filePath,
    required TranslationParams params,
  }) async {
    final audioFile = await FormData.fileFromPath(
      filePath,
      field: "file",
      filename: basename(filePath),
    );

    final formData = FormData();

    formData.addFile(audioFile);
    formData.addFields({
      "model": _audioModel,
      ...params.toMap(),
    });

    final res = await Api.upload(
      OpenAI.getUri("/audio/transcriptions"),
      formData,
      headers: OpenAI.instance.headers,
      options: OpenAI.instance.connectionOption,
    );

    if (res.statusCode != 200) throw Exception(res.body);

    return res.body;
  }
}
