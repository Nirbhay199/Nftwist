class OurPartnersModel {
  String? sId;
  String? coverImage;
  String? profilePic;
  String? imageSize;
  String? firstName;
  String? lastName;
  String? userName;
  int? follower_count;
  int? following_count;

  OurPartnersModel(
      {this.sId,
        this.follower_count=0,
        this.following_count=0,
        this.coverImage,
        this.profilePic,
        this.imageSize,
        this.firstName,
        this.lastName,
        this.userName,});

  OurPartnersModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    coverImage = json['cover_image'];
    profilePic = json['profile_pic'];
    imageSize = json['image_size'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    userName = json['user_name'];
    follower_count = json['follower_count']??0;
    following_count = json['following_count']??0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['cover_image'] = this.coverImage;
    data['profile_pic'] = this.profilePic;
    data['image_size'] = this.imageSize;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['user_name'] = this.userName;
    data['follower_count'] = this.follower_count??0;
    data['following_count'] = this.following_count??0;
    return data;
  }
}
