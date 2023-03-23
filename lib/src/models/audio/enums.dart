enum AudioResponseFormat {
  text("text"),
  json("json"),
  verboseJson("verbose_json"),
  srt("srt"),
  vtt("vtt");

  final String value;
  const AudioResponseFormat(this.value);
}
