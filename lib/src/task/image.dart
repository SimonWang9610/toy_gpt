import 'dart:convert';
import 'package:path/path.dart';

import 'package:simple_http_api/simple_http_api.dart';

import 'package:toy_gpt/toy_gpt.dart';

class ImageTask {
  static Future<ImageResponse> generate({
    required ImageParams params,
  }) async {
    final res = await Api.post(
      OpenAI.getUri("/images/generations"),
      headers: OpenAI.instance.headers,
      options: OpenAI.instance.connectionOption,
      body: json.encode(params.toMap()),
    );

    if (res.statusCode != 200) throw Exception(res.body);

    return ImageResponse.fromMap(json.decode(res.body));
  }

  static Future<ImageResponse> editFromPath({
    required ImageParams params,
    required String imagePath,
    String? maskPath,
  }) async {
    final imageFile = await FormData.fileFromPath(
      imagePath,
      field: "image",
      filename: basename(imagePath),
    );

    final maskFile = maskPath != null
        ? await FormData.fileFromPath(
            maskPath,
            field: "mask",
            filename: basename(maskPath),
          )
        : null;

    final formData = FormData();

    formData.addFile(imageFile);
    if (maskFile != null) {
      formData.addFile(maskFile);
    }

    final fields = params.toMap().map((key, value) {
      return MapEntry(key, value.toString());
    });

    formData.addFields(fields);

    final res = await Api.upload(
      OpenAI.getUri("/images/edits"),
      formData,
      headers: OpenAI.instance.headers,
      options: OpenAI.instance.connectionOption,
    );

    if (res.statusCode != 200) throw Exception(res.body);

    return ImageResponse.fromMap(json.decode(res.body));
  }

  static Future<ImageResponse> variation({
    required String imagePath,
    required VariationParams params,
  }) async {
    final imageFile = await FormData.fileFromPath(
      imagePath,
      field: "image",
      filename: basename(imagePath),
    );

    final formData = FormData();
    final fields = params.toMap().map((key, value) {
      return MapEntry(key, value.toString());
    });
    formData.addFields(fields);

    formData.addFile(imageFile);

    final res = await Api.upload(
      OpenAI.getUri("/images/variations"),
      formData,
      headers: OpenAI.instance.headers,
      options: OpenAI.instance.connectionOption,
    );

    if (res.statusCode != 200) throw Exception(res.body);

    return ImageResponse.fromMap(json.decode(res.body));
  }
}
