import 'dart:convert';
import 'package:eagon_bodega/src/models/access_model.dart';
import 'package:eagon_bodega/src/models/response_model.dart';
import 'package:http/http.dart' as http;
import 'package:eagon_bodega/src/models/user_model.dart';
import 'package:eagon_bodega/src/utils/string_utils.dart';
import 'package:eagon_bodega/src/config/enviroment_config.dart';
import 'package:eagon_bodega/src/shared_preferences/user_preferences.dart';

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
      "user": acceso.user,
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

  String getUrl() {
    return this._url;
  }

  Future sleep2() {
    return new Future.delayed(const Duration(seconds: 2), () => "2");
  }
}
