import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:Social/services/api.dart';
import 'package:Social/services/account.dart';
import 'package:Social/models/user.dart';

class UserService extends API {
  static final UserService _instance = new UserService._internal();
  AccountService _accountService = AccountService();
  List<Contact> _contacts = [];
  Map<String, String> headers = {};

  List<Contact> get contacts => _contacts;

  factory UserService() {
    return _instance;
  }

  UserService._internal() {
    headers = {HttpHeaders.authorizationHeader: 'JWT ' + _accountService.token};
  }

  Future<User> update(dynamic body) async {
    Response response =
        await httpClient.put(url + '/user', body: body, headers: headers);

		return User(response.body, 'user');
  }

  Future<List<Contact>> initContacts() async {
    Iterable<Contact> contacts = await ContactsService.getContacts();
    _contacts = contacts.toList();
    _contacts.sort((Contact a, Contact b) {
      return a.displayName.compareTo(b.displayName);
    });

    return _contacts;
  }

  Future<bool> sendFriendRequest(String friendId) async {
    var body = {'friend': friendId};

    Response response = await httpClient.post(url + '/user/request',
        body: body, headers: headers);

    return json.decode(response.body)['success'];
  }

  Future<bool> approveFriendRequest(String friendId) async {
    var body = {'friend': friendId};

    Response response = await httpClient.post(url + '/user/request/approve',
        body: body, headers: headers);

    return json.decode(response.body)['success'];
  }

  Future<bool> cancelFriendRequest(String friendId) async {
    var body = {'friend': friendId};

    Response response = await httpClient.post(url + '/user/request/cancel',
        body: body, headers: headers);

    return json.decode(response.body)['success'];
  }

  Future<bool> denyFriendRequest(String friendId) async {
    var body = {'friend': friendId};

    Response response = await httpClient.post(url + '/user/request/deny',
        body: body, headers: headers);

    return json.decode(response.body)['success'];
  }
}
