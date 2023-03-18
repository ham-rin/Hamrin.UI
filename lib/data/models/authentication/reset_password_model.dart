class ResetPasswordModel {
  String email;
  String password;
  String token;

  ResetPasswordModel(this.email, this.password, this.token);

  @override
  String toString() {
    return 'ResetPasswordModel[email=$email, password=$password, token=$token, ]';
  }

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password, 'token': token};
  }
}
