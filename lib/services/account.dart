import 'package:Social/services/api.dart';
import 'package:Social/models/account.dart';
import 'dart:async';

class AccountService extends API {
  String _endpoint;
  Account account;

  AccountService() {
    this._endpoint = this.url;
  }

  Future<bool> login(String username, String password) async {
    var resource = '/mobile/auth';

    var body = {'username': username, 'password': password};

    var response =
        await this.httpClient.post(this._endpoint + resource, body: body);

    if (response.statusCode < 300) {
      this.account = Account(response.body, 'account');
      return true;
    } else {
      print('Error in account services: ' + response.statusCode.toString());
      return false;
    }
  }
}
