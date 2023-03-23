// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:toy_gpt/src/models/fine_tune/event.dart';
import 'package:toy_gpt/src/models/fine_tune/file_unit.dart';
import 'package:toy_gpt/src/models/fine_tune/hyper_parameter.dart';

class FineTuneResponse {
  final String id;
  final String object;
  final String model;
  final int createdAt;
  final int updatedAt;
  final String? fineTunedModel;
  final String organizationId;
  final String status;
  final HyperParameter hyperParams;
  final List<FileUnit> validationFiles;
  final List<FileUnit> trainingFiles;
  final List<FileUnit> resultFiles;
  final List<FineTuneEvent> events;
  FineTuneResponse({
    required this.id,
    required this.model,
    required this.object,
    required this.createdAt,
    required this.updatedAt,
    required this.organizationId,
    required this.status,
    required this.hyperParams,
    required this.validationFiles,
    required this.trainingFiles,
    required this.resultFiles,
    required this.events,
    this.fineTunedModel,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'object': object,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'fineTunedModel': fineTunedModel,
      'organizationId': organizationId,
      'status': status,
      'model': model,
      'hyperParams': hyperParams.toMap(),
      'validationFiles': validationFiles.map((x) => x.toMap()).toList(),
      'trainingFiles': trainingFiles.map((x) => x.toMap()).toList(),
      'resultFiles': resultFiles.map((x) => x.toMap()).toList(),
      'events': events.map((x) => x.toMap()).toList(),
    };
  }

  factory FineTuneResponse.fromMap(Map<String, dynamic> map) {
    return FineTuneResponse(
      id: map['id'] as String,
      object: map['object'] as String,
      model: map["model"] as String,
      createdAt: map['created_at'] as int,
      updatedAt: map['updated_at'] as int,
      fineTunedModel: map['fine_tuned_model'] as String?,
      organizationId: map['organization_id'] as String,
      status: map['status'] as String,
      hyperParams:
          HyperParameter.fromMap(map['hyperparams'] as Map<String, dynamic>),
      validationFiles: List<FileUnit>.from(
        (map['validation_files'] as List<dynamic>).map<FileUnit>(
          (x) => FileUnit.fromMap(x as Map<String, dynamic>),
        ),
      ),
      trainingFiles: List<FileUnit>.from(
        (map['training_files'] as List<dynamic>).map<FileUnit>(
          (x) => FileUnit.fromMap(x as Map<String, dynamic>),
        ),
      ),
      resultFiles: List<FileUnit>.from(
        (map['result_files'] as List<dynamic>).map<FileUnit>(
          (x) => FileUnit.fromMap(x as Map<String, dynamic>),
        ),
      ),
      events: List<FineTuneEvent>.from(
        (map['events'] as List<dynamic>).map<FineTuneEvent>(
          (x) => FineTuneEvent.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory FineTuneResponse.fromJson(String source) =>
      FineTuneResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FineTuneResponse(id: $id, model: $model, object: $object, createdAt: $createdAt, updatedAt: $updatedAt, fineTunedModel: $fineTunedModel, organizationId: $organizationId, status: $status, hyperParams: $hyperParams, validationFiles: $validationFiles, trainingFiles: $trainingFiles, resultFiles: $resultFiles, events: $events)';
  }
}
