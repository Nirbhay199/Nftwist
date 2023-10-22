import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nftwist/constant/apiConstant.dart';
import 'package:nftwist/model/User_activity.dart';
import 'package:nftwist/model/collection.dart';
import 'package:nftwist/model/following.dart';
import 'package:nftwist/model/notification.dart'as notificationModal;
import 'package:nftwist/model/user_owned_nfts.dart';
import 'package:nftwist/model/user_data.dart';
import 'package:nftwist/provider/market_place_nfts.dart';
import 'package:nftwist/services/apiHandler.dart';
import 'package:nftwist/services/api_response_handler.dart';
import 'package:nftwist/services/navigation_service.dart';
import 'package:nftwist/widget/report_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:csv/csv.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../constant/toaster.dart';
import '../model/follower.dart';
import '../model/user_community.dart';
import '../services/locator.dart';
import '../services/storageFunctions.dart';
import '../ui/Auth Screen/Signup/sign_up.dart';
import '../widget/success_screen.dart';

class User with ChangeNotifier {
  UserData? _user;
  UserData? get user => _user;

  String? _giftNFtId;

  String? get giftNFtId => _giftNFtId;

  List<UserOwnedNfts> _userOwnedNfts = [];
  List<UserOwnedNfts> get userOwnedNfts => _userOwnedNfts;
  List<Collection> _userCollection = [];
  List<Collection> get userCollection => _userCollection;
  List<Following> _userFollowing = [];
  List<Following> get userFollowing => _userFollowing;
  List<Follower> _userFollower = [];
  List<Follower> get userFollower => _userFollower;
  List<UserActivity> _userActivity = [];
  List<UserActivity> get userActivity => _userActivity;
  Community? _userCommunity ;
  Community?  get userCommunity => _userCommunity;
  List<UserOwnedNfts> _userCreatedNFts = [];
  List<UserOwnedNfts> get userCreatedNFts => _userCreatedNFts;
  final List<notificationModal.Notification> _notification = [];
  List<notificationModal.Notification> get notification => _notification;




  List _rules=[];
  List get rules=>_rules;

  fetchUser(response, token) async {
    print("---response--     $response");
    _user = UserData(
      email: response['email'],is_community_hide: response['is_community_hide'],
      password: response['password'],
      id: response['_id'],
      account_id: response['account_id'],
      balance: response['balance'],
      bio: response['bio'],
      category: response['category'],
      // change_password_otp: int.parse(response['change_password_otp']??''),
      company_name: response['company_name'],
      country: response['country'],
      country_code: response['country_code'],
      cover_image: response['cover_image'],
      flag: response['country_flag'],
      dob: response['dob'],
      doc_back: response['doc_back'],
      doc_front: response['doc_front'],
      social_type: response['social_type'],
      doc_upload_time: response['doc_upload_time'],
      document_status: response['document_status'],
      email_otp_generated_at: response['email_otp_generated_at'],
      email_verification_otp: response['email_verification_otp'],
      expected_limit: response['expected_limit'],
      first_name: response['first_name'],
      gender: response['gender'],
      gifted_nft_count: response['gifted_nft_count'],
      have_sub_admin_privileges: response['have_sub_admin_privileges'],
      memberships: response['memberships'],
      memership_count: response['memership_count'],
      // image_size: response['image_size'],
      is_blocked: response['is_blocked'],
      is_deleted: response['is_deleted'],
      is_email_verified: response['is_email_verified'],
      is_personal_detail_filled: response['is_personal_detail_filled'],
      is_phone_verified: response['is_phone_verified'],
      is_two_way_auth_enabled: response['is_two_way_auth_enabled'],
      is_two_way_auth_verified: response['is_two_way_auth_verified'],
      is_user_signed_up: response['is_user_signed_up'],
      is_user_verified: response['is_user_verified'],
      last_name: response['last_name'],
      line_of_business: response['line_of_business'],
      logged_in_at: response['logged_in_at'],
      matic_balance: response['matic_balance'],
      matic_wallet_address: response['matic_wallet_address'],
      matic_wallet_id: response['matic_wallet_id'],
      nft_limit: response['nft_limit'],
      nick_name: response['nick_name'],
      other_business: response['other_business'],
      otp: response['otp'],
      owner_wallet_address: response['owner_wallet_address'],
      partner_request_status: response['partner_request_status'],
      personal_link: response['personal_link'],
      phone_no: response['phone_no'],
      phone_otp_generated_at: response['phone_otp_generated_at'],
      phone_verification_otp: response['phone_verification_otp'],
      profile_pic: response['profile_pic'],
      reset_password_otp: response['reset_password_otp'],
      state: response['state'],
      stripe_customer_id: response['stripe_customer_id'],
      two_way_otp: response['two_way_otp'],
      user_joined_at: response['user_joined_at'],
      user_name: response['user_name'],
      user_type: response['user_type'],
      v: response['__v'],
      vault_account_id: response['vault_account_id'],
      vault_account_name: response['vault_account_name'],
      vault_wallet_asset_id: response['vault_wallet_asset_id'],
      wallet_address: response['wallet_address'],
      wallet_id: response['wallet_id'],
      wallet_private_key: response['wallet_private_key'],
      total_nft: response['total_nft'],
      follower_count: response['follower_count'],
      following_count: response['following_count'],
      user_nft_count: response['user_nft_count'], userOwnedNfts: [],
      userActivity: [], userCollection: [], userCommunity: null,
    );
    StorageFunctions().setValue(authToken, token);
    // StorageFunctions().setValue(authToken,(await ApiResponse().getToken())['token']);
    StorageFunctions().setValue(profile, jsonEncode(response));
    notifyListeners();
  }

  editUser(response) {
    print(response);
    _user = UserData(
        email: response['email'] ?? user?.email,is_community_hide: response['is_community_hide'] ?? user?.is_community_hide,
        password: response['password'] ?? user?.password,
        id: response['_id'] ?? user?.id,
        account_id: response['account_id'] ?? user?.account_id,
        balance: response['balance'] ?? user?.balance,
        bio: response['bio'] ?? user?.bio,
        category: response['category'] ?? user?.category,
        // change_password_otp: response['change_password_otp']??user?.change_password_otp,
        company_name: response['company_name'] ?? user?.company_name,
        country: response['country'] ?? user?.country,
        country_code: response['country_code'] ?? user?.country_code,
        cover_image: response['cover_image'],
        flag: response['country_flag'] ?? user?.flag,
        total_nft: response['total_nft'] ?? user?.total_nft,
        follower_count: response['follower_count'] ?? user?.follower_count,
        following_count: response['following_count'] ?? user?.following_count,
        user_nft_count: response['user_nft_count'] ?? user?.user_nft_count,
        memberships: response['memberships'] ?? user?.memberships,
        // cover_image_y_axis: response]['cover_image_y_axis'],
        memership_count: response['memership_count'] ?? user?.memership_count,
        dob: response['dob'] ?? user?.dob,
        doc_back: response['doc_back'] ?? user?.doc_back,
        doc_front: response['doc_front'] ?? user?.doc_front,
        social_type: response['social_type'] ?? user?.social_type,
        doc_upload_time: response['doc_upload_time'] ?? user?.doc_upload_time,
        document_status: response['document_status'] ?? user?.document_status,
        email_otp_generated_at:
            response['email_otp_generated_at'] ?? user?.email_otp_generated_at,
        email_verification_otp:
            response['email_verification_otp'] ?? user?.email_verification_otp,
        expected_limit: response['expected_limit'] ?? user?.expected_limit,
        first_name: response['first_name'] ?? user?.first_name,
        gender: response['gender'] ?? user?.gender,
        gifted_nft_count:
            response['gifted_nft_count'] ?? user?.gifted_nft_count,
        have_sub_admin_privileges: response['have_sub_admin_privileges'] ??
            user?.have_sub_admin_privileges,
        // image_size: response]['image_size']??user?.//,
        is_blocked: response['is_blocked'] ?? user?.is_blocked,
        is_deleted: response['is_deleted'] ?? user?.is_deleted,
        is_email_verified:
            response['is_email_verified'] ?? user?.is_email_verified,
        is_personal_detail_filled: response['is_personal_detail_filled'] ??
            user?.is_personal_detail_filled,
        is_phone_verified:
            response['is_phone_verified'] ?? user?.is_phone_verified,
        is_two_way_auth_enabled: response['is_two_way_auth_enabled'] ??
            user?.is_two_way_auth_enabled,
        is_two_way_auth_verified: response['is_two_way_auth_verified'] ??
            user?.is_two_way_auth_verified,
        is_user_signed_up:
            response['is_user_signed_up'] ?? user?.is_user_signed_up,
        is_user_verified:
            response['is_user_verified'] ?? user?.is_user_verified,
        last_name: response['last_name'] ?? user?.last_name,
        line_of_business:
            response['line_of_business'] ?? user?.line_of_business,
        logged_in_at: response['logged_in_at'] ?? user?.logged_in_at,
        matic_balance: response['matic_balance'] ?? user?.matic_balance,
        matic_wallet_address:
            response['matic_wallet_address'] ?? user?.matic_wallet_address,
        matic_wallet_id: response['matic_wallet_id'] ?? user?.matic_wallet_id,
        nft_limit: response['nft_limit'] ?? user?.nft_limit,
        nick_name: response['nick_name'] ?? user?.nick_name,
        other_business: response['other_business'] ?? user?.other_business,
        otp: response['otp'] ?? user?.otp,
        owner_wallet_address:
            response['owner_wallet_address'] ?? user?.owner_wallet_address,
        partner_request_status:
            response['partner_request_status'] ?? user?.partner_request_status,
        personal_link: response['personal_link'] ?? user?.personal_link,
        phone_no: response['phone_no'] ?? user?.phone_no,
        phone_otp_generated_at:
            response['phone_otp_generated_at'] ?? user?.phone_otp_generated_at,
        phone_verification_otp:
            response['phone_verification_otp'] ?? user?.phone_verification_otp,
        profile_pic: response['profile_pic'],
        reset_password_otp:
            response['reset_password_otp'] ?? user?.reset_password_otp,
        state: response['state'] ?? user?.state,
        stripe_customer_id:
            response['stripe_customer_id'] ?? user?.stripe_customer_id,
        two_way_otp: response['two_way_otp'] ?? user?.two_way_otp,
        user_joined_at: response['user_joined_at'] ?? user?.user_joined_at,
        user_name: response['user_name'] ?? user?.user_name,
        user_type: response['user_type'] ?? user?.user_type,
        v: response['__v'] ?? user?.v,
        vault_account_id:
            response['vault_account_id'] ?? user?.vault_account_id,
        vault_account_name:
            response['vault_account_name'] ?? user?.vault_account_name,
        vault_wallet_asset_id:
            response['vault_wallet_asset_id'] ?? user?.vault_wallet_asset_id,
        wallet_address: response['wallet_address'] ?? user?.wallet_address,
        wallet_id: response['wallet_id'] ?? user?.wallet_id,
        wallet_private_key:
            response['wallet_private_key'] ?? user?.wallet_private_key,
        userOwnedNfts: user?.userOwnedNfts ?? [],
        userActivity: user?.userActivity ?? [],
        userCollection: user?.userCollection ?? [],
        userCommunity: user?.userCommunity );
    StorageFunctions().setValue(profile, jsonEncode(response));
    notifyListeners();
  }

  getUserProfile() async {
    var result = await ApiResponse().getProfile();
    editUser(await jsonDecode(result.body));
  }

  //no content 1,
  // move to next page 2

  getUserOwnedNfts({limit=10,page=0}) async {
    var result = await httpRequest(REQUEST_TYPE.GET, "$userOwnedNftsUrl?page=$page&limit=$limit", {});
    result = await jsonDecode(result.body);
    if (result[0]['data'].length != 0) {
      result[0]['data'].forEach((ownedNft) {
        if (_userOwnedNfts.any((element) => element.id == ownedNft['_id'])) {
          int? index = _userOwnedNfts
              .indexWhere((element) => element.id == ownedNft['_id']);
          print(ownedNft);
          _userOwnedNfts[index] = UserOwnedNfts.fromJson(ownedNft);
        } else {
          _userOwnedNfts.add(UserOwnedNfts.fromJson(ownedNft));
        }
      });
    } else {
      _userOwnedNfts = [];
    }
    _user?.userOwnedNfts = _userOwnedNfts;
    notifyListeners();
  }

  getProjects() async {
    var result = await httpRequest(REQUEST_TYPE.GET, nftCollectionUrl, {});
    result = jsonDecode(result.body);
    result['collections'].forEach((project) {
      if (_userCollection.any((element) => element.id == project['_id'])) {
        int index = _userCollection
            .indexWhere((element) => element.id == project['_id']);
        _userCollection[index] = Collection(
          id: project['_id'],
          image: project['image'],
          name: project['name'],
          media_type: project['media_type'],
          campaign_description: project['campaign_description'],
          collection_address: project['collection_address'],
          cover_image: project['cover_image'],
          created_at: project['created_at'],
          description: project['description'],
          is_nft_added: project['is_nft_added'],
          media: project['media'],
          nft: project['nft'],
          nft_count: project['nft_count'],
          status: project['status'],
          total_available_nfts: project['total_available_nfts'],
          total_nfts: project['total_nfts'],
          user_id: project['user_id'],
        );
      } else {
        _userCollection.add(Collection(
          id: project['_id'],
          image: project['image'],
          name: project['name'],
          media_type: project['media_type'],
          campaign_description: project['campaign_description'],
          collection_address: project['collection_address'],
          cover_image: project['cover_image'],
          created_at: project['created_at'],
          description: project['description'],
          is_nft_added: project['is_nft_added'],
          media: project['media'],
          nft: project['nft'],
          nft_count: project['nft_count'],
          status: project['status'],
          total_available_nfts: project['total_available_nfts'],
          total_nfts: project['total_nfts'],
          user_id: project['user_id'],
        ));
      }
    });
    user?.userCollection = _userCollection;
    notifyListeners();
  }

  getCreatedNfts() async {
    var result = await httpRequest(REQUEST_TYPE.GET, userCreatedNftsUrl, {});
    result = await jsonDecode(result.body);
    if (result[0]['data'].length != 0) {
      result[0]['data'].forEach((ownedNft) {
        if (_userCreatedNFts.any((element) => element.id == ownedNft['_id'])) {
          int? index = _userCreatedNFts
              .indexWhere((element) => element.id == ownedNft['_id']);
          _userCreatedNFts[index] = UserOwnedNfts.fromJson(ownedNft);
        } else {
          _userCreatedNFts.add(UserOwnedNfts.fromJson(ownedNft));
        }
      });
    } else {
      _userCreatedNFts = [];
    }
    _user?.userCreatedNFts = _userCreatedNFts;
    notifyListeners();
  }

  getUserActivity() async {
    var result = await ApiResponse().getActivites(id: _user?.id);
    if (result.statusCode == 200) {
      result = await jsonDecode(result.body);
      // print("activities data $result['activities']");
      if (result['activities'].length != 0) {
        result['activities'].forEach((userActivity) {
          if (_userActivity
              .any((element) => element.id == userActivity['_id'])) {
            int? index = _userActivity
                .indexWhere((element) => element.id == userActivity['_id']);
            _userActivity[index] = UserActivity.fromJson(userActivity);
          } else {
            _userActivity.add(UserActivity.fromJson(userActivity));
          }
        });
      } else {
        _userActivity = [];
      }
      user?.userActivity = _userActivity;
    } else {
      var data = await jsonDecode(result.body);
      locator<Toaster>().showToaster(msg: data["error_description"]);
    }
    notifyListeners();
  }

  getUsergetCommunity({id}) async {
    if (user?.user_type == 2) {
      var result = await ApiResponse().getCommunity();
      if (result.statusCode == 200) {
        print("kfdjkfjkfjdkfjkdjfk");
        result = await jsonDecode(result.body);
        _userCommunity=Community.fromJson(result);
        user?.userCommunity = _userCommunity;
      } else {
        var data = await jsonDecode(result.body);
        locator<Toaster>().showToaster(msg: data["error_description"],bottomMargin: .62);
      }
      notifyListeners();
    }
  }

  changeSwitch(){
    _user!.is_community_hide=!_user!.is_community_hide;
    notifyListeners();
    ApiResponse().hideCommunity();
  }


  getUserFollowing() async {
    var result = await ApiResponse().getFollowing();
    var data = await jsonDecode(result.body);
    if (result.statusCode == 200) {
      if (data['data'].length == 0) {
        _userFollowing = [];
      } else {
        data['data'].forEach((user) {
          print(user);
          if (_userFollowing.any((element) => element.id == user['_id'])) {
            int index = _userFollowing
                .indexWhere((element) => element.id == user['_id']);
            _userFollowing[index] = Following(
                created_at: user['created_at'],
                id: user['_id'],
                follow_first_name: user['follow_to']['first_name'],
                follow_gender: user['follow_to']['gender'],
                follow_id: user['follow_to']['_id'],
                follow_user_type: user['follow_to']['user_type'],
                follow_last_name: user['follow_to']['last_name'],
                follow_nick_name: user['follow_to']['nick_name'],
                follow_profile_pic: user['follow_to']['profile_pic'],
                follow_user_name: user['follow_to']['user_name'],
                follow_wallet_address: user['follow_to']['wallet_address']);
          } else {
            _userFollowing.add(Following(
                created_at: user['created_at'],
                id: user['_id'],
                follow_first_name: user['follow_to']['first_name'],
                follow_gender: user['follow_to']['gender'],
                follow_id: user['follow_to']['_id'],
                follow_user_type: user['follow_to']['user_type'],
                follow_last_name: user['follow_to']['last_name'],
                follow_nick_name: user['follow_to']['nick_name'],
                follow_profile_pic: user['follow_to']['profile_pic'],
                follow_user_name: user['follow_to']['user_name'],
                follow_wallet_address: user['follow_to']['wallet_address']));
          }
        });
      }
      notifyListeners();
    } else {
      locator<Toaster>().showToaster(msg: data["error_description"]);
    }
  }

  getUserFollower() async {
    var result = await ApiResponse().getFollowers();
    var data = await jsonDecode(result.body);
    if (result.statusCode == 200) {
      if (data['data'].length == 0) {
        _userFollower = [];
      } else {
        data['data'].forEach((user) {
          print(user);
          if (_userFollower.any((element) => element.id == user['_id'])) {
            int index = _userFollower
                .indexWhere((element) => element.id == user['_id']);
            _userFollower[index] = Follower(
                created_at: user['created_at'],
                id: user['_id'],
                follow_by_first_name: user['follow_by']['first_name'],
                follow_by_gender: user['follow_by']['gender'],
                follow_by_id: user['follow_by']['_id'],
                follow_by_user_type: user['follow_by']['user_type'],
                follow_by_last_name: user['follow_by']['last_name'],
                follow_by_nick_name: user['follow_by']['nick_name'],
                follow_by_profile_pic: user['follow_by']['profile_pic'],
                follow_by_user_name: user['follow_by']['user_name'],
                follow_by_wallet_address: user['follow_by']['wallet_address']);
          } else {
            _userFollower.add(Follower(
                created_at: user['created_at'],
                id: user['_id'],
                follow_by_first_name: user['follow_by']['first_name'],
                follow_by_gender: user['follow_by']['gender'],
                follow_by_id: user['follow_by']['_id'],
                follow_by_user_type: user['follow_by']['user_type'],
                follow_by_last_name: user['follow_by']['last_name'],
                follow_by_nick_name: user['follow_by']['nick_name'],
                follow_by_profile_pic: user['follow_by']['profile_pic'],
                follow_by_user_name: user['follow_by']['user_name'],
                follow_by_wallet_address: user['follow_by']['wallet_address']));
          }
        });
      }
      notifyListeners();
    } else {
      locator<Toaster>().showToaster(msg: data["error_description"]);
    }
  }

  getWalletValue() async {
    var result = await ApiResponse().getWalletValue();
    result = jsonDecode(result.body);
    _user?.balance = result['balance'];
    _user?.dollar_value = result['dollar_value'];
    notifyListeners();
  }

  ///--------type=1,2 CreatedNFt,OwnedNft
  likeNft(id, {nftType}) async {
    print(nftType == 1 ? "CreatedNFt" : "OwnedNft");
    if (nftType == 1) {
      try {
        int? index =
            _user?.userCreatedNFts?.indexWhere((element) => element.id == id);

        if (index != -1) {
          var nft = _user?.userCreatedNFts?[index ?? 0];
          bool isLiked = nft!.isLiked ?? false;

          if (isLiked) {
            nft.likesCount = (nft.likesCount ?? 0) - 1;
          } else {
            nft.likesCount = (nft.likesCount ?? 0) + 1;
          }

          nft.isLiked = !isLiked;
          print(nft.likesCount);
          print(isLiked ? "LIKE UNDONE" : "LIKE DONE");
        }
      } catch (_) {}
    } else {
      int? index =
          _user?.userOwnedNfts.indexWhere((element) => element.id == id);
      if (index != -1) {
        var nft = _user?.userOwnedNfts[index ?? 0];
        bool isLiked = nft!.isLiked ?? false;
        if (isLiked) {
          nft.likesCount = (nft.likesCount ?? 0) - 1;
        } else {
          nft.likesCount = (nft.likesCount ?? 0) + 1;
        }
        nft.isLiked = !isLiked;
      }
    }
    notifyListeners();
    await ApiResponse().likeNft(id);
  }

  sendNft(email, id) async {
    var result =
        await ApiResponse().giftNft(email, id ?? _giftNFtId, user?.user_type);
    if (result.statusCode == 200) {
      _user?.gifted_nft_count = ((_user?.gifted_nft_count ?? 0) +
          (_user?.user_type == 2 ? email.length : 1)) as int?;
      int index = _userOwnedNfts
          .indexWhere((element) => element.id == (id ?? _giftNFtId));
      _userOwnedNfts[index].available =
          (_userOwnedNfts[index].available!.abs() -
              (_user?.user_type == 2 ? email.length : 1)) as int?;
      locator<NavigationService>()
          .namedNavigateTo(SuccessFullScreen.route, arguments: "Your NFT is gifted successfully.");
      notifyListeners();
      return true;
    } else {
      result = await jsonDecode(result.body);
      locator<Toaster>()
          .showToaster(msg: result["error_description"], bottomMargin: .75);
      return false;
    }
  }

  setGiftNftId(id) {
    print("kjskdjksj");
    _giftNFtId = id;
    notifyListeners();
  }

  reportUser(nftId, reason, message,index,reportType,userID)async{
    var result=await ApiResponse().reportUser(nftId, reason, message,index,reportType,userID);
    var data = await jsonDecode(result.body);
    if(result.statusCode==200){
      locator<NavigationService>().namedNavigateTo(ReportSuccess.route);
      return true;
    }else{
      locator<Toaster>().showToaster(msg: data["error_description"] );
      return false;
    }

  }

  addNftToRule(id) async{
    var result=await ApiResponse().setNftForGift(id);
    var data = await jsonDecode(result.body);
    if(result.statusCode==200){
      locator<Toaster>()
          .showToaster(msg: "NFT Selected For Gift", bottomMargin: .8,color: Colors.green.shade600,toasterColor: Colors.lightGreenAccent,action: (){
        locator<NavigationService>().goBack();
      });
    }else{
      locator<Toaster>()
          .showToaster(msg: data["error_description"], bottomMargin: .8);
    }
    notifyListeners();
  }

  setPartnerRules(count, rule, rule_id, type)async{
    var  result=await ApiResponse().setPartnerRules(count, rule, rule_id, type);
    var data = await jsonDecode(result.body);
    print("457578457847584785$data");
    if(result.statusCode==200){
      if(rule_id!=''){
        _rules.removeWhere((element) => element["_id"]==rule_id);
      }
      _rules.add(data);
      locator<NavigationService>().goBack();
    }else{
       locator<Toaster>()
          .showToaster(msg: data["error_description"]);
   return false;
    }
    notifyListeners();
  }

  delete(id) async {
    int index=_rules.indexWhere((element) => element["_id"]==id);
    var temp=_rules[index];
    _rules.removeAt(index);
    notifyListeners();
    var  result=await ApiResponse().deleteRule(id: id);
    var data = await jsonDecode(result.body);
    if(result.statusCode==200){
    }else{
      _rules.insert(index,temp);
  locator<Toaster>()
      .showToaster(msg: data["error_description"], bottomMargin: .75);
  }
  }

  getRules()async{
    var result=await ApiResponse().getRules();
    var data = await jsonDecode(result.body);
    print(data);
    if(result.statusCode==200){
     _rules=data;
    }else{
      locator<Toaster>()
          .showToaster(msg: data["error_description"], bottomMargin: .75);
    }
    notifyListeners();
  }

  getNotification()async{
    var result=await ApiResponse().notificationList(_user?.user_type);
    var data = await jsonDecode(result.body);
    if(result.statusCode==200){
      data.forEach((notification){
        if((_notification.any((element) => element.id==notification['_id']))){
        }else{
          print("$notification\n\n");
          _notification.add(notificationModal.Notification.fromJson(notification));

        }
      });
    }else{
      locator<Toaster>()
          .showToaster(msg: data["error_description"], bottomMargin: .75);
    }
    notifyListeners();
  }

  downloadHistory()async{
    var result = await ApiResponse().giftHistory();
    result=(await jsonDecode(result.body))['file_name'];
   return downloadFile("https://nftwistproduction.s3.me-central-1.amazonaws.com/uploads/documents/gift_history/$result");
  }


  Future<Map?> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      PlatformFile file = result.files.first;

      final input =   File(file.path!).openRead();
      final fields = await input
          .transform(utf8.decoder)
          .transform(  const CsvToListConverter())
          .toList();
      List flattenedEmails = fields.expand((list) => list).toList();
      return {
        "file_name":file.path?.split('/').last,
        "email_list":flattenedEmails};
    }
  }

  downloadFile(String url) async {
    print("URI---$url");
    var httpClient = http.Client();
    var request = http.Request('GET', Uri.parse(url));
    var response = httpClient.send(request);
    String dir = (await getApplicationDocumentsDirectory()).path;

    List chunks =[];
    int downloaded = 0;
    await response.asStream().listen((http.StreamedResponse r) {
      r.stream.listen((List<int> chunk) {
        // Display percentage of completion
        debugPrint('downloadPercentage: ${downloaded / r.contentLength!.toInt() * 100}');
        chunks.add(chunk);
        downloaded += chunk.length;
      }, onDone: () async {
        // Display percentage of completion
        debugPrint('downloadPercentage: ${downloaded / r.contentLength!.toInt() * 100}');
        // Save the file
        File file = File('$dir/${user?.user_name}_gift_history.csv');
        print(file.path);
        final Uint8List bytes = Uint8List(r.contentLength!.toInt());
        int offset = 0;
        for (List<int> chunk in chunks) {
          bytes.setRange(offset, offset + chunk.length, chunk);
          offset += chunk.length;
        }
       var a= await file.writeAsBytes(bytes);
        final asd = 'file://${a.path}';
        print(asd);
       var ad= await launchUrlString(asd);
        print(ad);
        return;
      });
    });
    return false;
  }


  Future<bool> logOut(context) async {
    var result = await ApiResponse().logOut();
    if (result.statusCode == 200 || result.statusCode == 401) {
      await StorageFunctions().deleteAllValue();
      _user = null;
      _userOwnedNfts = [];
      _userCollection = [];
      _userFollowing = [];
      _userFollower = [];
      _userActivity = [];
      _userCreatedNFts = [];
      Provider.of<Nfts>(context, listen: false).deleteData();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => const SignUp()),
        ModalRoute.withName('sign_up'),
      );
      return true;
    } else {
      result = await jsonDecode(result.body);
      locator<Toaster>().showToaster(msg: result["error_description"]);
      return false;
    }
    notifyListeners();
  }
}
