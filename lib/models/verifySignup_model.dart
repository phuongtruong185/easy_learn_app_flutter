class VerifySignup {
  final String first_name;
  final String last_name;
  final String password;
  final String otp;
  final String email;
  final String phone;

  VerifySignup(this.first_name, this.last_name, this.password, this.otp, this.email, this.phone);

  VerifySignup.fromJson(Map<String, dynamic> json)
      : first_name = json['first_name'],
        last_name = json['last_name'],
        password = json['password'],
        otp = json['otp'],
        email = json['email'],
        phone = json['phone'];

  Map<String, dynamic> toJson() => {
    'first_name': first_name,
    'last_name': last_name,
    'email': email,
    'phone': phone,
    'password': password,
    'otp': otp,
  };
}
