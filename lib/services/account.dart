import 'package:social/services/api.dart';
import 'package:social/models/account.dart';
import 'dart:async';

class AccountService extends API {
    String _endpoint;

    AccountService() {
        this._endpoint = this.url;
    }

    Future<Account> login(String username, String password) async {
        var resource = '/mobile/auth';

        var body = {
            'username': username,
            'password': password
        };
        
        var response = await this.httpClient.post(this._endpoint + resource, body: body);

        if (response.statusCode < 300) {
            return new Account(response.body, 'account');
        } else {
            // TODO: Use an error logger, return better error
            print('Error in account services: ' + response.statusCode);
        }

    }
}