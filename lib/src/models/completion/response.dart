// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'choice.dart';
import '../token_usage.dart';

const String _kDefaultIdForEdit = "defaultIdForEdit";

class CompletionResponse {
  final String object;
  final int created;
  final String id;
  final String? model;
  final List<Choice> choices;
  final CompletionUsage? usage;
  CompletionResponse({
    required this.object,
    required this.created,
    required this.id,
    required this.choices,
    this.usage,
    this.model,
  });

  CompletionResponse copyWith({
    String? object,
    int? created,
    String? id,
    String? model,
    List<Choice>? choices,
    CompletionUsage? usage,
  }) {
    return CompletionResponse(
      object: object ?? this.object,
      created: created ?? this.created,
      id: id ?? this.id,
      model: model ?? this.model,
      choices: choices ?? this.choices,
      usage: usage ?? this.usage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'object': object,
      'created': created,
      'id': id,
      'model': model,
      'choices': choices.map((x) => x.toMap()).toList(),
      'usage': usage?.toMap(),
    };
  }

  factory CompletionResponse.fromMap(Map<String, dynamic> map) {
    return CompletionResponse(
      object: map['object'] as String,
      created: map['created'] as int,
      id: map['id'] != null ? map["id"] as String : _kDefaultIdForEdit,
      model: map['model'] != null ? map['model'] as String : null,
      choices: (map["choices"] as List<dynamic>)
          .map(
            (e) => Choice.fromMap(e as Map<String, dynamic>),
          )
          .toList(),
      usage: map["usage"] != null
          ? CompletionUsage.fromMap(map['usage'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CompletionResponse.fromJson(String source) =>
      CompletionResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CompletionResponse(object: $object, created: $created, id: $id, model: $model, choices: $choices, usage: $usage)';
  }
}
