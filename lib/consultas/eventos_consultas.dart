import 'package:dio/dio.dart';
import 'package:sisparty/utils/constants.dart';
import '../models/evento_model.dart';


class EventoConsulta {
  final _dio = Dio(BaseOptions(baseUrl: BASEURL));


  Future<List<Evento>> getEventos() async {
    _dio.options.headers['Accept'] = "application/vnd.api+json";
    final resp = await  _dio.get('/events');

//    return List<Evento>.from(resp.data.map((evento) => Evento.fromJson(evento)));
  }

  Future<Evento> getEvento(int id) async {
    return null;
  }

  Future<Evento> createEvento(Evento evento) async {
    return null;
  }

}