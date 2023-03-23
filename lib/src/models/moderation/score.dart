// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CategoryScore {
  final double hate;
  final double hateThreatening;
  final double selfHarm;
  final double sexual;
  final double sexualMinors;
  final double violence;
  final double violenceGraphic;
  CategoryScore({
    required this.hate,
    required this.hateThreatening,
    required this.selfHarm,
    required this.sexual,
    required this.sexualMinors,
    required this.violence,
    required this.violenceGraphic,
  });

  CategoryScore copyWith({
    double? hate,
    double? hateThreatening,
    double? selfHarm,
    double? sexual,
    double? sexualMinors,
    double? violence,
    double? violenceGraphic,
  }) {
    return CategoryScore(
      hate: hate ?? this.hate,
      hateThreatening: hateThreatening ?? this.hateThreatening,
      selfHarm: selfHarm ?? this.selfHarm,
      sexual: sexual ?? this.sexual,
      sexualMinors: sexualMinors ?? this.sexualMinors,
      violence: violence ?? this.violence,
      violenceGraphic: violenceGraphic ?? this.violenceGraphic,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'hate': hate,
      'hateThreatening': hateThreatening,
      'selfHarm': selfHarm,
      'sexual': sexual,
      'sexualMinors': sexualMinors,
      'violence': violence,
      'violenceGraphic': violenceGraphic,
    };
  }

  factory CategoryScore.fromMap(Map<String, dynamic> map) {
    return CategoryScore(
      hate: map['hate'] as double,
      hateThreatening: map['hate/threatening'] as double,
      selfHarm: map['self-harm'] as double,
      sexual: map['sexual'] as double,
      sexualMinors: map['sexual/minors'] as double,
      violence: map['violence'] as double,
      violenceGraphic: map['violence/graphic'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryScore.fromJson(String source) =>
      CategoryScore.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CategoryScore(hate: $hate, hateThreatening: $hateThreatening, selfHarm: $selfHarm, sexual: $sexual, sexualMinors: $sexualMinors, violence: $violence, violenceGraphic: $violenceGraphic)';
  }

  @override
  bool operator ==(covariant CategoryScore other) {
    if (identical(this, other)) return true;

    return other.hate == hate &&
        other.hateThreatening == hateThreatening &&
        other.selfHarm == selfHarm &&
        other.sexual == sexual &&
        other.sexualMinors == sexualMinors &&
        other.violence == violence &&
        other.violenceGraphic == violenceGraphic;
  }

  @override
  int get hashCode {
    return hate.hashCode ^
        hateThreatening.hashCode ^
        selfHarm.hashCode ^
        sexual.hashCode ^
        sexualMinors.hashCode ^
        violence.hashCode ^
        violenceGraphic.hashCode;
  }
}
