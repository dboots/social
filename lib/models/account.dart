import 'package:social/models/base.dart';

class Account extends Base {
    String id;
    String email;
    String full_name;
    List<String> cliques;

    Account(body, String key) {
        Map data = decode(body, 'account');

        id = data['_id'];
        email = data['email'];
        full_name = data['full_name'];
        cliques = data['cliques'];
    }
}