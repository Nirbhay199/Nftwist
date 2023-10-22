// To parse this JSON data, do
//
//     final notification = notificationFromJson(jsonString);

import 'dart:convert';

List<Notification> notificationFromJson(String str) => List<Notification>.from(json.decode(str).map((x) => Notification.fromJson(x)));

String notificationToJson(List<Notification> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Notification {
  String id;
  SentTo sentTo;
  SentTo? partnerId;
  NftId nftId;
  String message;
  String type;
  bool isRead;
  String createdAt;
  SentTo? sentBy;

  Notification({
    required this.id,
    required this.sentTo,
    required this.partnerId,
    required this.nftId,
    required this.message,
    required this.type,
    required this.isRead,
    required this.createdAt,
    this.sentBy,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
    id: json["_id"],
    sentTo: SentTo.fromJson(json["sent_to"]),
    partnerId: json["partner_id"] == null ? null : SentTo.fromJson(json["partner_id"]),
    nftId: NftId.fromJson(json["nft_id"]),
    message: json["message"],
    type: json["type"],
    isRead: json["is_read"],
    createdAt: json["created_at"],
    sentBy: json["sent_by"] == null ? null : SentTo.fromJson(json["sent_by"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "sent_to": sentTo.toJson(),
    "partner_id": partnerId?.toJson(),
    "nft_id": nftId.toJson(),
    "message": message,
    "type": type,
    "is_read": isRead,
    "created_at": createdAt,
    "sent_by": sentBy?.toJson(),
  };
}

class NftId {
  String id;
  String mediaType;
  String file;
  String name;
  String description;

  NftId({
    required this.id,
    required this.mediaType,
    required this.file,
    required this.name,
    required this.description,
  });

  factory NftId.fromJson(Map<String, dynamic> json) => NftId(
    id: json["_id"],
    mediaType: json["media_type"],
    file: json["file"],
    name: json["name"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "media_type": mediaType,
    "file": file,
    "name": name,
    "description": description,
  };
}

class SentTo {
  String id;
  String firstName;
  String lastName;
  String userName;
  String profilePic;

  SentTo({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.profilePic,
  });

  factory SentTo.fromJson(Map<String, dynamic> json) => SentTo(
    id: json["_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    userName: json["user_name"],
    profilePic: json["profile_pic"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "first_name": firstName,
    "last_name": lastName,
    "user_name": userName,
    "profile_pic": profilePic,
  };
}
