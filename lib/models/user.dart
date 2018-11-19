import 'package:Social/models/base.dart';

class User extends Base {
  String id;
  String location;
  String name;
	String theme;
  List friends = [];
	List requests = [];

  User(body, String key) {
		body = body[key];
    id = body['_id'];
    name = body['full_name'];
    location = body['location'];
		theme = body['theme'];
    friends = body['friends'];
		requests = body['requests'];
  }

  User.fromMap(Map body) {
    id = body['_id'];
    name = body['full_name'];
    location = body['location'];
		theme = body['theme'];
    friends = List.from(body['friends']);
		requests = List.from(body['requests']);
  }

  Map<String, dynamic> toJson() =>
    {
      'id': id,
      'location': location,
			'full_name': name,
			'theme': theme,
			'friends': friends,
			'requests': requests
    };
}
