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
    return data;
  }
}

Future<dynamic> todosEventosCliente() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  final Client client = HttpClientWithInterceptor.build(
    interceptors: [LoggingInterceptor()],
  );
  final Response response = await client.get(
    url_base + 'events/client',
    headers: <String, String>{
      'Accept': 'application/vnd.api+json',
      'access-token': pref.getString("token"),
      'client': pref.getString("client"),
      'uid': pref.getString("uid")
    },
  );
  final data = json.decode(response.body);
  final eventsOpened = data['events_opened'] as List;
  final List<Evento> eventosAbertos = List();
  for (Map<String, dynamic> eventoJson in (eventsOpened)) {
    final Evento eventoAberto = Evento(
        eventoJson['id'],
        eventoJson['name'],
        eventoJson['description'],
        eventoJson['realization_date'],
        eventoJson['local'],
        eventoJson['situation'],
        eventoJson['event_type'],
        eventoJson['created_at']);
    eventosAbertos.add(eventoAberto);
  }
  final eventsClosed = data['events_closed'] as List;
  final List<Evento> eventosFechados = List();
  for (Map<String, dynamic> eventoJson in (eventsClosed)) {
    final Evento eventoFechado = Evento(
        eventoJson['id'],
        eventoJson['name'],
        eventoJson['description'],
        eventoJson['realization_date'],
        eventoJson['local'],
        eventoJson['situation'],
        eventoJson['event_type'],
        eventoJson['created_at']);
    eventosFechados.add(eventoFechado);
  }
  final eventsFinished = data['events_finished'] as List;
  final List<Evento> eventosFinalizados = List();
  for (Map<String, dynamic> eventoJson in (eventsFinished)) {
    final Evento eventoFinalizado = Evento(
        eventoJson['id'],
        eventoJson['name'],
        eventoJson['description'],
        eventoJson['realization_date'],
        eventoJson['local'],
        eventoJson['situation'],
        eventoJson['event_type'],
        eventoJson['created_at']);
    eventosFinalizados.add(eventoFinalizado);
  }
  return {
    "eventos_abertos": eventosAbertos,
    "eventos_fechados": eventosFechados,
    "eventos_finalizados": eventosFinalizados
  };
}

Future<dynamic> todosEventosFornecedor() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  final Client client = HttpClientWithInterceptor.build(
    interceptors: [LoggingInterceptor()],
  );
  final Response response = await client.get(
    url_base + 'events/provider',
    headers: <String, String>{
      'Accept': 'application/vnd.api+json',
      'access-token': pref.getString("token"),
      'client': pref.getString("client"),
      'uid': pref.getString("uid")
    },
  );
  print(response.body);
  final data = json.decode(response.body);
  final rest = data as List;
  final List<Evento> eventos = List();
  for (Map<String, dynamic> eventoJson in (rest)) {
    final Evento evento = Evento(
        eventoJson['id'],
        eventoJson['name'],
        eventoJson['description'],
        eventoJson['realization_date'],
        eventoJson['local'],
        eventoJson['situation'],
        eventoJson['event_type'],
        eventoJson['created_at']);
    eventos.add(evento);
  }
  return {"eventos": eventos};
}

Future<Evento> findEvento(id) async {
  final Client client = HttpClientWithInterceptor.build(
    interceptors: [LoggingInterceptor()],
  );
  final Response response =
      await client.get(url_base + 'event/' + id.toString());
  final data = json.decode(response.body);
  final Evento evento = Evento(
      data['id'],
      data['name'],
      data['description'],
      data['realization_date'],
      data['local'],
      data['situation'],
      data['event_type'],
      data['created_at']);
  return evento;
}

void criarEvento(data) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  final Client client = HttpClientWithInterceptor.build(
    interceptors: [LoggingInterceptor()],
  );
  final Response response = await client.post(
    url_base + 'events',
    headers: <String, String>{
      'Accept': 'application/vnd.api+json',
      'access-token': pref.getString("token"),
      'client': pref.getString("client"),
      'uid': pref.getString("uid")
    },
    body: data,
  );
  print(response.body);
}

void closedEvent(id) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  final Client client = HttpClientWithInterceptor.build(
    interceptors: [LoggingInterceptor()],
  );
  final Response response = await client.post(
    url_base + 'event/closed/',
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
