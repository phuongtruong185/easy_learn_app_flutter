class OtpForgotPassword {
  final String email;

  OtpForgotPassword(this.email);

  OtpForgotPassword.fromJson(Map<String, dynamic> json) : email = json['email'];

  Map<String, dynamic> toJson() => {
        'email': email,
      };
}
