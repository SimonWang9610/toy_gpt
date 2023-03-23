// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class HyperParameter {
  final int batchSize;
  final double learningRate;
  final int epochs;
  final double lossWeight;
  HyperParameter({
    required this.batchSize,
    required this.learningRate,
    required this.epochs,
    required this.lossWeight,
  });

  HyperParameter copyWith({
    int? batchSize,
    double? learningRate,
    int? epochs,
    double? lossWeight,
  }) {
    return HyperParameter(
      batchSize: batchSize ?? this.batchSize,
      learningRate: learningRate ?? this.learningRate,
      epochs: epochs ?? this.epochs,
      lossWeight: lossWeight ?? this.lossWeight,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'batch_size': batchSize,
      'learning_rate_multiplier': learningRate,
      'n_epochs': epochs,
      'prompt_loss_weight': lossWeight,
    };
  }

  factory HyperParameter.fromMap(Map<String, dynamic> map) {
    return HyperParameter(
      batchSize: map['batch_size'] as int,
      learningRate: map['learning_rate_multiplier'] as double,
      epochs: map['n_epochs'] as int,
      lossWeight: map['prompt_loss_weight'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory HyperParameter.fromJson(String source) =>
      HyperParameter.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'HyperParameter(batchSize: $batchSize, learningRate: $learningRate, epochs: $epochs, lossWeight: $lossWeight)';
  }

  @override
  bool operator ==(covariant HyperParameter other) {
    if (identical(this, other)) return true;

    return other.batchSize == batchSize &&
        other.learningRate == learningRate &&
        other.epochs == epochs &&
        other.lossWeight == lossWeight;
  }

  @override
  int get hashCode {
    return batchSize.hashCode ^
        learningRate.hashCode ^
        epochs.hashCode ^
        lossWeight.hashCode;
  }
}
