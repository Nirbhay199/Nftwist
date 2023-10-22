import 'package:nftwist/model/User_activity.dart';
import 'package:nftwist/model/collection.dart';
import 'package:nftwist/model/user_community.dart';
import 'package:nftwist/model/user_owned_nfts.dart';

class UserData{
  String email;
  String? password;
  String? first_name;
  int user_type;
  bool? have_sub_admin_privileges;
  bool is_community_hide;
  String? cover_image;
  String? flag;
  // String cover_image_y_axis;
  String? social_type;
  String? company_name;
  String? last_name;
  int? phone_no;
  String? country_code;
  // int? change_password_otp;
  String? reset_password_otp;
  String? email_verification_otp;
  int? phone_verification_otp;
  String? phone_otp_generated_at;
  String? email_otp_generated_at;
  int? otp;
  int? two_way_otp;
  bool? is_user_verified;
  bool? is_personal_detail_filled;
  bool? is_email_verified;
  bool? is_phone_verified;
  bool? is_two_way_auth_enabled;
  bool? is_two_way_auth_verified;
  String? user_name;
  String? nick_name;
  String? wallet_address;
  String? matic_wallet_address;
  String? profile_pic;
  // int doc_type;
  String? doc_front;
  String? doc_back;
  String? doc_upload_time;
  int document_status;
  String? country;
  String? state;
  String? bio;
  String? personal_link;
  String? gender;
  String? dob;
  String? stripe_customer_id;
  String? vault_account_id;
  String? wallet_id;
  String? matic_wallet_id;
  String? vault_account_name;
  String? vault_wallet_asset_id;
  var  balance;
  int? matic_balance;
  int? user_joined_at;
  String line_of_business;
  String? other_business;
  bool is_deleted;
  bool is_blocked;
  String? owner_wallet_address;
  String? wallet_private_key;
  int is_user_signed_up;
  String? category;
  int? nft_limit;
  int? expected_limit;
  String? logged_in_at;
  int? gifted_nft_count;
  String? account_id;
  String? partner_request_status;
  String? id;
  int? v;
  int? following_count;
  int? collection_count;
  int? follower_count;
  int? owner_count;
  int? total_nft;
  int? total_nft_available;
  int? user_nft_count;
  int? favourite_count;
  var memberships;
  int? memership_count;
  int? is_follow;
  // "memberships": [
  // {
  // "_id": "64c0b9e1f1c07c5ef760bf53",
  // "first_name": null,
  // "user_name": "Deepanshu3",
  // "profile_pic": "1690352038986-nature-wallpapers-hd-4k-free-download---nature-wallpaper-pictures---nature-wallpapers-backgroun.jpg"
  // }
  // ],
  List<UserOwnedNfts> userOwnedNfts=[];
  List<UserOwnedNfts>? userCreatedNFts=[];
  List<UserActivity> userActivity=[];
  Community? userCommunity ;
  List<Collection> userCollection=[];
  var dollar_value;
  // "dollar_value": {
  // "ticker": "X:MATICUSD",
  // "queryCount": 1,
  // "resultsCount": 1,
  // "adjusted": true,
  // "results": [
  // {
  // "T": "X:MATICUSD",
  // "v": 7327073.977211398,
  // "vw": 0.7029,
  // "o": 0.719,
  // "c": 0.6972,
  // "h": 0.7196,
  // "l": 0.6809,
  // "t": 1690761599999,
  // "n": 17649
  // }
  // ],
  // "status": "OK",
  // "request_id": "44d04465da3461dfcd45302dc50cf838",
  // "count": 1
  // }



UserData({required this.is_community_hide,
  required this.email,
  required this.password,
  required this.first_name,
  required this.user_type,
  required this.have_sub_admin_privileges,
  required this.cover_image,
  required this.userOwnedNfts,
  this.userCreatedNFts,
  required this.userActivity,
  required this.userCommunity,
  this.flag,
  // required this.cover_image_y_axis,
  required this.social_type,
  required this.company_name,
  required this.last_name,
  required this.phone_no,
  required this.country_code,
  // required this.change_password_otp,
  required this.reset_password_otp,
  required this.email_verification_otp,
  required this.phone_verification_otp,
  required this.phone_otp_generated_at,
  required this.email_otp_generated_at,
  required this.otp,
  required this.userCollection,
  this.following_count,
  this.collection_count,
  this.follower_count,
  this.owner_count,
  this.total_nft,
  this.total_nft_available,
  this.user_nft_count,
  this.favourite_count,
  this.memberships,
  this.memership_count,
  this.is_follow,
  this.dollar_value,
  required this.two_way_otp,
  required this.is_user_verified,
  required this.is_personal_detail_filled,
  required this.is_email_verified,
  required this.is_phone_verified,
  required this.is_two_way_auth_enabled,
  required this.is_two_way_auth_verified,
  required this.user_name,
  required this.nick_name,
  required this.wallet_address,
  required this.matic_wallet_address,
  required this.profile_pic,
  // this.doc_type=0,
  required this.doc_front,
  required this.doc_back,
  required this.doc_upload_time,
  required this.document_status,
  required this.country,
  required this.state,
  required this.bio,
  required this.personal_link,
  required this.gender,
  required this.dob,
  required this.stripe_customer_id,
  required this.vault_account_id,
  required this.wallet_id,
  required this.matic_wallet_id,
  required this.vault_account_name,
  required this.vault_wallet_asset_id,
  required this.balance,
  required this.matic_balance,
  required this.user_joined_at,
  required this.line_of_business,
  required this.other_business,
  required this.is_deleted,
  required this.is_blocked,
  required this.owner_wallet_address,
  required this.wallet_private_key,
  required this.is_user_signed_up,
  required this.category,
  required this.nft_limit,
  required this.expected_limit,
  required this.logged_in_at,
  required this.gifted_nft_count,
  required this.account_id,
  required this.partner_request_status,
  required this.id,
  required this.v,
});
}