import 'dart:async';
import 'dart:convert';
import 'package:path/path.dart';

import 'package:simple_http_api/simple_http_api.dart';
import 'package:toy_gpt/toy_gpt.dart';

class FileTask {
  static const _field = "file";

  static Future<FileUnit> uploadFromStream({
    required String purpose,
    required Stream<List<int>> stream,
    String? filename,
    int? length,
  }) async {
    final file = FormData.fileFromStream(
      stream,
      field: _field,
      filename: filename,
      length: length ?? (await stream.length),
    );

    return _upload(purpose: purpose, file: file);
  }

  // only support native platforms
  static Future<FileUnit> uploadFromPath({
    required String purpose,
    required String filePath,
    bool useIsolate = false,
  }) async {
    final file = await FormData.fileFromPath(
      filePath,
      field: _field,
      filename: basename(filePath),
    );

    return _upload(
      purpose: purpose,
      file: file,
      useIsolate: useIsolate,
    );
  }

  static Future<Map<String, dynamic>> deleteFile(String fileId) async {
    final res = await Api.delete(
      OpenAI.getUri("/files/$fileId"),
      options: OpenAI.instance.connectionOption,
      headers: OpenAI.instance.headers,
    );
    if (res.statusCode != 200) throw Exception(res.body);

    return json.decode(res.body);
  }

  static Future<FileUnit> retrieveFile(String fileId) async {
    final res = await Api.get(
      OpenAI.getUri("/files/$fileId"),
      options: OpenAI.instance.connectionOption,
      headers: OpenAI.instance.headers,
    );

    if (res.statusCode != 200) throw Exception(res.body);

    return FileUnit.fromJson(res.body);
  }

  static Future<List<FileUnit>> listFiles() async {
    final res = await Api.get(
      OpenAI.getUri("/files"),
      options: OpenAI.instance.connectionOption,
      headers: OpenAI.instance.headers,
    );

    final dataList = (json.decode(res.body) as Map<String, dynamic>)["data"]
        as List<dynamic>;

    return dataList.map((e) => FileUnit.fromMap(e)).toList();
  }

  static Future<FileUnit> _upload({
    required String purpose,
    required MultipartFile file,
    bool useIsolate = false,
  }) async {
    try {
      final formData = FormData();

      formData.addFile(file);

      formData.addFields({"purpose": purpose});

      final res = await Api.upload(
        OpenAI.getUri("/files"),
        formData,
        options: OpenAI.instance.connectionOption,
        headers: OpenAI.instance.headers,
        useIsolate: useIsolate,
      );

      if (res.statusCode != 200) throw Exception(res.body);

      return FileUnit.fromJson(res.body);
    } catch (e) {
      rethrow;
    }
  }

  // static Future<FileUnit> _uploadParallel(
  //     {required String purpose, required String filePath}) async {
  //   return useIsolate<FileUnit, Map<String, dynamic>>(
  //     {
  //       "filePath": filePath,
  //       "purpose": purpose,
  //     },
  //     _uploadComputation,
  //     toJson: FileUnit.serialize,
  //     fromJson: FileUnit.fromJson,
  //   );
  // }

  // static Future<FileUnit> _uploadComputation(Map<String, dynamic> map) async {
  //   final file = await FormData.fileFromPath(map["filePath"], field: "file");
  //   final purpose = map["purpose"];

  //   return _upload(purpose: purpose, file: file);
  // }
}
