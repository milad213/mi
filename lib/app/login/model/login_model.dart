class LoginModel {
  String? token;
  String? error;

  LoginModel({this.token, this.error});

  LoginModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    error = json['error'];
  }

}