import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:Social/services/api.dart';
import 'package:Social/services/jwt-decode.dart';
import 'package:Social/models/account.dart';
import 'package:Social/services/shared-prefs.dart';

class AccountService extends API {
  static final AccountService _instance = AccountService._internal();
  JwtDecodeService _jwtDecodeService = JwtDecodeService();
  Account _account;
  String token;
  List<Account> _contactAccounts;
  SharedPrefs _sharedPrefs = SharedPrefs();
  Map<String, String> headers;

  Account get account => _account;
  List<Account> get contactAccounts => _contactAccounts;

  factory AccountService() {
    return _instance;
  }

  AccountService._internal();

  void resume(String token) {
    this.token = token;
    dynamic object = _jwtDecodeService.parseJwt(token);
    _account = Account.fromMap(object['account']);
    headers = {
      HttpHeaders.authorizationHeader: 'JWT ' + token
    };
  }

  Future<bool> login(String username, String password) async {
    var resource = '/mobile/auth';
    var body = {'username': username, 'password': password};
    var response = await httpClient.post(url + resource, body: body);

    if (response.statusCode < 300) {
      _account = Account.fromJson(response.body, 'account');

      //-- TODO: refactor decoder to a service
      //-- TODO: refactor setting token to accountService.getToken()
      JsonDecoder decoder = const JsonDecoder();
      String token = decoder.convert(response.body)['token'];
      _sharedPrefs.instance.setString('token', token);
      this.token = token;

      return true;
    } else {
      print('Error in account services: ' + response.statusCode.toString());
      return false;
    }
  }

  Future<dynamic> signup(dynamic body) async {
    String resource = '/accounts';
    Response response = await httpClient.post(url + resource, body: body);
    if (response.statusCode < 300) {
      _account = Account.fromJson(response.body, 'account');

      JsonDecoder decoder = const JsonDecoder();
      String token = decoder.convert(response.body)['token'];
      this.token = token;
      _sharedPrefs.instance.setString('token', token);

      return {'success': true, 'body': _account};
    } else {
      return {'success': false, 'body': response.body};
    }
  }

  Future<bool> update(dynamic body) async {
		String resourceUrl = url + '/account/' + _account.id;
    Response response =
        await httpClient.put(resourceUrl, body: body, headers: headers);

    return (response.statusCode < 300) ? true : false;
  }

  Future<List<Account>> getSocialContacts(List<String> contacts) async {
    var body = {'contacts': contacts.toString()};

    Response response = await httpClient.post(url + '/contacts',
        body: body, headers: {HttpHeaders.authorizationHeader: 'JWT ' + token});

    Iterable i = json.decode(response.body)['contacts'];

    _contactAccounts = i.map((model) {
      return Account.fromMap(model);
    }).toList();

    return _contactAccounts;
  }

  Future<List<Account>> initSocialContacts(List<Contact> contacts) async {
    List<String> contactPhones = List<String>();

    contacts.forEach((contact) {
      contact.phones.forEach((phone) {
        contactPhones.add(phone.value.replaceAll(RegExp(r'\D+'), ''));
      });
    });

    _contactAccounts = await getSocialContacts(contactPhones);
    return _contactAccounts;
  }
}
