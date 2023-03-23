// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:toy_gpt/src/models/moderation/result.dart';

class ModerationResponse {
  final String id;
  final String model;
  final List<ModerationResult> results;
  ModerationResponse({
    required this.id,
    required this.model,
    required this.results,
  });

  ModerationResponse copyWith({
    String? id,
    String? model,
    List<ModerationResult>? results,
  }) {
    return ModerationResponse(
      id: id ?? this.id,
      model: model ?? this.model,
      results: results ?? this.results,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'model': model,
      'results': results.map((x) => x.toMap()).toList(),
    };
  }

  factory ModerationResponse.fromMap(Map<String, dynamic> map) {
    return ModerationResponse(
      id: map['id'] as String,
      model: map['model'] as String,
      results: List<ModerationResult>.from(
        (map['results'] as List<dynamic>).map<ModerationResult>(
          (x) => ModerationResult.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ModerationResponse.fromJson(String source) =>
      ModerationResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ModerationResponse(id: $id, model: $model, results: $results)';
}
