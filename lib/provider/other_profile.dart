import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../constant/toaster.dart';
import '../model/User_activity.dart';
import '../model/user_community.dart';
import '../model/user_data.dart';
import '../model/user_owned_nfts.dart';
import '../services/api_response_handler.dart';
import '../services/locator.dart';
import '../services/navigation_service.dart';
import '../ui/Bottom Nav Bar/profile/Other User Profile/otheruser_partnerprofile.dart';

class OtherUserProfile with ChangeNotifier{

  UserData? _otherUser;
  UserData? get otherUser=>_otherUser;
  List <UserOwnedNfts>_otherUserOwnedNfts=[];
  List <UserOwnedNfts> get otherUserOwnedNfts=>_otherUserOwnedNfts;
  List <UserActivity>_otherUserActivity=[];
  List <UserActivity> get otherUserActivity=>_otherUserActivity;
  Community? _userCommunity;
  Community? get userCommunity => _userCommunity;
  Future<bool> getOtherUserProfile({id,user_id})  async {
    var result =await ApiResponse().getOtherProfile(id,user_id);
    var data=await jsonDecode(result.body);
    print(data);
    if(result.statusCode==200){
      _otherUser= UserData(is_community_hide: data['is_community_hide'],
        is_follow: data['is_followed'],
        email: data['email'],
        password: data['password'],
        id: data['_id'],
        account_id: data['account_id'],
        balance: data['balance'],
        bio: data['bio'],
        category: data['category'],
        // change_password_otp: int.parse(data['change_password_otp']??''),
        company_name: data['company_name'],
        country: data['country'],
        country_code: data['country_code'],
        cover_image: data['cover_image'],
        flag: data['country_flag'],
        dob: data['dob'],
        doc_back: data['doc_back'],
        doc_front: data['doc_front'],
        social_type: data['social_type'],
        doc_upload_time: data['doc_upload_time'],
        document_status: data['document_status'],
        email_otp_generated_at: data['email_otp_generated_at'],
        email_verification_otp: data['email_verification_otp'],
        expected_limit: data['expected_limit'],
        first_name: data['first_name'],
        gender: data['gender'],
        gifted_nft_count: data['gifted_nft_count'],
        have_sub_admin_privileges: data['have_sub_admin_privileges'],
        memberships:data['memberships'],
        memership_count:data['memership_count'],
        // image_sizedata response['image_size'],
        is_blocked: data['is_blocked'],
        is_deleted: data['is_deleted'],
        is_email_verified: data['is_email_verified'],
        is_personal_detail_filled: data['is_personal_detail_filled'],
        is_phone_verified: data['is_phone_verified'],
        is_two_way_auth_enabled: data['is_two_way_auth_enabled'],
        is_two_way_auth_verified: data['is_two_way_auth_verified'],
        is_user_signed_up: data['is_user_signed_up'],
        is_user_verified: data['is_user_verified'],
        last_name: data['last_name'],
        line_of_business: data['line_of_business'],
        logged_in_at: data['logged_in_at'],
        matic_balance: data['matic_balance'],
        matic_wallet_address: data['matic_wallet_address'],
        matic_wallet_id: data['matic_wallet_id'],
        nft_limit: data['nft_limit'],
        nick_name: data['nick_name'],
        other_business: data['other_business'],
        otp: data['otp'],
        owner_wallet_address: data['owner_wallet_address'],
        partner_request_status: data['partner_request_status'],
        personal_link: data['personal_link'],
        phone_no: data['phone_no'],
        phone_otp_generated_at: data['phone_otp_generated_at'],
        phone_verification_otp: data['phone_verification_otp'],
        profile_pic: data['profile_pic'],
        reset_password_otp: data['reset_password_otp'],
        state: data['state'],
        stripe_customer_id: data['stripe_customer_id'],
        two_way_otp: data['two_way_otp'],
        user_joined_at: data['user_joined_at'],
        user_name: data['user_name'],
        user_type: data['user_type'],
        v: data['__v'],
        vault_account_id: data['vault_account_id'],
        vault_account_name: data['vault_account_name'],
        vault_wallet_asset_id: data['vault_wallet_asset_id'],
        wallet_address: data['wallet_address'],
        wallet_id: data['wallet_id'],
        wallet_private_key: data['wallet_private_key'],
        total_nft: data['total_nft'],
        follower_count: data['follower_count'],
        following_count: data['following_count'],
        user_nft_count: data['nft_count'], userOwnedNfts: [], userActivity: [],userCollection: [], userCommunity: null,
      );
    }else{
      locator<Toaster>().showToaster(msg: data["error_description"]);
    }
    notifyListeners();
    return getOtherPartnerNfts(id);
  }


  Future<bool> getOtherPartnerNfts(id)async{
    _otherUserOwnedNfts=[];
    var result=await ApiResponse().getOtherPartnerNfts(id);
    result=await jsonDecode(result.body);
    if(result['response']['data'].length!=0){
      result['response']['data'].forEach((ownedNft){
        if (_otherUserOwnedNfts.any((element) => element.id == ownedNft['_id'])) {
          int? index =
          _otherUserOwnedNfts.indexWhere((element) => element.id == ownedNft['_id']);
          _otherUserOwnedNfts[index] = UserOwnedNfts.fromJson(ownedNft);
        } else {
          _otherUserOwnedNfts.add(UserOwnedNfts.fromJson(ownedNft));
        }
      });
    }else{
      _otherUserOwnedNfts=[];
    }
    _otherUser?.userOwnedNfts=_otherUserOwnedNfts;
    notifyListeners();
    return getUserActivity(id);
  }



  Future<bool> getUserActivity(id) async {
    _otherUserActivity=[];
    var result=await ApiResponse().getActivites(id:id);
    if(result.statusCode==200){
      result = await jsonDecode(result.body);
      // print("activities data $result['activities']");
      if (result['activities'].length != 0) {
        result['activities'].forEach((userActivity) {
          if (_otherUserActivity
              .any((element) => element.id == userActivity['_id'])) {
            int? index = _otherUserActivity
                .indexWhere((element) => element.id == userActivity['_id']);
            _otherUserActivity[index] = UserActivity.fromJson(userActivity);
          } else {
            _otherUserActivity.add(UserActivity.fromJson(userActivity));
          }
        });
      } else {
        _otherUserActivity = [];
      }
      _otherUser?.userActivity = _otherUserActivity;
    }else{
      var data=await jsonDecode(result.body);
      locator<Toaster>().showToaster(msg: data["error_description"]);
    }
    notifyListeners();
    if(_otherUser?.user_type==2) {
      return getUserCommunity();
    }else{
      locator<NavigationService>().namedNavigateTo(OtherPartnerProfile.route);
      return false;

    }
  }

  Future<bool> getUserCommunity({id}) async {
    if(_otherUser?.user_type==2){
      var result = await ApiResponse().getOtherUserCommunity(id: id??_otherUser?.id);
      if (result.statusCode == 200) {
        result = await jsonDecode(result.body);
          if(result!=null){
            _userCommunity=Community.fromJson(result);
            otherUser?.userCommunity = _userCommunity;
            _otherUser?.userCommunity = _userCommunity;
          }
        locator<NavigationService>().namedNavigateTo(OtherPartnerProfile.route);
      } else {
        var data = await jsonDecode(result.body);
        locator<Toaster>().showToaster(msg: data["error_description"]);
      }    notifyListeners();
    }
    return false;
  }


  followUser(follow)async{
   final result = await ApiResponse().follow(_otherUser?.id);
   _otherUser?.is_follow=follow==1?0:1;
   print(result.body);
   notifyListeners();
   return false;
  }


  likeNft(id/*,{type=2,isDetails}*/) async {
    // if(type==1){
      try{
        int? index = otherUser?.userOwnedNfts.indexWhere((element) => element.id == id);

        if (index != -1) {
          var nft = otherUser?.userOwnedNfts[index??0];
          bool isLiked = nft!.isLiked ?? false;

          if (isLiked) {
            nft.likesCount = (nft.likesCount ?? 0) - 1;
          } else {
            nft.likesCount = (nft.likesCount ?? 0) + 1;
          }
          nft.isLiked = !isLiked;
          print(nft.likesCount);
          print("Liked${nft.isLiked}");
          print(isLiked ? "LIKE UNDONE" : "LIKE DONE");
        }
      }catch(_){}
    // }else{
    //   // normal
    //   /* int? index =
    //    _partnerNFTs.indexWhere((element) => element.sId == id);
    //    print(_partnerNFTs[index].likesCount);
    //    print(_partnerNFTs[index].is_liked);
    //    int count = (_partnerNFTs[index].likesCount)!;
    //    if (_partnerNFTs[index].is_liked == false||_partnerNFTs[index].is_liked == null) {
    //      print("LIKE DONE");
    //      _partnerNFTs[index].is_liked = true;
    //      _partnerNFTs[index].likesCount = count + 1;
    //    } else {
    //      _partnerNFTs[index].is_liked = false;
    //      _partnerNFTs[index].likesCount = count - 1;
    //
    //    }
    //    if(_nftDetail.id!=null){
    //     _nftDetail.is_liked=_partnerNFTs[index].is_liked;
    //     _nftDetail.nft_like_count=_partnerNFTs[index].likesCount;
    //    }*/
    //
    //
    //   //optimise1
    //   /*int? index = _partnerNFTs.indexWhere((element) => element.sId == id);
    //    if (index != -1) {
    //      final nft = _partnerNFTs[index];
    //      if (nft.is_liked == false || nft.is_liked == null) {
    //        print("LIKE DONE");
    //        nft.is_liked = true;
    //        nft.likesCount= (nft.likesCount??0)+1;
    //      } else {
    //        nft.is_liked = false;
    //        nft.likesCount= (nft.likesCount??1)-1;
    //      }
    //      if (_nftDetail.id != null) {
    //        _nftDetail.is_liked = nft.is_liked;
    //        _nftDetail.nft_like_count = nft.likesCount;
    //      }
    //      print(nft.likesCount);
    //    }*/
    //
    //   //optimise2
    //   print("ffdkjfdjfk");
    //   int? index = _partnerNFTs.indexWhere((element) => element.sId == id);
    //
    //   if (index != -1) {
    //     var nft = _partnerNFTs[index];
    //     bool isLiked = nft.is_liked ?? false;
    //     if (isLiked) {
    //       nft.likesCount = (nft.likesCount ?? 0) - 1;
    //     } else {
    //       nft.likesCount = (nft.likesCount ?? 0) + 1;
    //     }
    //
    //     nft.is_liked = !isLiked;
    //     print(nft.is_liked);
    //     print(_partnerNFTs[index].is_liked);
    //     if (_nftDetail.id != null) {
    //       _nftDetail.is_liked = nft.is_liked;
    //       _nftDetail.nft_like_count = nft.likesCount;
    //     }
    //
    //     print(isLiked ? "LIKE UNDONE" : "LIKE DONE");
    //   }
    // }
    notifyListeners();
    final a=await ApiResponse().likeNft(id);
    print("LIST------${a.body}");
  }



}