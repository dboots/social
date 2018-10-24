import 'package:Social/models/base.dart';
import 'package:Social/models/user.dart';

class Account extends Base {
  String id;
  String email;
	String phone;
	User user;


	Account.fromJson(String body, String key) {
    Map data = decode(body, 'account');

    id = data['_id'];
    email = data['email'];
		phone = data['phone'];
		user = User.fromMap(data['user']);
	}

	Account.fromMap(Map body) {
    id = body['_id'];
    email = body['email'];
		phone = body['phone'];	
		user = User.fromMap(body['user']);
	}
}
