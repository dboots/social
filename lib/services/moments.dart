import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:Social/services/api.dart';
import 'package:Social/services/account.dart';
import 'package:Social/models/moment.dart';

class MomentsService extends API {
  static final MomentsService _instance = new MomentsService._internal();
  AccountService _accountService = AccountService();

  factory MomentsService() {
    return _instance;
  }

  var headers;

  MomentsService._internal();

  Future<List<Moment>> get(String userId) async {
    List<Moment> moments;
    String resource = url + '/moments/' + userId;
    print(resource);

    headers = {
      HttpHeaders.authorizationHeader: 'JWT ' + _accountService.token,
      HttpHeaders.contentTypeHeader: 'application/json'
    };

    Response response = await this.httpClient.get(resource, headers: headers);

    print(response.body);

    if (response.statusCode < 300) {
      Iterable i = json.decode(response.body)['moments'];
      moments = i.map((model) {
        return Moment(model, 'moment');
      }).toList();

      print(moments);

      return moments;
    } else {
      print('Error in getting moments: ' + response.statusCode.toString());
      return [];
    }
  }

  Future<Moment> create(dynamic payload) async {
    String resource = url + '/moments';
    headers = {
      HttpHeaders.authorizationHeader: 'JWT ' + _accountService.token,
			HttpHeaders.contentTypeHeader: 'application/json'
    };

    dynamic body = {'owner': payload['owner'], 'members': payload['members'], 'body': 'eee'};

    print(json.encode(body));
    Response response = await this
        .httpClient
        .post(resource, body: json.encode(body), headers: headers);
    print(response.body);

    if (response.statusCode < 300) {
      print('success');
      dynamic body = json.decode(response.body)['moment'];
      return Moment(body);
    } else {
      print('Error in getting moments: ' + response.statusCode.toString());
      return null;
    }
  }
}
