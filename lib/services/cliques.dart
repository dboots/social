import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:Social/services/api.dart';
import 'package:Social/models/clique.dart';

class CliqueService extends API {
  static final CliqueService _instance = new CliqueService._internal();
  String _endpoint;
  static List<Clique> _cliques;

  /*{
		print('cliqueservice');
    _endpoint = this.url;
		_getClique().then((clique) {
			print(clique);
		});
  }*/

  factory CliqueService() {
		print('factory');
		return _instance;
  }

  CliqueService._internal() {
		print('internal');
    _endpoint = this.url;
    print(_cliques);
  }

  Future<List<Clique>> getCliques() async {
		print('getCliques');
		if (_cliques != null) {
			print('using _clique cache');
			return _cliques;
		}
    var resource = '/cliques';

    var response =
        await this.httpClient.get(this._endpoint + resource, headers: {
      HttpHeaders.authorizationHeader:
          'JWT eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiNWE2NTRjZmMyOWM1ZWQwMDEwNDM1YTRjIiwiaWF0IjoxNTM5MDA1NzI2LCJleHAiOjE1Mzk2MTA1MjZ9.XfRbjHThiqLOVhlbc4517vLLAq_mdFBj7diwH9WlLSk'
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
