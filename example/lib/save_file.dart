import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<String?> get _localPath async {
  final directory = await getDownloadsDirectory();

  return directory?.path;
}

Future<String?> saveFile(List<dynamic> data) async {
  final path = await _localPath;

  if (path != null) {
    final file = File('$path/data.jsonl');

    final sink = file.openWrite();

    for (final item in data) {
      sink.writeln(json.encode(item));
    }

    sink.close();

    return file.path;
  }
  return null;
}
