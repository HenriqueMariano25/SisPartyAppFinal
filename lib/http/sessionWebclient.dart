import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sisparty/models/evento_model.dart';

import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

var url_base = "http://10.0.2.2:3000/";

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
//    print(data.baseUrl);
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
//    print(data.body);
//    print(data.headers);
    return data;
  }
}


void criarUsuario(data) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  final Client client = HttpClientWithInterceptor.build(
    interceptors: [LoggingInterceptor()],
  );
  print(data);
  final Response response = await client.post(url_base + 'auth',
      headers: <String, String>{'Accept': 'application/vnd.api+json'},
      body: data);
  final dataJson = json.decode(response.body);
  var token = response.headers['access-token'];
  var cliente_headers = response.headers['client'];
  var uid = response.headers['uid'];
  pref.setString("token", token);
  pref.setString("client", cliente_headers);
  pref.setString("uid", uid);
  pref.setString("type_user", dataJson["data"]["type_user"]);
  pref.setString("authenticated", "true");
}

Future<dynamic> entrar(data) async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  final Client client = HttpClientWithInterceptor.build(
    interceptors: [LoggingInterceptor()],
  );
  final Response response = await client.post(url_base + 'auth/sign_in',
      headers: <String, String>{'Accept': 'application/vnd.api+json'},
      body: data);
  if(response.statusCode == 200){
    final dataJson = json.decode(response.body);
    var token = response.headers['access-token'];
    var cliente_headers = response.headers['client'];
    var uid = response.headers['uid'];
    pref.setString("token", token);
    pref.setString("client", cliente_headers);
    pref.setString("uid", uid);
    pref.setString("type_user", dataJson["data"]["type_user"]);
    pref.setString("id", dataJson["data"]["id"].toString());
    pref.setString("authenticated", "true");
    final res_return = {'result':true};
    return res_return;
  }else{
    final res_return = {'result':false};
    return res_return;
  }

}
