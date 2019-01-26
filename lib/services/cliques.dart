import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:Social/services/api.dart';
import 'package:Social/services/account.dart';
import 'package:Social/models/clique.dart';

	class CliqueService extends API {
  static final CliqueService _instance = new CliqueService._internal();
  AccountService _accountService = AccountService();
  List<Clique> cliques;

  var headers;

  factory CliqueService() {
    return _instance;
  }

  CliqueService._internal();

  Future<List<Clique>> getCliques() async {
    headers = {
      HttpHeaders.authorizationHeader: 'JWT ' + _accountService.token,
      HttpHeaders.contentTypeHeader: 'application/json'
    };

    var resource = '/cliques';
    var response = await this.httpClient.get(url + resource, headers: headers);

    if (response.statusCode < 300) {
      Iterable i = json.decode(response.body)['cliques'];
      cliques = i.map((model) {
        return Clique(model, 'clique');
      }).toList();

      return cliques;
    } else {
      print('Error in getting cliques: ' + response.statusCode.toString());
      return [];
    }
  }

  Future<bool> update(Clique clique) async {
    String resource = '/cliques/' + clique.id;

    var members = clique.members.map((user) {
      return user.id;
    }).toList();

    headers = {
      HttpHeaders.authorizationHeader: 'JWT ' + _accountService.token,
      HttpHeaders.contentTypeHeader: 'application/json'
    };

    var params = json.encode({'name': clique.name, 'members': members});

    Response response = await this
        .httpClient
        .put(url + resource, body: params, headers: headers);

    if (response.statusCode < 300) {
      //cliques.add(Clique.fromMap(json.decode(response.body)['clique']));
      return true;
    } else {
      return false;
    }
  }

  Future<bool> create(Clique clique) async {
    String resource = '/cliques';

    var members = clique.members.map((user) {
      return user.id;
    }).toList();

    headers = {
      HttpHeaders.authorizationHeader: 'JWT ' + _accountService.token,
      HttpHeaders.contentTypeHeader: 'application/json'
    };

    var params = json.encode({'name': clique.name, 'members': members});

    Response response = await this
        .httpClient
        .post(url + resource, body: params, headers: headers);

    if (response.statusCode < 300) {
      cliques.add(Clique.fromMap(json.decode(response.body)['clique']));
      return true;
    } else {
      return false;
    }
  }
}
