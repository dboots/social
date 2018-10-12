import 'package:Social/models/base.dart';

class User extends Base {
  String id;
	String name;
	List friends = [];

  User(body, String key) {
		Map data = decode(body, 'user');

		id = data['_id'];
		name = data['name'];
		friends = data['friends'];
  }

  User.fromMap(Map body) {
		id = body['_id'];
		name = body['name'];
		friends = List.from(body['friends']);
  }
}
