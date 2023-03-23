import 'package:simple_http_api/simple_http_api.dart';

class OpenAI {
  static String endpoint = "https://api.openai.com";
  static String version = "v1";

  static Uri getUri(String path) {
    final url = "$endpoint/$version$path";
    return Uri.parse(url);
  }

  static final instance = OpenAI._();
  OpenAI._();

  String? _apiKey;
  ConnectionOption? connectionOption;

  void setAuth(String apiKey) {
    _apiKey = apiKey;
  }

  bool get hasAuth => _apiKey != null;

  Map<String, String> get headers {
    assert(hasAuth,
        "Please call OpenAI.instance.setAuth first to set your APIKey");

    return {
      "Content-Type": "application/json",
      "Authorization": "Bearer $_apiKey",
    };
  }
}
