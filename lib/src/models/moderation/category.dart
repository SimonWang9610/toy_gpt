// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ModerationCategory {
  final bool hate;
  final bool hateThreatening;
  final bool selfHarm;
  final bool sexual;
  final bool sexualMinors;
  final bool violence;
  final bool violenceGraphic;
  ModerationCategory({
    required this.hate,
    required this.hateThreatening,
    required this.selfHarm,
    required this.sexual,
    required this.sexualMinors,
    required this.violence,
    required this.violenceGraphic,
  });

  ModerationCategory copyWith({
    bool? hate,
    bool? hateThreatening,
    bool? selfHarm,
    bool? sexual,
    bool? sexualMinors,
    bool? violence,
    bool? violenceGraphic,
  }) {
    return ModerationCategory(
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

  factory ModerationCategory.fromMap(Map<String, dynamic> map) {
    return ModerationCategory(
      hate: map['hate'] as bool,
      hateThreatening: map['hate/threatening'] as bool,
      selfHarm: map['self-harm'] as bool,
      sexual: map['sexual'] as bool,
      sexualMinors: map['sexual/minors'] as bool,
      violence: map['violence'] as bool,
      violenceGraphic: map['violence/graphic'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory ModerationCategory.fromJson(String source) =>
      ModerationCategory.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ModerationCategory(hate: $hate, hateThreatening: $hateThreatening, selfHarm: $selfHarm, sexual: $sexual, sexualMinors: $sexualMinors, violence: $violence, violenceGraphic: $violenceGraphic)';
  }

  @override
  bool operator ==(covariant ModerationCategory other) {
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
