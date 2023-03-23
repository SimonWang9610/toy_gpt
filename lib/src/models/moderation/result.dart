// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:toy_gpt/src/models/moderation/score.dart';

import 'category.dart';

class ModerationResult {
  final ModerationCategory category;
  final CategoryScore scores;
  final bool flagged;
  ModerationResult({
    required this.category,
    required this.scores,
    required this.flagged,
  });

  ModerationResult copyWith({
    ModerationCategory? category,
    CategoryScore? scores,
    bool? flagged,
  }) {
    return ModerationResult(
      category: category ?? this.category,
      scores: scores ?? this.scores,
      flagged: flagged ?? this.flagged,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'category': category.toMap(),
      'scores': scores.toMap(),
      'flagged': flagged,
    };
  }

  factory ModerationResult.fromMap(Map<String, dynamic> map) {
    return ModerationResult(
      category:
          ModerationCategory.fromMap(map['categories'] as Map<String, dynamic>),
      scores:
          CategoryScore.fromMap(map['category_scores'] as Map<String, dynamic>),
      flagged: map['flagged'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory ModerationResult.fromJson(String source) =>
      ModerationResult.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ModerationResult(category: $category, scores: $scores, flagged: $flagged)';

  @override
  bool operator ==(covariant ModerationResult other) {
    if (identical(this, other)) return true;

    return other.category == category &&
        other.scores == scores &&
        other.flagged == flagged;
  }

  @override
  int get hashCode => category.hashCode ^ scores.hashCode ^ flagged.hashCode;
}
