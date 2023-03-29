class RefreshTokenModel {
  String token;
  String refreshToken;

  RefreshTokenModel(this.token, this.refreshToken);

  @override
  String toString() {
    return 'RefreshTokenModel[token=$token, refreshToken=$refreshToken, ]';
  }

  Map<String, dynamic> toJson() {
    return {'token': token, 'refreshToken': refreshToken};
  }
}
