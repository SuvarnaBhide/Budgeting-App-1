// ignore_for_file: prefer_collection_literals, unnecessary_this

class Note {
  String? name;
  String? username;
  String? email;
  String? number;
  String? password;

  Note({
    required this.name,
    required this.username,
    required this.email,
    required this.number,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['name'] = name;
    map['username'] = username;
    map['email'] = email;
    map['number'] = number;
    map['password'] = password;

    return map;
  }

  Note.fromMapObject(Map<String, dynamic> map) {
    this.name = map['name'];
    this.username = map['username'];
    this.email = map['email'];
    this.number = map['number'];
    this.password = map['password'];
  }
}
