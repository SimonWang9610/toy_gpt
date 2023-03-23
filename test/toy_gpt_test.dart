import 'dart:convert';

import 'package:toy_gpt/src/models/audio/enums.dart';
import 'package:toy_gpt/src/models/audio/params.dart';
import 'package:toy_gpt/src/models/image/params.dart';
import 'package:toy_gpt/src/task/audio.dart';
import 'package:toy_gpt/src/task/embedding.dart';
import 'package:toy_gpt/src/task/image.dart';
import 'package:toy_gpt/src/task/moderation.dart';
import 'package:toy_gpt/toy_gpt.dart';

void main() async {
  const String apiKey = "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";

  OpenAI.instance.setAuth(apiKey);

  final transcript = TranscriptionParams(format: AudioResponseFormat.srt);
  final translation = TranslationParams(format: AudioResponseFormat.text);

  try {
    final res = await ModerationTask.create(
      input: "I hate you",
    );

    print(res);
  } catch (e, s) {
    print(e);
    print(s);
  }
}
