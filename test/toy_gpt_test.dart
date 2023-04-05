import 'dart:convert';

import 'package:toy_gpt/src/models/audio/enums.dart';
import 'package:toy_gpt/src/models/audio/params.dart';
import 'package:toy_gpt/src/models/image/params.dart';
import 'package:toy_gpt/src/task/audio.dart';
import 'package:toy_gpt/src/task/embedding.dart';
import 'package:toy_gpt/src/task/image.dart';
import 'package:toy_gpt/src/task/moderation.dart';
import 'package:toy_gpt/toy_gpt.dart';

import '../key.dart';

void main() async {
  OpenAI.instance.setAuth(key);

  const template = 'write a chinese poem. do not translate it.';

  final completion = await CompletionTask.asyncChat(
    messages: [
      {"role": "user", "content": template}
    ],
    params: ChatCompletionParams(maxTokens: 1024),
  );

  String answer = "";

  completion.choices.forEach((element) {
    answer += element.body;
  });

  print(answer);
}
