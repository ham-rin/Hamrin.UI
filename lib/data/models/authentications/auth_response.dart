class AuthResponse {
  late String username;
  late String token;
  late String refreshToken;
  late bool succeeded;
  late List<Errors> errors;

  AuthResponse.fromJson(Map<String, dynamic> json) {
    username = json['username'] ?? "";
    token = json['token'] ?? "";
    refreshToken = json['refreshToken'] ?? "";
    succeeded = json['succeeded'];
    if (json['errors'] != null) {
      errors = <Errors>[];
      json['errors'].forEach((v) {
        errors.add(Errors.fromJson(v));
      });
    }
  }
}

class Errors {
  String? code;
  String? enError;
  String? prError;

  Errors({this.code, this.enError, this.prError});

  Errors.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    enError = json['enError'];
    prError = json['prError'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['enError'] = enError;
    data['prError'] = prError;
    return data;
  }
}
