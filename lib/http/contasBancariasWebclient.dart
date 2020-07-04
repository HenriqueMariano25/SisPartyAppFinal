import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sisparty/models/contaBancaria_model.dart';
import 'package:sisparty/models/evento_model.dart';

import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:sisparty/models/proposta_model.dart';

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

Future<dynamic> contasBancarias() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  final Client client = HttpClientWithInterceptor.build(
    interceptors: [LoggingInterceptor()],
  );
  final Response response = await client.get(
    url_base + "bank_accounts",
    headers: <String, String>{
      'Accept': 'application/vnd.api+json',
      'access-token': pref.getString("token"),
      'client': pref.getString("client"),
      'uid': pref.getString("uid")
    },
  );
  print(response.body);
  final data = json.decode(response.body);
  final contasData = data as List;
  final List<ContaBancaria> contasBancarias = List();
  for (Map<String, dynamic> contaJson in (contasData)) {
    final ContaBancaria conta = ContaBancaria(
      account: contaJson['account'],
      agency: contaJson['agency'],
      bank: contaJson['bank'],
      id: contaJson['id'],
      userId: contaJson['user_id'],
      createdAt: contaJson['created_at'],
    );
    contasBancarias.add(conta);
  }
  print(contasBancarias);
  return {"contasBancarias": contasBancarias};
}

void addBankAccount(data) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  final Client client = HttpClientWithInterceptor.build(
    interceptors: [LoggingInterceptor()],
  );
  final Response response = await client.post(
    url_base + 'bank_accounts',
    headers: <String, String>{
      'Accept': 'application/vnd.api+json',
      'access-token': pref.getString("token"),
      'client': pref.getString("client"),
      'uid': pref.getString("uid")
    },
    body: data,
  );
}
