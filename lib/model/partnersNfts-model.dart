class PartnerNftsModel {
  String? sId;
  String? userId;
  String? currentOwner;
  int? type;
  String? file;
  String? price;
  User? user;
  String? unlockableContent;
  Voucher? voucher;
  bool? isPrivate;
  int? noOfCopy;
  var noOfCopyOnMarketPlace;
  var available;
  var is_liked;
  String? name;
  String? tokenId;
  String? ownerWalletAddress;
  String? auctionId;
  int? isLazyMint;
  String? mediaType;
  String? description;
  String? alternativeDescription;
  int? royalty;
  String? firstName;
  String? userName;
  String? lastName;
  String? email;
  int? phoneNo;
  String? countryCode;
  int? likesCount;
  int? commentCount;
  String? collectionName;
  String? collectionAddress;
  String? coverImage;
  String? coverImageYAxis;
  String? imageSize;
  String? profilePic;

  PartnerNftsModel(
      {this.sId,
        this.userId,
        this.currentOwner,
        this.type,
        this.file,
        this.price,
        this.user,
        this.unlockableContent,
        this.voucher,
        this.is_liked,
        this.isPrivate,
        this.noOfCopy,
        this.noOfCopyOnMarketPlace,
        this.available,
        this.name,
        this.tokenId,
        this.ownerWalletAddress,
        this.auctionId,
        this.isLazyMint,
        this.mediaType,
        this.description,
        this.alternativeDescription,
        this.royalty,
        this.firstName,
        this.userName,
        this.lastName,
        this.email,
        this.phoneNo,
        this.countryCode,
        this.likesCount,
        this.commentCount,
        this.collectionName,
        this.collectionAddress,
        this.coverImage,
        this.coverImageYAxis,
        this.imageSize,
        this.profilePic});

  PartnerNftsModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['user_id'];
    currentOwner = json['current_owner'];
    type = json['type'];
    file = json['file'];
    price = json['price'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    unlockableContent = json['unlockable_content'];
    voucher =
    json['voucher'] != null ? Voucher.fromJson(json['voucher']) : null;
    isPrivate = json['is_private'];
    noOfCopy = json['no_of_copy'];
    noOfCopyOnMarketPlace = json['no_of_copy_on_market_place'];
    available = json['available'];
    name = json['name'];
    tokenId = json['token_id'];
    ownerWalletAddress = json['owner_wallet_address'];
    auctionId = json['auction_id'];
    isLazyMint = json['is_lazy_mint'];
    mediaType = json['media_type'];
    description = json['description'];
    alternativeDescription = json['alternative_description'];
    royalty = json['royalty'];
    firstName = json['first_name'];
    userName = json['user_name'];
    lastName = json['last_name'];
    email = json['email'];
    phoneNo = json['phone_no'];
    countryCode = json['country_code'];
    likesCount = json['likes_count'];
    commentCount = json['comment_count'];
    collectionName = json['collection_name'];
    collectionAddress = json['collection_address'];
    coverImage = json['cover_image'];
    coverImageYAxis = json['cover_image_y_axis'];
    imageSize = json['image_size'];
    profilePic = json['profile_pic'];
    is_liked = json['is_liked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['user_id'] = this.userId;
    data['current_owner'] = this.currentOwner;
    data['type'] = this.type;
    data['file'] = this.file;
    data['price'] = this.price;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['unlockable_content'] = this.unlockableContent;
    if (this.voucher != null) {
      data['voucher'] = this.voucher!.toJson();
    }
    data['is_private'] = this.isPrivate;
    data['no_of_copy'] = this.noOfCopy;
    data['no_of_copy_on_market_place'] = this.noOfCopyOnMarketPlace;
    data['available'] = this.available;
    data['name'] = this.name;
    data['token_id'] = this.tokenId;
    data['owner_wallet_address'] = this.ownerWalletAddress;
    data['auction_id'] = this.auctionId;
    data['is_lazy_mint'] = this.isLazyMint;
    data['media_type'] = this.mediaType;
    data['description'] = this.description;
    data['alternative_description'] = this.alternativeDescription;
    data['royalty'] = this.royalty;
    data['first_name'] = this.firstName;
    data['user_name'] = this.userName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['phone_no'] = this.phoneNo;
    data['country_code'] = this.countryCode;
    data['likes_count'] = this.likesCount;
    data['comment_count'] = this.commentCount;
    data['collection_name'] = this.collectionName;
    data['collection_address'] = this.collectionAddress;
    data['cover_image'] = this.coverImage;
    data['cover_image_y_axis'] = this.coverImageYAxis;
    data['image_size'] = this.imageSize;
    data['profile_pic'] = this.profilePic;
    return data;
  }
}

class User {
  String? sId;
  String? firstName;
  String? userName;
  String? lastName;
  String? email;
  int? phoneNo;
  String? countryCode;
  String? coverImage;
  String? coverImageYAxis;
  String? imageSize;
  String? profilePic;

  User(
      {this.sId,
        this.firstName,
        this.userName,
        this.lastName,
        this.email,
        this.phoneNo,
        this.countryCode,
        this.coverImage,
        this.coverImageYAxis,
        this.imageSize,
        this.profilePic});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['first_name'];
    userName = json['user_name'];
    lastName = json['last_name'];
    email = json['email'];
    phoneNo = json['phone_no'];
    countryCode = json['country_code'];
    coverImage = json['cover_image'];
    coverImageYAxis = json['cover_image_y_axis'];
    imageSize = json['image_size'];
    profilePic = json['profile_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['first_name'] = this.firstName;
    data['user_name'] = this.userName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['phone_no'] = this.phoneNo;
    data['country_code'] = this.countryCode;
    data['cover_image'] = this.coverImage;
    data['cover_image_y_axis'] = this.coverImageYAxis;
    data['image_size'] = this.imageSize;
    data['profile_pic'] = this.profilePic;
    return data;
  }
}

class Voucher {
  int? tokenId;
  Null? minPrice;
  int? auctionType;
  int? quantity;
  int? endTime;
  int? salt;

  Voucher(
      {this.tokenId,
        this.minPrice,
        this.auctionType,
        this.quantity,
        this.endTime,
        this.salt});

  Voucher.fromJson(Map<String, dynamic> json) {
    tokenId = json['tokenId'];
    minPrice = json['minPrice'];
    auctionType = json['auctionType'];
    quantity = json['quantity'];
    endTime = json['endTime'];
    salt = json['salt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tokenId'] = this.tokenId;
    data['minPrice'] = this.minPrice;
    data['auctionType'] = this.auctionType;
    data['quantity'] = this.quantity;
    data['endTime'] = this.endTime;
    data['salt'] = this.salt;
    return data;
  }
}
