// To parse this JSON data, do
//
//     final community = communityFromJson(jsonString);

import 'dart:convert';

Community communityFromJson(String str) => Community.fromJson(json.decode(str));

String communityToJson(Community data) => json.encode(data.toJson());

class Community {
  int count;
  List<Datum> data;

  Community({
    required this.count,
    required this.data,
  });

  factory Community.fromJson(Map<String, dynamic> json) => Community(
    count: json["count"]??0,
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String id;
  String? firstName;
  String? userName;
  String? profilePic;

  Datum({
    required this.id,
    required this.firstName,
    required this.userName,
    required this.profilePic,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    firstName: json["first_name"],
    userName: json["user_name"],
    profilePic: json["profile_pic"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "first_name": firstName,
    "user_name": userName,
    "profile_pic": profilePic,
  };
}
