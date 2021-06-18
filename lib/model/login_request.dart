class LoginRequest {
  String userName;
  String password;
  String appName;

  LoginRequest({this.userName, this.password, this.appName});

  LoginRequest.fromJson(Map<String, dynamic> json) {
    userName = json['UserName'];
    password = json['Password'];
    appName = json['AppName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserName'] = this.userName;
    data['Password'] = this.password;
    data['AppName'] = this.appName;
    return data;
  }
}
