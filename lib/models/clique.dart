import 'package:Social/models/base.dart';

class Clique extends Base {
  String? id;
	String? name;

  Clique(body, String key) {
		id = body['_id'];
		name = body['name'];
  }
}
