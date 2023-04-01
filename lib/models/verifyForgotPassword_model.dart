class VerifyForgotPassword {
  final String email;
  final String otp;
  final String password;

  VerifyForgotPassword(this.email, this.otp, this.password);

  VerifyForgotPassword.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        otp = json['otp'],
        password = json['password'];

  Map<String, dynamic> toJson() => {
    'email': email,
    'otp': otp,
    'password': password,
  };
}
