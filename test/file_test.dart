import 'dart:io';

void main() async {
  final json = {
    "prompt": "This is a test",
    "completion": "This is a test of the emergency broadcast system",
  };

  final data = List.generate(50, (index) => json);
}
