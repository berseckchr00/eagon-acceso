import 'dart:convert';

class AccessModel {
  String rut;
  String name;
  String user;
  String location;

  AccessModel({this.rut, this.name, this.user, this.location});

  AccessModel accesoModelFromJson(String str) =>
      AccessModel.fromJson(json.decode(str));

  String accesoToJson(AccessModel data) => json.encode(data.toJson());

  factory AccessModel.fromJson(Map<String, dynamic> json) => AccessModel(
      rut: json["rut"],
      name: json["name"],
      user: json["user"],
      location: json["location"]);

  Map<String, dynamic> toJson() =>
      {"rut": rut, "name": name, "user": user, "location": location};
}
