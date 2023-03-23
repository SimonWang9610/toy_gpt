import 'dart:convert';

abstract class Choice {
  final int index;
  final String? finishReason;

  const Choice({
    required this.index,
    this.finishReason,
  });

  String get body;

  factory Choice.fromMap(Map<String, dynamic> map) {
    final int index = map["index"] as int;
    final String? finishReason = map["finish_reason"] as String?;

    if (map.containsKey("message") || map.containsKey("delta")) {
      return ChatChoice.fromMap(
        map["message"] ?? map["delta"],
        index: index,
        finishReason: finishReason,
      );
    } else {
      return TextChoice.fromMap(
        map,
        index: index,
        finishReason: finishReason,
      );
    }
  }

  factory Choice.fromJson(String source) => Choice.fromMap(json.decode(source));

  Map<String, dynamic> toMap();
}

class ChatChoice extends Choice {
  final String? role;
  final String? content;

  const ChatChoice({
    required this.role,
    required this.content,
    required super.index,
    super.finishReason,
  });

  @override
  String get body => content ?? "";

  factory ChatChoice.fromMap(
    Map<String, dynamic> map, {
    required int index,
    String? finishReason,
  }) {
    return ChatChoice(
      role: map["role"],
      content: map["content"],
      index: index,
      finishReason: finishReason,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "index": index,
      "role": role,
      "content": content,
      "finish_reason": finishReason,
    };
  }
}

class TextChoice extends Choice {
  final String text;
  final int? logProb;

  const TextChoice({
    required this.text,
    required super.index,
    super.finishReason,
    this.logProb,
  });

  @override
  String get body => text;

  factory TextChoice.fromMap(
    Map<String, dynamic> map, {
    required int index,
    String? finishReason,
  }) {
    return TextChoice(
      text: map["text"],
      index: index,
      finishReason: finishReason,
      logProb: map["logprobs"] != null ? int.tryParse(map["logprobs"]!) : null,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "index": index,
      "text": text,
      "finish_reason": finishReason,
      "logprobs": logProb,
    };
  }
}
