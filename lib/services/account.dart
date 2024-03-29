import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:Social/services/api.dart';
import 'package:Social/models/account.dart';

class AccountService extends API {
  static final AccountService _instance = new AccountService._internal();
  String? _endpoint;
  Account? _account;
  List<Account>? _contactAccounts;

  Account? get account => _account;
  List<Account>? get contactAccounts => _contactAccounts;

  factory AccountService() {
    return _instance;
  }

  AccountService._internal() {
    this._endpoint = this.url;
  }

  Future<bool> login(String username, String password) async {
    var resource = '/mobile/auth';

    var body = {'username': username, 'password': password};

    var response =
        await httpClient.post(Uri(path: '$_endpoint$resource'), body: body);

    if (response.statusCode < 300) {
      _account = Account(response.body, 'account');
      return true;
    } else {
      print('Error in account services: ' + response.statusCode.toString());
      return false;
    }
  }

  Future<List<Account>?> getSocialContacts(List<String> contacts) async {
    var body = {'contacts': json.encode(contacts)};

    Response response =
        await httpClient.post(Uri(path: '$url/contacts'), body: body, headers: {
      HttpHeaders.authorizationHeader:
          'JWT eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiNWE2NTRjZmMyOWM1ZWQwMDEwNDM1YTRjIiwiaWF0IjoxNTM5MDA1NzI2LCJleHAiOjE1Mzk2MTA1MjZ9.XfRbjHThiqLOVhlbc4517vLLAq_mdFBj7diwH9WlLSk'
    });

    Iterable i = json.decode(response.body)['contacts'];

    _contactAccounts = i.map((model) {
      return Account.fromMap(model);
    }).toList();

    return _contactAccounts;
  }

  Future<List<Account>?> initSocialContacts(List<Contact> contacts) async {
    if (_contactAccounts != null) {
      return _contactAccounts;
    }

    List<String> contactPhones = [];

    contacts.forEach((contact) {
      contact.phones?.forEach((phone) {
        contactPhones
            .add(phone.value!.replaceAll(RegExp(r'(\s|\(|\)|\-)+'), ''));
      });
    });

    _contactAccounts = await getSocialContacts(contactPhones);
    return _contactAccounts;
  }
}
