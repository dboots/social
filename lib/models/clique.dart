import 'dart:convert';
import 'package:Social/models/base.dart';
import 'package:Social/models/user.dart';

class Clique extends Base {
  String id;
  String name;
  List<User> members;

  Clique([dynamic body, String key]) {
    if (body != null) {
      id = body['_id'];
      name = body['name'];

      Iterable i = body['members'];
      i.map((model) {
        return model;
      }).toList();
      members = members;
    }
  }

  Clique.fromMap(Map body) {
    id = body['_id'];
    name = body['name'];
    Iterable i = body['members'];
    i.map((model) {
      return model;
    }).toList();
    members = members;
  }
}
