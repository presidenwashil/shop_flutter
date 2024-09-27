class User {
  int? id;
  String? name;
  String? email;
  String? password;
  String? token;

  User({this.id, this.name, this.email, this.password, this.token});

  factory User.fromJson(Map<String, dynamic> obj) {
    return User(
        id: obj['id'],
        name: obj['name'],
        email: obj['email'],
        password: obj['password'],
        token: obj['token']);
  }

}
