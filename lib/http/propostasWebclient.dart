import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
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

Future<dynamic> findAllProposals() async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  final Client client = HttpClientWithInterceptor.build(
    interceptors: [LoggingInterceptor()],
  );
  final Response response = await client.get(url_base + "proposals",
    headers: <String, String>{'Accept': 'application/vnd.api+json',
    'access-token':pref.getString("token"), 'client':pref.getString("client"),
    'uid':pref.getString("uid")},
  );
  final data = json.decode(response.body);
  final proposals_sent = data['proposals_sent'] as List;
  print(proposals_sent);
  final List<Proposta> propostas_enviadas = List();
 for (Map<String, dynamic> propostasJson in (proposals_sent) ) {
    final Evento eventoLocal = Evento(
      propostasJson['event']['id'],
      propostasJson['event']['nome'],
      propostasJson['event']['description'],
      propostasJson['event']['realization_date'],
      propostasJson['event']['local'],
      propostasJson['event']['situation'],
      propostasJson['event']['event_type'],
      propostasJson['event']['created_at'],
    );
    final Proposta proposta = Proposta(
        propostasJson['id'],
        propostasJson['description'],
        propostasJson['service'],
        propostasJson['service_description'],
        propostasJson['value'],
        propostasJson['situation'],
        propostasJson['user_id'],
        propostasJson['created_at'],
        eventoLocal);
    propostas_enviadas.add(proposta);
  }
  print(propostas_enviadas.length);
  /* final proposals_accepted = data['proposals_accepted'] as List;
  final List<Proposta> propostas_aceitas = List();
  for (Map<String, dynamic> propostasJson in (proposals_accepted) ) {
    final Evento eventoLocal = Evento(
      propostasJson['event']['id'],
      propostasJson['event']['nome'],
      propostasJson['event']['description'],
      propostasJson['event']['realization_date'],
      propostasJson['event']['local'],
      propostasJson['event']['situation'],
      propostasJson['event']['event_type'],
      propostasJson['event']['created_at'],
    );
    final Proposta proposta = Proposta(
        propostasJson['id'],
        propostasJson['description'],
        propostasJson['service'],
        propostasJson['service_description'],
        propostasJson['value'],
        propostasJson['situation'],
        propostasJson['user_id'],
        propostasJson['created_at'],
        eventoLocal);
    propostas_aceitas.add(proposta);
  }
  print(propostas_enviadas);
  return {"propostas_enviadas" :propostas_enviadas, "propostas_aceitas":propostas_aceitas}; */
  return {"propostas_enviadas" :propostas_enviadas};
//  final List<>
}

void createProposals(data) async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  final Client client = HttpClientWithInterceptor.build(
    interceptors: [LoggingInterceptor()],
  );
  final Response response = await client.post(url_base + 'proposals',
      headers: <String, String>{'Accept': 'application/vnd.api+json',
      'access-token':pref.getString("token"), 'client':pref.getString("client"),
      'uid':pref.getString("uid")},
    body: data,
  );
  if(response.statusCode == 200){
    pref.setString("token", response.headers['access-token']);
  }
//      headers: <String, String>{'Accept': 'application/vnd.api+json'},
//      body: data);
}