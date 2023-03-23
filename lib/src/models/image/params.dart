import 'enums.dart';

class ImageParams {
  final String prompt;
  final int n;
  final ImageTaskSize size;
  final ImageResponseFormat format;
  final String? user;

  const ImageParams({
    required this.prompt,
    this.n = 1,
    this.size = ImageTaskSize.small,
    this.format = ImageResponseFormat.url,
    this.user,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "prompt": prompt,
      "n": n,
      "size": size.value,
      "response_format": format.value,
      if (user != null) "user": user,
    };
  }
}

class VariationParams {
  final int n;
  final ImageTaskSize size;
  final ImageResponseFormat format;
  final String? user;
  const VariationParams({
    this.n = 1,
    this.size = ImageTaskSize.small,
    this.format = ImageResponseFormat.url,
    this.user,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "n": n,
      "size": size.value,
      "response_format": format.value,
      if (user != null) "user": user,
    };
  }
}
