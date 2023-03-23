// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:typed_data';

class ImageResponse {
  final int created;
  final List<String> urls;
  final List<Uint8List> imagesBytes;

  const ImageResponse({
    required this.created,
    this.urls = const [],
    this.imagesBytes = const [],
  });

  factory ImageResponse.fromMap(Map<String, dynamic> map) {
    final List<Map<String, dynamic>> data =
        (map["data"] as List<dynamic>).cast();

    final List<String> urls = [];
    final List<Uint8List> imagesBytes = [];

    for (final item in data) {
      if (item.containsKey("url")) {
        urls.add(item["url"]);
      } else if (item.containsKey("b64_json")) {
        imagesBytes.add(
          base64.decode(item["b64_json"] as String),
        );
      }
    }
    return ImageResponse(
      created: map["created"] as int,
      urls: urls,
      imagesBytes: imagesBytes,
    );
  }

  @override
  String toString() =>
      'ImageResponse(created: $created, urls: $urls, imagesBytes: $imagesBytes)';
}
