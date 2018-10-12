import 'dart:convert';

class Base {
  final JsonDecoder decoder = const JsonDecoder();

  Map decode(dynamic body, String key) {
    return decoder.convert(body)[key];
  }

  List decodeAll(List body, String key) {
		List<Map> result = [];

		for (var item in body) {
			result.add(item);
		}

    return result;
  }
}
