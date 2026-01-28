class AdminInfoModel {
  UserData? data;

  AdminInfoModel({this.data});

  AdminInfoModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new UserData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class UserData {
  User? user;

  UserData({this.user});

  UserData.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  String? username;
  String? adminName;
  String? adminEmail;
  String? loginExpiry;
  bool? adminEmailVerified;

  User(
      {this.username,
      this.adminName,
      this.adminEmail,
      this.loginExpiry,
      this.adminEmailVerified});

  User.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    adminName = json['admin_name'];
    adminEmail = json['admin_email'];
    loginExpiry = json['login_expiry'];
    adminEmailVerified = json['admin_email_verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['admin_name'] = this.adminName;
    data['admin_email'] = this.adminEmail;
    data['login_expiry'] = this.loginExpiry;
    data['admin_email_verified'] = this.adminEmailVerified;
    return data;
  }
}
