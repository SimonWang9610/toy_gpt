enum ImageTaskSize {
  /// 256x256
  small("256x256"),

  /// 512x512
  medium("512x512"),

  /// 1024x1024
  large("1024x1024");

  final String value;
  const ImageTaskSize(this.value);
}

enum ImageResponseFormat {
  /// PNG
  url("url"),

  /// JPEG
  json("b64_json");

  final String value;
  const ImageResponseFormat(this.value);
}
