class EmailConfirmationModel {
  String email;
  String code;

  EmailConfirmationModel(this.email, this.code);

  @override
  String toString() {
    return 'EmailConfirmationModel[email=$email, code=$code, ]';
  }

  Map<String, dynamic> toJson() {
    return {'email': email, 'code': code};
  }
}
