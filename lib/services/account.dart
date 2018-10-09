import 'package:Social/services/api.dart';
import 'package:Social/models/account.dart';
import 'dart:async';

class AccountService extends API {
  static final AccountService _instance = new AccountService._internal();
  String _endpoint;
  Account _account;

	Account get account => _account;

	factory AccountService() {
		print('account factory');
		return _instance;
  }

  AccountService._internal() {
    this._endpoint = this.url;
  }

  Future<bool> login(String username, String password) async {
    var resource = '/mobile/auth';

    var body = {'username': username, 'password': password};

    var response =
        await httpClient.post(_endpoint + resource, body: body);

    if (response.statusCode < 300) {
      _account = Account(response.body, 'account');
			print('setting account' + _account.toString());
      return true;
    } else {
      print('Error in account services: ' + response.statusCode.toString());
      return false;
    }
  }
}
