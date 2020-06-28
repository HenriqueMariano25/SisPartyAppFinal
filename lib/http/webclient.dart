import 'dart:convert';
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



Future<List<Evento>> findAllEventos() async {
  final Client client = HttpClientWithInterceptor.build(
    interceptors: [LoggingInterceptor()],
  );
  final Response response = await client.get(url_base + 'events');
  final data = json.decode(response.body);
  final rest = data['events_accepts'] as List;
  final List<Evento> eventos = List();
  for (Map<String, dynamic> eventoJson in (rest) ) {
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
  return eventos;
}

Future<Evento> findEvento(id) async {
  final Client client = HttpClientWithInterceptor.build(
    interceptors: [LoggingInterceptor()],
  );
  final Response response = await client.get(url_base + 'event/' + id.toString());
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
//void creatUser() async{
//  var json_teste = {
//    "email":"teste108@teste.com",
//    "password":"123456789",
//    "password_confirmation":"123456789",
//    "type_user":"Cliente",
//    "name": "Henrique"
//  };
//  final Response response = await post(
//    url_base + 'auth',
//    body: json.encode(json_teste),
//    headers:  {"Accept": "Basic application/vnd.api+json", "Content-Type":"application/json"},
//      encoding: encoding
//  );
//  print(response)
//}
