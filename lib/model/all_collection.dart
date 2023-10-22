// To parse this JSON data, do
//
//     final collections = collectionsFromJson(jsonString);

import 'dart:convert';

Collections collectionsFromJson(String str) => Collections.fromJson(json.decode(str));

String collectionsToJson(Collections data) => json.encode(data.toJson());

class Collections {
  int count;
  List<Datum> data;

  Collections({
    required this.count,
    required this.data,
  });

  factory Collections.fromJson(Map<String, dynamic> json) => Collections(
    count: json["count"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String id;
  String? userId;
  String name;
  String? coverImage;
  dynamic image;
  String? description;
  String media;
  String mediaType;
  String? campaignDescription;
  String createdAt;
  int nftCount;
  Status status;
  String collectionAddress;
  bool isNftAdded;
  int? totalAvailableNfts;
  int totalNfts;
  List<Nft>? nft;

  Datum({
    required this.id,
    required this.userId,
    required this.name,
    required this.coverImage,
    required this.image,
    required this.description,
    required this.media,
    required this.mediaType,
    required this.campaignDescription,
    required this.createdAt,
    required this.nftCount,
    required this.status,
    required this.collectionAddress,
    required this.isNftAdded,
    required this.totalAvailableNfts,
    required this.totalNfts,
    required this.nft,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    userId: json["user_id"],
    name: json["name"],
    coverImage: json["cover_image"],
    image: json["image"],
    description: json["description"],
    media: json["media"],
    mediaType: json["media_type"],
    campaignDescription: json["campaign_description"],
    createdAt: json["created_at"],
    nftCount: json["nft_count"],
    status: statusValues.map[json["status"]]!,
    collectionAddress: json["collection_address"],
    isNftAdded: json["is_nft_added"],
    totalAvailableNfts: json["total_available_nfts"],
    totalNfts: json["total_nfts"],
    nft: json["nft"] == null ? [] : List<Nft>.from(json["nft"]!.map((x) => Nft.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "user_id": userId,
    "name": name,
    "cover_image": coverImage,
    "image": image,
    "description": description,
    "media": media,
    "media_type": mediaType,
    "campaign_description": campaignDescription,
    "created_at": createdAt,
    "nft_count": nftCount,
    "status": statusValues.reverse[status],
    "collection_address": collectionAddress,
    "is_nft_added": isNftAdded,
    "total_available_nfts": totalAvailableNfts,
    "total_nfts": totalNfts,
    "nft": nft == null ? [] : List<dynamic>.from(nft!.map((x) => x.toJson())),
  };
}

class Nft {
  String id;
  String userId;
  String collectionId;
  dynamic categoryId;
  dynamic otherCategory;
  int type;
  String mediaType;
  String file;
  dynamic hashImage;
  dynamic price;
  int wethPrice;
  dynamic unlockableContent;
  int noOfCopy;
  String name;
  String description;
  dynamic alternativeDescription;
  int royalty;
  String currentOwner;
  String createdAt;
  String auctionId;
  String tokenId;
  String? signature;
  int isLazyMint;
  int isOnMarketPlace;
  String ownerWalletAddress;
  String creatorWalletAddress;
  int available;
  String transactionHash;
  String txnId;
  Status status;
  String dataIpfs;
  bool isPrivate;
  bool isAuctionWindow;
  dynamic auctionTime;
  int auctionType;
  bool isExtraContent;
  dynamic extraContent;
  bool isGifted;
  dynamic giftedNftId;
  dynamic properties;
  bool isHot;
  bool isMostVisible;
  int v;
  Voucher? voucher;

  Nft({
    required this.id,
    required this.userId,
    required this.collectionId,
    required this.categoryId,
    required this.otherCategory,
    required this.type,
    required this.mediaType,
    required this.file,
    required this.hashImage,
    required this.price,
    required this.wethPrice,
    required this.unlockableContent,
    required this.noOfCopy,
    required this.name,
    required this.description,
    required this.alternativeDescription,
    required this.royalty,
    required this.currentOwner,
    required this.createdAt,
    required this.auctionId,
    required this.tokenId,
    required this.signature,
    required this.isLazyMint,
    required this.isOnMarketPlace,
    required this.ownerWalletAddress,
    required this.creatorWalletAddress,
    required this.available,
    required this.transactionHash,
    required this.txnId,
    required this.status,
    required this.dataIpfs,
    required this.isPrivate,
    required this.isAuctionWindow,
    required this.auctionTime,
    required this.auctionType,
    required this.isExtraContent,
    required this.extraContent,
    required this.isGifted,
    required this.giftedNftId,
    required this.properties,
    required this.isHot,
    required this.isMostVisible,
    required this.v,
    this.voucher,
  });

  factory Nft.fromJson(Map<String, dynamic> json) => Nft(
    id: json["_id"],
    userId: json["user_id"],
    collectionId: json["collection_id"],
    categoryId: json["category_id"],
    otherCategory: json["other_category"],
    type: json["type"],
    mediaType: json["media_type"],
    file: json["file"],
    hashImage: json["hash_image"],
    price: json["price"],
    wethPrice: json["weth_price"],
    unlockableContent: json["unlockable_content"],
    noOfCopy: json["no_of_copy"],
    name: json["name"],
    description: json["description"],
    alternativeDescription: json["alternative_description"],
    royalty: json["royalty"],
    currentOwner: json["current_owner"],
    createdAt: json["created_at"],
    auctionId: json["auction_id"],
    tokenId: json["token_id"],
    signature: json["signature"],
    isLazyMint: json["is_lazy_mint"],
    isOnMarketPlace: json["is_on_market_place"],
    ownerWalletAddress: json["owner_wallet_address"],
    creatorWalletAddress: json["creator_wallet_address"],
    available: json["available"],
    transactionHash: json["transaction_hash"],
    txnId: json["txn_id"],
    status: statusValues.map[json["status"]]!,
    dataIpfs: json["data_ipfs"],
    isPrivate: json["is_private"],
    isAuctionWindow: json["is_auction_window"],
    auctionTime: json["auction_time"],
    auctionType: json["auction_type"],
    isExtraContent: json["is_extra_content"],
    extraContent: json["extra_content"],
    isGifted: json["is_gifted"],
    giftedNftId: json["gifted_nft_id"],
    properties: json["properties"],
    isHot: json["is_hot"],
    isMostVisible: json["is_most_visible"],
    v: json["__v"],
    voucher: json["voucher"] == null ? null : Voucher.fromJson(json["voucher"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "user_id": userId,
    "collection_id": collectionId,
    "category_id": categoryId,
    "other_category": otherCategory,
    "type": type,
    "media_type": mediaType,
    "file": file,
    "hash_image": hashImage,
    "price": price,
    "weth_price": wethPrice,
    "unlockable_content": unlockableContent,
    "no_of_copy": noOfCopy,
    "name": name,
    "description": description,
    "alternative_description": alternativeDescription,
    "royalty": royalty,
    "current_owner": currentOwner,
    "created_at": createdAt,
    "auction_id": auctionId,
    "token_id": tokenId,
    "signature": signature,
    "is_lazy_mint": isLazyMint,
    "is_on_market_place": isOnMarketPlace,
    "owner_wallet_address": ownerWalletAddress,
    "creator_wallet_address": creatorWalletAddress,
    "available": available,
    "transaction_hash": transactionHash,
    "txn_id": txnId,
    "status": statusValues.reverse[status],
    "data_ipfs": dataIpfs,
    "is_private": isPrivate,
    "is_auction_window": isAuctionWindow,
    "auction_time": auctionTime,
    "auction_type": auctionType,
    "is_extra_content": isExtraContent,
    "extra_content": extraContent,
    "is_gifted": isGifted,
    "gifted_nft_id": giftedNftId,
    "properties": properties,
    "is_hot": isHot,
    "is_most_visible": isMostVisible,
    "__v": v,
    "voucher": voucher?.toJson(),
  };
}

enum Status {
  SUCCEEDED
}

final statusValues = EnumValues({
  "SUCCEEDED": Status.SUCCEEDED
});

class Voucher {
  int tokenId;
  dynamic minPrice;
  int auctionType;
  int quantity;
  int endTime;
  int salt;

  Voucher({
    required this.tokenId,
    required this.minPrice,
    required this.auctionType,
    required this.quantity,
    required this.endTime,
    required this.salt,
  });

  factory Voucher.fromJson(Map<String, dynamic> json) => Voucher(
    tokenId: json["tokenId"],
    minPrice: json["minPrice"],
    auctionType: json["auctionType"],
    quantity: json["quantity"],
    endTime: json["endTime"],
    salt: json["salt"],
  );

  Map<String, dynamic> toJson() => {
    "tokenId": tokenId,
    "minPrice": minPrice,
    "auctionType": auctionType,
    "quantity": quantity,
    "endTime": endTime,
    "salt": salt,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
