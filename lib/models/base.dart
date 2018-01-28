import 'dart:convert';

class Base {
    final JsonDecoder decoder = const JsonDecoder();

    Map decode(body, String key) {
        return decoder.convert(body)[key];
    }
}