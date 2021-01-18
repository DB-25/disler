class LoginModel {
  String email;
  String password;

  LoginModel({
    this.email,
    this.password,
  });

  factory LoginModel.fromMap(Map<String, dynamic> map) {
    return LoginModel(
      email: map.containsKey('email') ? (map['email'] ?? '') : '',
      password: map.containsKey('password') ? (map['password'] ?? '') : '',
    );
  }
}
