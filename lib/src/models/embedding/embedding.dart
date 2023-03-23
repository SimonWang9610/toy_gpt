class Embedding {
  final String object;
  final List<double> embedding;
  final int index;

  const Embedding({
    required this.index,
    required this.object,
    this.embedding = const [],
  });

  factory Embedding.fromMap(Map<String, dynamic> map) {
    return Embedding(
      index: map["index"] as int,
      object: map["object"] as String,
      embedding: (map["embedding"] as List<dynamic>).cast(),
    );
  }
}
