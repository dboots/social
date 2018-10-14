import 'dart:async';
import 'package:contacts_service/contacts_service.dart';
import 'package:Social/services/api.dart';

class UserService extends API {
  static final UserService _instance = new UserService._internal();
  List<Contact> _contacts;

	List<Contact> get contacts => _contacts;

  factory UserService() {
    return _instance;
  }

  UserService._internal();

  Future<List<Contact>> initContacts() async {
		if (_contacts != null) {
			return _contacts;
		}

    Iterable<Contact> contacts = await ContactsService.getContacts();
		_contacts = contacts.toList();

		_contacts.sort((Contact a, Contact b) {
      return a.displayName.compareTo(b.displayName);
    });

		return _contacts;
	}
}
