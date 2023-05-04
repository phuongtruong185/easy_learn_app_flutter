class ChangePass {
  final String password;
  final String newpassword;

  ChangePass(this.password, this.newpassword);

  ChangePass.fromJson(Map<String, dynamic> json)
      : password = json['password'],
        newpassword = json['newpassword'];

  Map<String, dynamic> toJson() => {
        'password': password,
        'newpassword': newpassword,
      };
}
