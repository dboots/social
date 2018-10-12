import 'package:Social/models/base.dart';
import 'package:Social/models/user.dart';

class Account extends Base {
  String id;
  String email;
	User user;

  Account(body, String key) {
    Map data = decode(body, 'account');

    id = data['_id'];
    email = data['email'];
		user = User.fromMap(data['user']);
  }
}
