
import 'Voucher.dart';

class MarketPlaceNfts {
  List<Metadata>? metadata;
  List<Data>? data;

  MarketPlaceNfts({this.metadata, this.data});

  MarketPlaceNfts.fromJson(Map<String, dynamic> json) {
    if (json['metadata'] != null) {
      metadata = <Metadata>[];
      json['metadata'].forEach((v) {
        metadata!.add(Metadata.fromJson(v));
      });
    }
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (metadata != null) {
      data['metadata'] = metadata!.map((v) => v.toJson()).toList();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Metadata {
  int? total;

  Metadata({this.total});

  Metadata.fromJson(Map<String, dynamic> json) {
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    return data;
  }
}

class Data {
  String? sId;
  String? userId;
  String? collectionId;
  String? currentOwner;
  int? type;
  String? file;
  double? price;
  String? unlockableContent;
  int? noOfCopy;
  String? name;
  List<Owner>? owner;
  String? tokenId;
  String? ownerWalletAddress;
  int? isLazyMint;
  String? mediaType;
  String? description;
  String? alternativeDescription;
  int? royalty;
  String? profilePic;
  String? collectionMedia;
  String? collectionMediaType;
  String? firstName;
  String? lastName;
  String? email;
  int? phoneNo;
  String? countryCode;
  int? likesCount;
  Voucher? voucher;
  bool? isPrivate;
  bool? isMostVisible;
  bool? isHot;
  int? commentCount;
  String? collectionName;
  String? nftResellId;
  int? availableCopies;
  List<Properties>? properties;
  bool? isLiked;

  Data(
      {this.sId,
        this.userId,
        this.collectionId,
        this.currentOwner,
        this.type,
        this.file,
        this.price,
        this.unlockableContent,
        this.noOfCopy,
        this.name,
        this.owner,
        this.tokenId,
        this.ownerWalletAddress,
        this.isLazyMint,
        this.mediaType,
        this.description,
        this.alternativeDescription,
        this.royalty,
        this.profilePic,
        this.collectionMedia,
        this.collectionMediaType,
        this.firstName,
        this.lastName,
        this.email,
        this.phoneNo,
        this.countryCode,
        this.likesCount,
        this.voucher,
        this.isPrivate,
        this.isMostVisible,
        this.isHot,
        this.commentCount,
        this.collectionName,
        this.nftResellId,
        this.availableCopies,
        this.properties,
        this.isLiked});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['user_id'];
    collectionId = json['collection_id'];
    currentOwner = json['current_owner'];
    type = json['type'];
    file = json['file'];
    price = json['price'];
    unlockableContent = json['unlockable_content'];
    noOfCopy = json['no_of_copy'];
    name = json['name'];
    if (json['owner'] != null) {
      owner = <Owner>[];
      json['owner'].forEach((v) {
        owner!.add(Owner.fromJson(v));
      });
    }
    tokenId = json['token_id'];
    ownerWalletAddress = json['owner_wallet_address'];
    isLazyMint = json['is_lazy_mint'];
    mediaType = json['media_type'];
    description = json['description'];
    alternativeDescription = json['alternative_description'];
    royalty = json['royalty'];
    profilePic = json['profile_pic'];
    collectionMedia = json['collection_media'];
    collectionMediaType = json['collection_media_type'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phoneNo = json['phone_no'];
    countryCode = json['country_code'];
    likesCount = json['likes_count'];
    voucher =
    json['voucher'] != null ? Voucher.fromJson(json['voucher']) : null;
    isPrivate = json['is_private'];
    isMostVisible = json['is_most_visible'];
    isHot = json['is_hot'];
    commentCount = json['comment_count'];
    collectionName = json['collection_name'];
    nftResellId = json['nft_resell_id'];
    availableCopies = json['available_copies'];
    if (json['properties'] != null) {
      properties = <Properties>[];
      json['properties'].forEach((v) {
        properties!.add(Properties.fromJson(v));
      });
    }
    isLiked = json['is_liked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['user_id'] = userId;
    data['collection_id'] = collectionId;
    data['current_owner'] = currentOwner;
    data['type'] = type;
    data['file'] = file;
    data['price'] = price;
    data['unlockable_content'] = unlockableContent;
    data['no_of_copy'] = noOfCopy;
    data['name'] = name;
    if (owner != null) {
      data['owner'] = owner!.map((v) => v.toJson()).toList();
    }
    data['token_id'] = tokenId;
    data['owner_wallet_address'] = ownerWalletAddress;
    data['is_lazy_mint'] = isLazyMint;
    data['media_type'] = mediaType;
    data['description'] = description;
    data['alternative_description'] = alternativeDescription;
    data['royalty'] = royalty;
    data['profile_pic'] = profilePic;
    data['collection_media'] = collectionMedia;
    data['collection_media_type'] = collectionMediaType;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['phone_no'] = phoneNo;
    data['country_code'] = countryCode;
    data['likes_count'] = likesCount;
    if (voucher != null) {
      data['voucher'] = voucher!.toJson();
    }
    data['is_private'] = isPrivate;
    data['is_most_visible'] = isMostVisible;
    data['is_hot'] = isHot;
    data['comment_count'] = commentCount;
    data['collection_name'] = collectionName;
    data['nft_resell_id'] = nftResellId;
    data['available_copies'] = availableCopies;
    if (properties != null) {
      data['properties'] = properties!.map((v) => v.toJson()).toList();
    }
    data['is_liked'] = isLiked;
    return data;
  }
}

class Owner {
  String? sId;
  String? nftId;
  String? ownerId;
  String? ownerWalletAddress;
  int? noOfCopy;
  int? noOfCopyOnMarketPlace;
  int? available;
  var price;
  bool? isPrivate;
  String? auctionTime;
  int? auctionType;
  int? isOnMarketPlace;
  int? isGifted;
  String? transactionHash;
  String? status;
  String? createdAt;
  int? iV;

  Owner(
      {this.sId,
        this.nftId,
        this.ownerId,
        this.ownerWalletAddress,
        this.noOfCopy,
        this.noOfCopyOnMarketPlace,
        this.available,
        this.price,
        this.isPrivate,
        this.auctionTime,
        this.auctionType,
        this.isOnMarketPlace,
        this.isGifted,
        this.transactionHash,
        this.status,
        this.createdAt,
        this.iV});

  Owner.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
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
    transactionHash = json['transaction_hash'];
    status = json['status'];
    createdAt = json['created_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['nft_id'] = nftId;
    data['owner_id'] = ownerId;
    data['owner_wallet_address'] = ownerWalletAddress;
    data['no_of_copy'] = noOfCopy;
    data['no_of_copy_on_market_place'] = noOfCopyOnMarketPlace;
    data['available'] = available;
    data['price'] = price;
    data['is_private'] = isPrivate;
    data['auction_time'] = auctionTime;
    data['auction_type'] = auctionType;
    data['is_on_market_place'] = isOnMarketPlace;
    data['is_gifted'] = isGifted;
    data['transaction_hash'] = transactionHash;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['__v'] = iV;
    return data;
  }
}


class Properties {
  String? key;
  String? value;

  Properties({this.key, this.value});

  Properties.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['value'] = value;
    return data;
  }
}
