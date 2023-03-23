// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TokenUsage {
  final int prompt;
  final int total;

  const TokenUsage({
    required this.prompt,
    required this.total,
  });

  factory TokenUsage.fromMap(Map<String, dynamic> map) {
    return TokenUsage(
      prompt: map['prompt_tokens'] as int,
      total: map['total_tokens'] as int,
    );
  }

  TokenUsage copyWith({
    int? prompt,
    int? total,
  }) {
    return TokenUsage(
      prompt: prompt ?? this.prompt,
      total: total ?? this.total,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'prompt': prompt,
      'total': total,
    };
  }

  String toJson() => json.encode(toMap());

  factory TokenUsage.fromJson(String source) =>
      TokenUsage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'TokenUsage(prompt: $prompt, total: $total)';

  @override
  bool operator ==(covariant TokenUsage other) {
    if (identical(this, other)) return true;

    return other.prompt == prompt && other.total == total;
  }

  @override
  int get hashCode => prompt.hashCode ^ total.hashCode;
}

class CompletionUsage extends TokenUsage {
  final int completion;

  const CompletionUsage({
    required this.completion,
    required super.prompt,
    required super.total,
  });

  factory CompletionUsage.fromMap(Map<String, dynamic> map) {
    return CompletionUsage(
      prompt: map['prompt_tokens'] as int,
      total: map['total_tokens'] as int,
      completion: map["completion_tokens"] as int,
    );
  }
}
