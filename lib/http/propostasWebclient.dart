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

Future<dynamic> findAllProposals() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  final Client client = HttpClientWithInterceptor.build(
    interceptors: [LoggingInterceptor()],
  );
  final Response response = await client.get(
    url_base + "proposals",
    headers: <String, String>{
      'Accept': 'application/vnd.api+json',
      'access-token': pref.getString("token"),
      'client': pref.getString("client"),
      'uid': pref.getString("uid")
    },
  );
  final data = json.decode(response.body);
  final proposals_sent = data['proposals_sent'] as List;
  print(proposals_sent);
  final List<Proposta> propostas_enviadas = List();
  for (Map<String, dynamic> propostasJson in (proposals_sent)) {
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
  return {"propostas_enviadas": propostas_enviadas};
}

void createProposals(data) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  final Client client = HttpClientWithInterceptor.build(
    interceptors: [LoggingInterceptor()],
  );
  final Response response = await client.post(
    url_base + 'proposals',
    headers: <String, String>{
      'Accept': 'application/vnd.api+json',
      'access-token': pref.getString("token"),
      'client': pref.getString("client"),
      'uid': pref.getString("uid")
    },
    body: data,
  );
}

Future<dynamic> eventoPropostas(id) async {
  print(id);
  SharedPreferences pref = await SharedPreferences.getInstance();
  final Client client = HttpClientWithInterceptor.build(
    interceptors: [LoggingInterceptor()],
  );
  final Response response = await client.get(
    url_base + "event/proposals/${id}",
    headers: <String, String>{
      'Accept': 'application/vnd.api+json',
      'access-token': pref.getString("token"),
      'client': pref.getString("client"),
      'uid': pref.getString("uid")
    },
  );
  print(response.body);
  final data = json.decode(response.body);
  final proposalsReceived = data['proposals_received'] as List;
  final List<Proposta> propostasRecebidas = List();
  for (Map<String, dynamic> propostasJson in (proposalsReceived)) {
    final Proposta propostaRecebida = Proposta(
      propostasJson['id'],
      propostasJson['description'],
      propostasJson['service'],
      propostasJson['service_description'],
      propostasJson['value'],
      propostasJson['situation'],
      propostasJson['user_id'],
      propostasJson['created_at'],
    );
    propostasRecebidas.add(propostaRecebida);
  }
  final proposalsAccept = data['proposals_accept'] as List;
  final List<Proposta> propostasAceitas = List();
  for (Map<String, dynamic> propostasJson in (proposalsAccept)) {
    final Proposta propostaAceita = Proposta(
      propostasJson['id'],
      propostasJson['description'],
      propostasJson['service'],
      propostasJson['service_description'],
      propostasJson['value'],
      propostasJson['situation'],
      propostasJson['user_id'],
      propostasJson['created_at'],
    );
    propostasAceitas.add(propostaAceita);
  }
  final proposalsDeclined = data['proposals_declined'] as List;
  final List<Proposta> propostasRecusadas = List();
  for (Map<String, dynamic> propostasJson in (proposalsDeclined)) {
    final Proposta propostaRecusada = Proposta(
      propostasJson['id'],
      propostasJson['description'],
      propostasJson['service'],
      propostasJson['service_description'],
      propostasJson['value'],
      propostasJson['situation'],
      propostasJson['user_id'],
      propostasJson['created_at'],
    );
    propostasRecusadas.add(propostaRecusada);
  }
  return {
    "propostas_recebidas": propostasRecebidas,
    "propostas_aceitas": propostasAceitas,
    "propostas_recusadas": propostasRecusadas
  };
}

void acceptProposal(id) async {
  print(id);
  SharedPreferences pref = await SharedPreferences.getInstance();
  final Client client = HttpClientWithInterceptor.build(
    interceptors: [LoggingInterceptor()],
  );
  final Response response = await client.post(
    url_base + 'proposal/accept/',
    headers: <String, String>{
      'Accept': 'application/vnd.api+json',
      'access-token': pref.getString("token"),
      'client': pref.getString("client"),
      'uid': pref.getString("uid")
    },
    body: {"id": id.toString()},
  );
  print(response.body);
}

void declinedProposal(id) async {
  print(id);
  SharedPreferences pref = await SharedPreferences.getInstance();
  final Client client = HttpClientWithInterceptor.build(
    interceptors: [LoggingInterceptor()],
  );
  final Response response = await client.post(
    url_base + 'proposal/declined/',
    headers: <String, String>{
      'Accept': 'application/vnd.api+json',
      'access-token': pref.getString("token"),
      'client': pref.getString("client"),
      'uid': pref.getString("uid")
    },
    body: {"id": id.toString()},
  );
  print(response.body);
}
