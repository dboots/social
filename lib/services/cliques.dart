import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:Social/services/api.dart';
import 'package:Social/models/clique.dart';

class CliqueService extends API {
  static final CliqueService _instance = new CliqueService._internal();
  static List<Clique> _cliques;

  factory CliqueService() {
		return _instance;
  }

  CliqueService._internal() {
  }

  Future<List<Clique>> getCliques() async {
		if (_cliques != null) {
			return _cliques;
		}
		
    var resource = '/cliques';

    var response =
        await this.httpClient.get(url + resource, headers: {
      HttpHeaders.authorizationHeader:
          'JWT eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiNWE2NTRjZmMyOWM1ZWQwMDEwNDM1YTRjIiwiaWF0IjoxNTM5NjE1MTgyLCJleHAiOjE1NDAyMTk5ODJ9.aQZUSetVokKxcWgT5-ityWqM3oA87fznMEADxTkGa_0'
    });

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
}
