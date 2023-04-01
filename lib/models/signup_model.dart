class Sigup {
  final String email;
  final String phone;

  Sigup(this.email, this.phone);

  Sigup.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        phone = json['phone'];

  Map<String, dynamic> toJson() => {
    'email': email,
    'phone': phone,
  };
}
