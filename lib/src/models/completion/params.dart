// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ChatCompletionParams {
  final double temperature;
  final double topProbability;
  final int choiceCount;
  final List<String>? stops;
  final int maxTokens;
  final double presencePenalty;
  final double frequencyPenalty;
  final Map<String, dynamic>? logitBias;
  final String? user;
  ChatCompletionParams({
    this.temperature = 1,
    this.topProbability = 1,
    this.choiceCount = 1,
    this.stops,
    this.maxTokens = 16,
    this.presencePenalty = 0,
    this.frequencyPenalty = 0,
    this.logitBias,
    this.user,
  });

  ChatCompletionParams copyWith({
    double? temperature,
    double? topProbability,
    int? choiceCount,
    List<String>? stops,
    int? maxTokens,
    double? presencePenalty,
    double? frequencyPenalty,
    Map<String, dynamic>? logitBias,
    String? user,
  }) {
    return ChatCompletionParams(
      temperature: temperature ?? this.temperature,
      topProbability: topProbability ?? this.topProbability,
      choiceCount: choiceCount ?? this.choiceCount,
      stops: stops ?? this.stops,
      maxTokens: maxTokens ?? this.maxTokens,
      presencePenalty: presencePenalty ?? this.presencePenalty,
      frequencyPenalty: frequencyPenalty ?? this.frequencyPenalty,
      logitBias: logitBias ?? this.logitBias,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'temperature': temperature,
      'top_p': topProbability,
      'n': choiceCount,
      'max_tokens': maxTokens,
      'presence_penalty': presencePenalty,
      'frequency_penalty': frequencyPenalty,
      if (stops != null) 'stop': stops,
      if (user != null) 'user': user,
      if (logitBias != null) 'logit_bias': logitBias,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'CompletionParams(temperature: $temperature, topProbability: $topProbability, choiceCount: $choiceCount, stops: $stops, maxTokens: $maxTokens, presencePenalty: $presencePenalty, frequencyPenalty: $frequencyPenalty, logitBias: $logitBias, user: $user)';
  }
}

class CompletionParamsV3 extends ChatCompletionParams {
  final String? suffix;
  final bool echo;
  final int? logProbs;
  final int bestOf;

  CompletionParamsV3({
    this.suffix,
    this.logProbs,
    this.echo = false,
    this.bestOf = 1,
    super.choiceCount,
    super.frequencyPenalty,
    super.presencePenalty,
    super.maxTokens,
    super.logitBias,
    super.stops,
    super.temperature,
    super.topProbability,
    super.user,
  });

  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();

    map["echo"] = echo;
    map["best_of"] = bestOf;

    if (suffix != null) {
      map["suffix"] = suffix;
    }
    if (logProbs != null) {
      map["logprobs"] = logProbs;
    }

    return map;
  }
}
