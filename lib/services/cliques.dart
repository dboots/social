import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:Social/services/api.dart';
import 'package:Social/services/account.dart';
import 'package:Social/models/clique.dart';
import 'package:Social/models/user.dart';

class CliqueService extends API {
  static final CliqueService _instance = new CliqueService._internal();
  AccountService _accountService = AccountService();
  List<Clique> _cliques;
  List<Clique> get cliques {
    return _cliques;
  }

  void set cliques(List<Clique> data) {
    _cliques = data;
  }

  var headers;

  factory CliqueService() {
    return _instance;
  }

  CliqueService._internal() {
    headers = {
      HttpHeaders.authorizationHeader: 'JWT ' + _accountService.token,
      HttpHeaders.contentTypeHeader: 'application/json'
    };
  }

  Future<List<Clique>> getCliques() async {
    if (_cliques != null && _cliques.length > 0) {
      return _cliques;
    }

    var resource = '/cliques';
    var response = await this.httpClient.get(url + resource, headers: headers);

    if (response.statusCode < 300) {
      Iterable i = json.decode(response.body)['cliques'];
      _cliques = i.map((model) {
        return Clique(model, 'clique');
      }).toList();

      return _cliques;
    } else {
      print('Error in getting cliques: ' + response.statusCode.toString());
      return [];
    }
  }

  Future<bool> createClique(Clique clique) async {
    String resource = '/cliques';

    var members = clique.members.map((user) {
      return user.id;
    }).toList();

    var params = json.encode({'name': clique.name, 'members': members});

    Response response = await this
        .httpClient
        .post(url + resource, body: params, headers: headers);

    if (response.statusCode < 300) {
      _cliques.add(Clique.fromMap(json.decode(response.body)['clique']));
      return true;
    } else {
      return false;
    }
  }
}
