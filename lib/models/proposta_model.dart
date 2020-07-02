import "package:sisparty/models/evento_model.dart";
class Proposta {
  int id;
  String description;
  String service;
  String serviceDescription;
  double value;
  String situation;
  int userId;
  String createdAt;
  Evento evento;

  Proposta(
      this.id,
      this.description,
      this.service,
      this.serviceDescription,
      this.value,
      this.situation,
      this.userId,
      this.createdAt,
      this.evento);
//  Proposta.fromJson(Map<String, dynamic> json) {
//    id = json['id'];
//    description = json['description'];
//    service = json['service'];
//    serviceDescription = json['service_description'];
//    value = json['value'];
//    situation = json['situation'];
//    eventId = json['event_id'];
//    userId = json['user_id'];
//    createdAt = json['created_at'];
//    updatedAt = json['updated_at'];
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['id'] = this.id;
//    data['description'] = this.description;
//    data['service'] = this.service;
//    data['service_description'] = this.serviceDescription;
//    data['value'] = this.value;
//    data['situation'] = this.situation;
//    data['event_id'] = this.eventId;
//    data['user_id'] = this.userId;
//    data['created_at'] = this.createdAt;
//    data['updated_at'] = this.updatedAt;
//    return data;
//  }
}
