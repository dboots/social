import 'package:Social/models/base.dart';

class User extends Base {
  String id;
	String location;
	String name;
	List friends = [];

  User(body, String key) {
		Map data = decode(body, 'user');

		id = data['_id'];
		name = data['full_name'];
		location = data['location'];
		friends = data['friends'];
  }

  User.fromMap(Map body) {
		id = body['_id'];
		name = body['full_name'];
		location = body['location'];
		friends = List.from(body['friends']);
  }
}
