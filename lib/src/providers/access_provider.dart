import 'dart:convert';
import 'package:eagon_bodega/src/models/access_model.dart';
import 'package:eagon_bodega/src/models/person_model.dart';
import 'package:eagon_bodega/src/models/response_model.dart';
import 'package:http/http.dart' as http;
import 'package:eagon_bodega/src/models/user_model.dart';
import 'package:eagon_bodega/src/utils/string_utils.dart';
import 'package:eagon_bodega/src/config/enviroment_config.dart';
import 'package:eagon_bodega/src/shared_preferences/user_preferences.dart';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';

class AccessProvider {
  final String _url = EnviromentConfig().getApiUrl();
  final prefs = new PreferenciasUsuario();

  Future<ResponseModel> saveAccess(AccessModel acceso) async {
    //var url = '$_url/login.php/login';
    var uri = Uri.parse('$_url/acceso.php/save');
    Map<String, String> headers = {
      "content-type": "application/x-www-form-urlencoded",
      'Authorization': EnviromentConfig().getApiKey(),
      'ci_session': prefs.ciSession
    };

    String jsonData = jsonEncode({
      "rut": acceso.rut,
      "name": acceso.name,
      "user": prefs.ciUserName,
      "location": acceso.location
    });
    Map<String, String> queryParameters = {"data": jsonData};

    var data;

    try {
      final resp =
          await http.post(uri, body: queryParameters, headers: headers);

      data = Utf8Codec().decode(resp.bodyBytes);

      if (!isJson(data)) return null;

      final validJson = jsonDecode(data);
      final responseServer = ResponseModel.fromJson(validJson);
      return responseServer;
    } on FormatException catch (e) {
      print(e);
      return null;
    }
  }

  Future<PersonModel> getPersonInfo(String rut) async {
    var uri = Uri.parse('$_url/acceso.php/getInfoRut/$rut');
    Map<String, String> headers = {
      "content-type": "application/x-www-form-urlencoded",
      'Authorization': EnviromentConfig().getApiKey(),
      'ci_session': prefs.ciSession
    };

    var data;
    try {
      final resp = await http.get(uri, headers: headers);
      data = Utf8Codec().decode(resp.bodyBytes);
      Map<String, String> person = _parseHTMLText(data);
      final p = PersonModel.fromJson(person);
      print(p.name);
      return p;
      //List<Dte> lstDte = new

    } catch (ex) {
      return null;
    }
  }

  Map<String, String> _parseHTMLText(String html) {
    var document = parse(html);
    var tag = document.body.getElementsByTagName("table").last;
    if (tag.nodes.isNotEmpty) {
      var tbody = tag.getElementsByTagName('tbody').first;
      var tr = tbody.getElementsByTagName('tr').last;
      var td = tr.getElementsByTagName('td');
      //print(td.elementAt(1).text);
      return {
        'name': td.elementAt(0).text,
        'rut': td.elementAt(1).text,
        'genre': td.elementAt(2).text,
        'direction': td.elementAt(3).text,
        'city': td.elementAt(4).text
      };
    } else {
      return null;
    }
  }

  String getUrl() {
    return this._url;
  }

  Future sleep2() {
    return new Future.delayed(const Duration(seconds: 2), () => "2");
  }
}
