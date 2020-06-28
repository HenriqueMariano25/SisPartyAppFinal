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

void findAllProposals() async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  final Client client = HttpClientWithInterceptor.build(
    interceptors: [LoggingInterceptor()],
  );
  final Response response = await client.get(url_base + "/proposals",
    headers: <String, String>{'Accept': 'application/vnd.api+json',
    'access-token':pref.getString("token"), 'client':pref.getString("client"),
    'uid':pref.getString("uid")},
  );
  print(response);
  final data = json.decode(response.body);
  print(data);
  final rest = data as List;
//  final List<>

}