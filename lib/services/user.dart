import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:Social/services/api.dart';
import 'package:contacts_service/contacts_service.dart';

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

  Future<bool> sendFriendRequest(String friendId) async {
    var body = {'friend': friendId};

    Response response = await httpClient.post(url + '/user/request', body: body, headers: {
      HttpHeaders.authorizationHeader:
          'JWT ' + token
    });

		return json.decode(response.body)['success'];
  }

  Future<bool> cancelFriendRequest(String friendId) async {
    var body = {'friend': friendId};

    Response response = await httpClient.post(url + '/user/request/cancel', body: body, headers: {
      HttpHeaders.authorizationHeader:
          'JWT ' + token
    });

		return json.decode(response.body)['success'];
  }

  Future<bool> denyFriendRequest(String friendId) async {
    var body = {'friend': friendId};

    Response response = await httpClient.post(url + '/user/request/deny', body: body, headers: {
      HttpHeaders.authorizationHeader:
          'JWT ' + token
    });

		return json.decode(response.body)['success'];
  }
}
