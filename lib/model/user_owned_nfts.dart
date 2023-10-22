
class UserOwnedNfts {
  UserOwnedNfts({
      required this.id,
      required this.userId,
      required this.ownerId,
      required this.currentOwner,
      required this.collectionId,
      required this.collectionAddress,
      required this.type,
      required this.file,
      required this.price,
      required this.unlockableContent,
      required this.voucher,
      required this.isPrivate,
      required this.noOfCopy,
      required this.available,
      required this.noOfCopyOnMarketPlace,
      required this.name,
      required this.bids,
      required this.owner,
      required this.tokenId,
      required this.ownerWalletAddress,
      required this.auctionId,
      required this.isLazyMint,
      required this.mediaType,
      required this.description,
      required this.alternativeDescription,
      required this.royalty,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.phoneNo,
      required this.countryCode,
      required this.likesCount,
      required this.commentCount,
      required this.collectionName,
      required this.isLiked,
      required this.createdAt,});

  UserOwnedNfts.fromJson(dynamic json) {
    id = json['_id'];
    userId = json['user_id'];
    ownerId = json['owner_id'];
    currentOwner = json['current_owner'];
    collectionId = json['collection_id'];
    collectionAddress = json['collection_address'];
    type = json['type'];
    file = json['file'];
    price = json['price'];
    unlockableContent = json['unlockable_content'];
    voucher = json['voucher'];
    isPrivate = json['is_private'];
    noOfCopy = json['no_of_copy'];
    available = json['available'];
    noOfCopyOnMarketPlace = json['no_of_copy_on_market_place'];
    name = json['name'];
    bids = json['bids'];
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
    tokenId = json['token_id'];
    ownerWalletAddress = json['owner_wallet_address'];
    auctionId = json['auction_id'];
    isLazyMint = json['is_lazy_mint'];
    mediaType = json['media_type'];
    description = json['description'];
    alternativeDescription = json['alternative_description'];
    royalty = json['royalty'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phoneNo = json['phone_no'];
    countryCode = json['country_code'];
    likesCount = json['likes_count'];
    commentCount = json['comment_count'];
    collectionName = json['collection_name'];
    isLiked = json['is_liked'];
    createdAt = json['created_at'];
  }
  String? id;
  String? userId;
  String? ownerId;
  dynamic currentOwner;
  String? collectionId;
  String? collectionAddress;
  int? type;
  String? file;
  dynamic price;
  dynamic unlockableContent;
  dynamic voucher;
  bool? isPrivate;
  int? noOfCopy;
  int? available;
  int? noOfCopyOnMarketPlace;
  String? name;
  dynamic bids;
  Owner? owner;
  String? tokenId;
  String? ownerWalletAddress;
  String? auctionId;
  int? isLazyMint;
  String? mediaType;
  String? description;
  dynamic alternativeDescription;
  int? royalty;
  String? firstName;
  String? lastName;
  String? email;
  int? phoneNo;
  String? countryCode;
  int? likesCount;
  int? commentCount;
  String? collectionName;
  bool? isLiked;
  String? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['user_id'] = userId;
    map['owner_id'] = ownerId;
    map['current_owner'] = currentOwner;
    map['collection_id'] = collectionId;
    map['collection_address'] = collectionAddress;
    map['type'] = type;
    map['file'] = file;
    map['price'] = price;
    map['unlockable_content'] = unlockableContent;
    map['voucher'] = voucher;
    map['is_private'] = isPrivate;
    map['no_of_copy'] = noOfCopy;
    map['available'] = available;
    map['no_of_copy_on_market_place'] = noOfCopyOnMarketPlace;
    map['name'] = name;
    map['bids'] = bids;
    if (owner != null) {
      map['owner'] = owner!.toJson();
    }
    map['token_id'] = tokenId;
    map['owner_wallet_address'] = ownerWalletAddress;
    map['auction_id'] = auctionId;
    map['is_lazy_mint'] = isLazyMint;
    map['media_type'] = mediaType;
    map['description'] = description;
    map['alternative_description'] = alternativeDescription;
    map['royalty'] = royalty;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['email'] = email;
    map['phone_no'] = phoneNo;
    map['country_code'] = countryCode;
    map['likes_count'] = likesCount;
    map['comment_count'] = commentCount;
    map['collection_name'] = collectionName;
    map['is_liked'] = isLiked;
    map['created_at'] = createdAt;
    return map;
  }

}
class Owner {
  String? id;
  String? nftId;
  String? ownerId;
  String? ownerWalletAddress;
  int? noOfCopy;
  int? noOfCopyOnMarketPlace;
  int? available;
  int? price;
  bool? isPrivate;
  dynamic auctionTime;
  int? auctionType;
  int? isOnMarketPlace;
  int? isGifted;
  int? isTransfered;
  String? transactionHash;
  dynamic status;
  String? createdAt;
  int? v;
  Owner({
    required this.id,
    required this.nftId,
    required this.ownerId,
    required this.ownerWalletAddress,
    required this.noOfCopy,
    required this.noOfCopyOnMarketPlace,
    required this.available,
    required this.price,
    required this.isPrivate,
    required this.auctionTime,
    required this.auctionType,
    required this.isOnMarketPlace,
    required this.isGifted,
    required this.isTransfered,
    required this.transactionHash,
    required this.status,
    required this.createdAt,
    required this.v,});

  Owner.fromJson(dynamic json) {
    id = json['_id'];
    nftId = json['nft_id'];
    ownerId = json['owner_id'];
    ownerWalletAddress = json['owner_wallet_address'];
    noOfCopy = json['no_of_copy'];
    noOfCopyOnMarketPlace = json['no_of_copy_on_market_place'];
    available = json['available'];
    price = json['price'];
    isPrivate = json['is_private'];
    auctionTime = json['auction_time'];
    auctionType = json['auction_type'];
    isOnMarketPlace = json['is_on_market_place'];
    isGifted = json['is_gifted'];
    isTransfered = json['is_transfered'];
    transactionHash = json['transaction_hash'];
    status = json['status'];
    createdAt = json['created_at'];
    v = json['__v'];
  }
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['nft_id'] = nftId;
    map['owner_id'] = ownerId;
    map['owner_wallet_address'] = ownerWalletAddress;
    map['no_of_copy'] = noOfCopy;
    map['no_of_copy_on_market_place'] = noOfCopyOnMarketPlace;
    map['available'] = available;
    map['price'] = price;
    map['is_private'] = isPrivate;
    map['auction_time'] = auctionTime;
    map['auction_type'] = auctionType;
    map['is_on_market_place'] = isOnMarketPlace;
    map['is_gifted'] = isGifted;
    map['is_transfered'] = isTransfered;
    map['transaction_hash'] = transactionHash;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['__v'] = v;
    return map;
  }

}