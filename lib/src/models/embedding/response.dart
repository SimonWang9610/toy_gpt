import 'embedding.dart';
import '../token_usage.dart';

class EmbeddingResponse {
  final String object;
  final String model;
  final TokenUsage usage;
  final List<Embedding> data;

  const EmbeddingResponse({
    required this.model,
    required this.object,
    required this.usage,
    this.data = const [],
  });

  factory EmbeddingResponse.fromMap(Map<String, dynamic> map) {
    final List<Map<String, dynamic>> data =
        (map["data"] as List<dynamic>).cast();

    return EmbeddingResponse(
      model: map["model"] as String,
      object: map["object"] as String,
      usage: TokenUsage.fromMap(map["usage"] as Map<String, dynamic>),
      data: data.map((e) => Embedding.fromMap(e)).toList(),
    );
  }
}
