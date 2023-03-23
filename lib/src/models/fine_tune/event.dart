// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FineTuneEvent {
  final String object;
  final int createdAt;
  final String level;
  final String message;
  FineTuneEvent({
    required this.object,
    required this.createdAt,
    required this.level,
    required this.message,
  });

  FineTuneEvent copyWith({
    String? object,
    int? createdAt,
    String? level,
    String? message,
  }) {
    return FineTuneEvent(
      object: object ?? this.object,
      createdAt: createdAt ?? this.createdAt,
      level: level ?? this.level,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'object': object,
      'createdAt': createdAt,
      'level': level,
      'message': message,
    };
  }

  factory FineTuneEvent.fromMap(Map<String, dynamic> map) {
    return FineTuneEvent(
      object: map['object'] as String,
      createdAt: map['created_at'] as int,
      level: map['level'] as String,
      message: map['message'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FineTuneEvent.fromJson(String source) =>
      FineTuneEvent.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FineTuneEvent(object: $object, createdAt: $createdAt, level: $level, message: $message)';
  }

  @override
  bool operator ==(covariant FineTuneEvent other) {
    if (identical(this, other)) return true;

    return other.object == object &&
        other.createdAt == createdAt &&
        other.level == level &&
        other.message == message;
  }

  @override
  int get hashCode {
    return object.hashCode ^
        createdAt.hashCode ^
        level.hashCode ^
        message.hashCode;
  }
}
