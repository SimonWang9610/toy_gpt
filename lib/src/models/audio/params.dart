import 'enums.dart';

class TranscriptionParams {
  final String? prompt;
  final String? user;
  final double temperature;

  final String? language;
  final AudioResponseFormat format;

  const TranscriptionParams({
    this.prompt,
    this.user,
    this.language,
    this.temperature = 0,
    this.format = AudioResponseFormat.json,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (prompt != null) 'prompt': prompt,
      if (user != null) 'user': user,
      if (language != null) 'language': language,
      'temperature': temperature,
      "response_format": format.value,
    };
  }
}

class TranslationParams {
  final String? prompt;
  final String? user;
  final double temperature;
  final AudioResponseFormat format;

  const TranslationParams({
    this.prompt,
    this.user,
    this.temperature = 0,
    this.format = AudioResponseFormat.json,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (prompt != null) 'prompt': prompt,
      if (user != null) 'user': user,
      "response_format": format.value,
      'temperature': temperature,
    };
  }
}
