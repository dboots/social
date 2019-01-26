import 'package:Social/models/base.dart';
import 'package:Social/models/user.dart';

class Moment extends Base {
  String id;
  String name;
  String message;
  //List<String> comments;
  List<User> members;
  User owner;
  int likes;

  Moment([dynamic body, String key]) {
    if (body != null) {
      id = body['_id'];
      name = body['name'];
      message = body['body'];
      owner = User.fromMap(body['owner']);

			print(owner.friends);

      Iterable i = body['members'];
      members = i.map((model) {
        return User.fromMap(model);
      }).toList();
    }
  }
}
