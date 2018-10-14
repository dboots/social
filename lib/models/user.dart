import 'package:Social/models/base.dart';

class User extends Base {
  String id;
  String location;
  String name;
  List friends = [];

  User(body, String key) {
    id = body['_id'];
    name = body['full_name'];
    location = body['location'];
    friends = body['friends'];
  }

  User.fromMap(Map body) {
    id = body['_id'];
    name = body['full_name'];
    location = body['location'];
    friends = List.from(body['friends']);
  }
}
