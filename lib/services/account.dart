import 'package:Social/services/api.dart';
import 'package:Social/models/account.dart';
import 'dart:async';
import 'package:Social/cache/Cache.dart';
import 'package:Social/cache/MemCache.dart';

class AccountService extends API {
  static final Cache cache = MemCache<Account>();
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
      cache.put(0, this.account);
      return true;
    } else {
      print('Error in account services: ' + response.statusCode.toString());
      return false;
    }
  }

  Future<Account> getAccount() {
    return cache.get(0);
  }
}
