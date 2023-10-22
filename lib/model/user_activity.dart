class UserActivity {
  String? id;
  String? activityBy;
  String? activityOn;
  int? noOfCopy;
  String? nftId;
  String? nftName;
  String? nftImage;
  String? mediaType;
  dynamic commentId;
  String? type;
  String? activityByFirstName;
  String? activityByLastName;
  String? activityByProfilePic;
  String? activityByUserName;
  String? activityOnFirstName;
  String? activityOnLastName;
  String? activityOnProfilePic;
  String? activityOnUserName;
  dynamic activityOnCoverImage;
  String? activityByCoverImage;
  String? createdAt;
  UserActivity({
      this.id, 
      this.activityBy, 
      this.activityOn, 
      this.noOfCopy, 
      this.nftId, 
      this.nftName, 
      this.nftImage, 
      this.mediaType, 
      this.commentId, 
      this.type, 
      this.activityByFirstName, 
      this.activityByLastName, 
      this.activityByProfilePic, 
      this.activityByUserName, 
      this.activityOnFirstName, 
      this.activityOnLastName, 
      this.activityOnProfilePic, 
      this.activityOnUserName, 
      this.activityOnCoverImage, 
      this.activityByCoverImage, 
      this.createdAt,});

  UserActivity.fromJson(dynamic json) {
    id = json['_id'];
    activityBy = json['activity_by'];
    activityOn = json['activity_on'];
    noOfCopy = json['no_of_copy'];
    nftId = json['nft_id'];
    nftName = json['nft_name'];
    nftImage = json['nft_image'];
    mediaType = json['media_type'];
    commentId = json['comment_id'];
    type = json['type'];
    activityByFirstName = json['activity_by_first_name'];
    activityByLastName = json['activity_by_last_name'];
    activityByProfilePic = json['activity_by_profile_pic'];
    activityByUserName = json['activity_by_user_name'];
    activityOnFirstName = json['activity_on_first_name'];
    activityOnLastName = json['activity_on_last_name'];
    activityOnProfilePic = json['activity_on_profile_pic'];
    activityOnUserName = json['activity_on_user_name'];
    activityOnCoverImage = json['activity_on_cover_image'];
    activityByCoverImage = json['activity_by_cover_image'];
    createdAt = json['created_at'];
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['activity_by'] = activityBy;
    map['activity_on'] = activityOn;
    map['no_of_copy'] = noOfCopy;
    map['nft_id'] = nftId;
    map['nft_name'] = nftName;
    map['nft_image'] = nftImage;
    map['media_type'] = mediaType;
    map['comment_id'] = commentId;
    map['type'] = type;
    map['activity_by_first_name'] = activityByFirstName;
    map['activity_by_last_name'] = activityByLastName;
    map['activity_by_profile_pic'] = activityByProfilePic;
    map['activity_by_user_name'] = activityByUserName;
    map['activity_on_first_name'] = activityOnFirstName;
    map['activity_on_last_name'] = activityOnLastName;
    map['activity_on_profile_pic'] = activityOnProfilePic;
    map['activity_on_user_name'] = activityOnUserName;
    map['activity_on_cover_image'] = activityOnCoverImage;
    map['activity_by_cover_image'] = activityByCoverImage;
    map['created_at'] = createdAt;
    return map;
  }

}