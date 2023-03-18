class ChangePasswordModel {
  String email;
  String currentPassword;
  String newPassword;

  ChangePasswordModel(this.email, this.currentPassword, this.newPassword);

  @override
  String toString() {
    return 'ChangePasswordModel[email=$email, currentPassword=$currentPassword, newPassword=$newPassword, ]';
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'currentPassword': currentPassword,
      'newPassword': newPassword
    };
  }
}
