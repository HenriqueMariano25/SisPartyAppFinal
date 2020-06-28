class Usuario {
  int id;
  String email;
  String provider;
  String uid;
  bool allowPasswordChange;
  Null name;
  Null nickname;
  Null image;
  Null typeUser;

  Usuario(
      {this.id,
        this.email,
        this.provider,
        this.uid,
        this.allowPasswordChange,
        this.name,
        this.nickname,
        this.image,
        this.typeUser});

  Usuario.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    provider = json['provider'];
    uid = json['uid'];
    allowPasswordChange = json['allow_password_change'];
    name = json['name'];
    nickname = json['nickname'];
    image = json['image'];
    typeUser = json['type_user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['provider'] = this.provider;
    data['uid'] = this.uid;
    data['allow_password_change'] = this.allowPasswordChange;
    data['name'] = this.name;
    data['nickname'] = this.nickname;
    data['image'] = this.image;
    data['type_user'] = this.typeUser;
    return data;
  }

}
