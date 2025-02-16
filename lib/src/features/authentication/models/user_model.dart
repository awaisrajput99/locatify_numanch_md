import 'package:cloud_firestore/cloud_firestore.dart';

class MdUserModel {
  late String id; // Change to non-nullable
  late String FullName;
  late String email;
  late String image;
  late String about;
  late String created_at;
  late String last_active;
  late bool is_online;
  late String push_token;
  late String phoneNumber;
  late String password;

  MdUserModel({
    required this.id, // Now required
    required this.FullName,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.image,
    required this.about,
    required this.created_at,
    required this.last_active,
    required this.is_online,
    required this.push_token,
  });

  MdUserModel.fromJson(Map<String, dynamic> json)
      : id = json["id"] ?? "",
        FullName = json["FullName"] ?? "",
        email = json["email"] ?? "",
        phoneNumber = json["phoneNumber"] ?? "",
        password = json["password"] ?? "",
        image = json["image"] ?? "",
        about = json["about"] ?? "",
        created_at = json["created_at"] ?? "",
        last_active = json["last_active"] ?? "",
        is_online = json["is_online"] ?? false,
        // Ensure boolean type
        push_token = json["push_token"] ?? "";

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data["image"] = image;
    data["about"] = about;
    data["created_at"] = created_at;
    data["last_active"] = last_active;
    data["is_online"] = is_online;
    data["push_token"] = push_token;
    data["PhoneNumber"] = phoneNumber;
    data["Password"] = password;
    data["email"] = email;
    data["FullName"] = FullName;
    data["id"] = id;
    return data;
  }
}
