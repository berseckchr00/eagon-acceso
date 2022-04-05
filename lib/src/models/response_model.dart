import 'dart:convert';

class ResponseModel {
  bool success;
  String message;
  String errorList;

  ResponseModel({this.success, this.message, this.errorList});

  ResponseModel accesoModelFromJson(String str) =>
      ResponseModel.fromJson(json.decode(str));

  String accesoToJson(ResponseModel data) => json.encode(data.toJson());

  factory ResponseModel.fromJson(Map json) => ResponseModel(
      success: json["success"],
      message: json["msg"],
      errorList: json["errors"]);

  Map<String, dynamic> toJson() =>
      {"success": success, "message": message, "errorList": errorList};
}
