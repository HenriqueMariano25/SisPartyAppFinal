class Evento{
  int id;
  String nome;
  String descricao;
  String dataRealizacao;
  bool local;
  String situacao;
  String tipoEventoId;
  String createdAt;
//  String updatedAt;

  Evento(
    this.id,
    this.nome,
    this.descricao,
    this.dataRealizacao,
    this.local,
    this.situacao,
    this.tipoEventoId,
    this.createdAt,
//    this.updatedAt,
  );

//  Evento.fromJson(Map<String, dynamic> json){
//    id = json['id'];
//    nome = json[''];
//    descricao = json['descricao'];
//    dataRealizacao = json['dataRealizacao'];
//    local = json['local'];
//    situacao = json['situacao'];
//    tipoEventoId = json['tipoEventoId'];
//    createdAt = json['created_at'];
//    updatedAt = json['updated_at'];
//
//  }

//  Map<String, dynamic> toJson(){
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['nome'] = this.nome;
//    data['descricao'] = this.descricao;
//    data['dataRealizacao'] = this.dataRealizacao;
//    data['local'] = this.local;
//    data['situacao'] = this.situacao;
//    data['tipoEventoId'] = this.tipoEventoId;
//    return data;
//  }
}