
import 'Voucher.dart';

class NftDetail{
  var id;
  NftUserId? user_id;
  CollectionId? collection_id;
  var category_id;
  var other_category;
  var type;
  var media_type;
  var file;
  var price;
  var weth_price;
  var unlockable_content;
  var no_of_copy;
  var name;
  var description;
  var alternative_description;
  var royalty;
  CurrentOwner? current_owner;
  var created_at;
  var auction_id;
  var token_id;
  var signature;
  var is_lazy_mint;
  var is_on_market_place;
  var owner_wallet_address;
  var creator_wallet_address;
  var available;
  Creator? creator;
  var transaction_hash;
  var txn_id;
  var status;
  var data_ipfs;
  var is_private;
  var is_auction_window;
  var auction_time;
  var auction_type;
  var is_extra_content;
  var extra_content;
  var is_gifted;
  var gifted_nft_id;
  var properties;
  var is_hot;
  var is_most_visible;
  var dollar_value;
  var is_owner;
  var viewer_id;
  var nft_like_count;
  var nft_comment_count;
  var is_liked;
  var is_commented;
  var blockchain;
  var comments;
  var commented_user_count;
  var resellers;
  var owners;
  Voucher? voucher;


  NftDetail({
    this.id,
    this.user_id,
    this.collection_id,
    this.category_id,
    this.other_category,
    this.type,
    this.media_type,
    this.resellers,
    this.file,
    this.price,
    this.owners,
    this.weth_price,
    this.unlockable_content,
    this.no_of_copy,
    this.name,
    this.description,
    this.alternative_description,
    this.royalty,
    this.current_owner,
    this.created_at,
    this.auction_id,
    this.token_id,
    this.signature,
    this.is_lazy_mint,
    this.is_on_market_place,
    this.owner_wallet_address,
    this.creator_wallet_address,
    this.creator,
    this.available,
    this.transaction_hash,
    this.txn_id,
    this.status,
    this.data_ipfs,
    this.is_private,
    this.is_auction_window,
    this.auction_time,
    this.auction_type,
    this.is_extra_content,
    this.extra_content,
    this.is_gifted,
    this.gifted_nft_id,
    this.properties,
    this.is_hot,
    this.is_most_visible,
    this.dollar_value,
    this.is_owner,
    this.viewer_id,
    this.nft_like_count,
    this.nft_comment_count,
    this.is_liked,
    this.is_commented,
    this.blockchain,
    this.comments,
    this.commented_user_count,
    this.voucher,
});


}
class CollectionId {
  String id;
  String name;
  String symbol;
  String media;
  String media_type;
  String collection_address;
  CollectionId({ required this.id,
    required this.name,
    required this.symbol,
    required this.media,
    required this.media_type,
    required this.collection_address,});
}
class NftUserId {
  String id;
  String email;
  String firstName;
  int userType;
  String? coverImage;
  String? lastName;
  String? userName;
  String? walletAddress;
  String profilePic;
  String? bio;
  dynamic personalLink;
  String walletId;
  NftUserId({
    required this.id,
    required this.email,
    required  this.firstName,
    required this.userType,
    required this.coverImage,
    required this.lastName,
    required  this.userName,
    required  this.walletAddress,
    required  this.profilePic,
    required  this.bio,
    required this.personalLink,
    required  this.walletId,});
}
class CurrentOwner{
  var id;
  var email;
  var first_name;
  var cover_image;
  var last_name;
  var user_name;
  var wallet_address;
  var profile_pic;
  var bio;
  var personal_link;
  var wallet_id;
  var nft_id;
  var nft_owner_id;
  var price;
  var earned_amount;
  var signature;
  var owner_address;
  var no_of_copy;
  var available;
  var created_at;
  var is_logged_user_owner;
  var nft_resell_id;
  var follower_count;
  var following_count;
  var collection_count;
  var membership_count;
  var is_followed;
  var nft_count;
  var owner_count;
  ResellerId? reseller_id;
  CurrentOwner({
    required this.id,
    required this.email,
    required this.first_name,
    required this.cover_image,
    required this.reseller_id,
    required this.last_name,
    required this.user_name,
    required this.wallet_address,
    required this.profile_pic,
    required this.bio,
    required this.personal_link,
    required this.wallet_id,
    required this.nft_id,
    required this.nft_owner_id,
    required this.price,
    required this.earned_amount,
    required this.signature,
    required this.owner_address,
    required this.no_of_copy,
    required this.available,
    required this.created_at,
    required this.is_logged_user_owner,
    required this.nft_resell_id,
    required this.follower_count,
    required this.following_count,
    required this.collection_count,
    required this.membership_count,
    required this.is_followed,
    required this.nft_count,
    required this.owner_count,
});
}

class ResellerId {
   String? id;
   String? email;
   String? first_name;
   String? cover_image;
   String? last_name;
   String? user_name;
   String? wallet_address;
   String? profile_pic;
   String? bio;
   String? personal_link;
   String? wallet_id;
ResellerId({required this.id,
 this.email,
 this.first_name,
 this.cover_image,
 this.last_name,
 this.user_name,
 this.wallet_address,
 this.profile_pic,
 this.bio,
 this.personal_link,
 this.wallet_id,});
}
class Creator {
  String id;
  String email;
  String first_name;
  int user_type;
  String? cover_image;
  String last_name;
  String user_name;
  String wallet_address;
  String? profile_pic;
  String? bio;
  String? personal_link;
  String? wallet_id;
  Creator({required this.id,
    required this.email,
    required this.wallet_id,
    required this.first_name,
    required this.user_type,
    required this.cover_image,
    required this.last_name,
    required this.user_name,
    required this.wallet_address,
    required this.profile_pic,
    required this.bio,
    required this.personal_link,});
}
