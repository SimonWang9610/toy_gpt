// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FileUnit {
  final String id;
  final String object;
  final int bytes;
  final int createdAt;
  final String filename;
  final String purpose;
  FileUnit({
    required this.id,
    required this.object,
    required this.bytes,
    required this.createdAt,
    required this.filename,
    required this.purpose,
  });

  FileUnit copyWith({
    String? id,
    String? object,
    int? bytes,
    int? createdAt,
    String? filename,
    String? purpose,
  }) {
    return FileUnit(
      id: id ?? this.id,
      object: object ?? this.object,
      bytes: bytes ?? this.bytes,
      createdAt: createdAt ?? this.createdAt,
      filename: filename ?? this.filename,
      purpose: purpose ?? this.purpose,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'object': object,
      'bytes': bytes,
      'createdAt': createdAt,
      'filename': filename,
      'purpose': purpose,
    };
  }

  static Map<String, dynamic> serialize(FileUnit unit) => unit.toMap();

  factory FileUnit.fromMap(Map<String, dynamic> map) {
    return FileUnit(
      id: map['id'] as String,
      object: map['object'] as String,
      bytes: map['bytes'] as int,
      createdAt: map['created_at'] as int,
      filename: map['filename'] as String,
      purpose: map['purpose'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FileUnit.fromJson(String source) =>
      FileUnit.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FileUnit(id: $id, object: $object, bytes: $bytes, createdAt: $createdAt, filename: $filename, purpose: $purpose)';
  }

  @override
  bool operator ==(covariant FileUnit other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.object == object &&
        other.bytes == bytes &&
        other.createdAt == createdAt &&
        other.filename == filename &&
        other.purpose == purpose;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        object.hashCode ^
        bytes.hashCode ^
        createdAt.hashCode ^
        filename.hashCode ^
        purpose.hashCode;
  }
}
