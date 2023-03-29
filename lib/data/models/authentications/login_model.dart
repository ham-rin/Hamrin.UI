class LoginModel {
  String email;
  String password;

  LoginModel(this.email, this.password);

  @override
  String toString() {
    return 'AuthModel[email=$email, password=$password, ]';
  }

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }
}
