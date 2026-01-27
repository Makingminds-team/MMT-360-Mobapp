class LoginModel {
  String? token;
  String? loginExpiry;
  bool? redirect;
  String? message;
  bool? success;

  LoginModel(
      {this.success,
      this.token,
      this.loginExpiry,
      this.redirect,
      this.message,});

  LoginModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    token = json['token'];
    loginExpiry = json['login_expiry'];
    redirect = json['redirect'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['token'] = this.token;
    data['login_expiry'] = this.loginExpiry;
    data['redirect'] = this.redirect;
    data['message'] = this.message;
    return data;
  }
}
