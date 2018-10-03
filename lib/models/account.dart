import 'package:Social/models/base.dart';

class Account extends Base {
  String id;
  String email;
  String fullName;
  List<String> cliques;

  Account(body, String key) {
    Map data = decode(body, 'account');

    id = data['_id'];
    email = data['email'];
    fullName = data['full_name'];
    cliques = data['cliques'];
  }
}
