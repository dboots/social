import 'package:http/http.dart';

class API extends Object {
  // TODO: Use proper url based on dev/prod settings
  final String url = 'https://sleepy-tor-82012.herokuapp.com/v1';
  //final String url = 'http://0.0.0.0:3000/v1';
  final Client httpClient = Client();
}
