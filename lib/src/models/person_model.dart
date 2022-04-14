import 'dart:convert';

PersonModel PersonModelFromJson(String str) =>
    PersonModel.fromJson(json.decode(str));

String PersonModelToJson(PersonModel data) => json.encode(data.toJson());

class PersonModel {
  PersonModel({this.name, this.rut, this.genre, this.direction, this.city});

  String name;
  String rut;
  String genre;
  String direction;
  String city;

  factory PersonModel.fromJson(Map<String, dynamic> json) => PersonModel(
        name: json["name"],
        rut: json["rut"],
        genre: json["genre"],
        direction: json["direction"],
        city: json["city"],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'rut': rut,
        'genre': genre,
        'direction': direction,
        'city': city,
      };
}
