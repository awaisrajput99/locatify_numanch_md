class MdUserModel {
  final String? id;
  final String fullName;
  final String email;
  final String phoneNumber;
  final String password;

  const MdUserModel(
      {required this.id,
      required this.fullName,
      required this.email,
      required this.phoneNumber,
      required this.password
      });

  toJson(){
    return {
      "FullName": fullName,
      "Email": email,
      "PhoneNumber": phoneNumber,
      "Password": password
    };
  }
}
