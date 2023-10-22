import 'dart:convert';
import 'package:nftwist/services/storageFunctions.dart';

import '../constant/apiConstant.dart';
import 'apiHandler.dart';

class ApiResponse {
  getWalletValue() {
    return httpRequest(REQUEST_TYPE.GET, usdValueUrl, {});
  }

  signUp({email, password}) async {
    List<String> phoneData = await getDeviceDetails();
    return await httpRequest(REQUEST_TYPE.POST, signUpUrl, {
      "email": email,
      "password": password,
      "fcm_id": await StorageFunctions().getValue(firebaseToken),
      "device_type": phoneData[3].toUpperCase(),
    });
  }

  signIn({email, password}) async {
    List<String> phoneData = await getDeviceDetails();
    return await httpRequest(REQUEST_TYPE.POST, loginInUrl, {
      "email": email,
      "password": password,
      "fcm_id": await StorageFunctions().getValue(firebaseToken),
      "device_type": phoneData[3].toUpperCase(),
    });
  }

  logOut() {
    return httpRequest(REQUEST_TYPE.DELETE, logOutUrl, {});
  }

  signupEmailOtpVerify({otp}) async {
    return await httpRequest(
        REQUEST_TYPE.POST, emailVerifyDeviceUrl, {"token": otp});
  }
  // getToken()async{
  //   return (jsonDecode((await httpRequest(REQUEST_TYPE.POST, getTokenUrl, {
  //     'token':jsonDecode((await httpRequest(REQUEST_TYPE.GET,getNewTokenUrl,{})).body)
  //   })).body));
  // }

  updatePassword(old_pass,new_pass){
    return httpRequest(REQUEST_TYPE.PATCH, updatePasswordUrl,{
      "old_password": old_pass,
      "new_password": new_pass
    });
    
  }


  contactUs(firstName, lastName, email, phoneNo, description, country_code) {
    return httpRequest(REQUEST_TYPE.POST, helpCenterUrl, {
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "phone_no": phoneNo.toString().trim() == '' ? 0 : int.parse(phoneNo),
      "country_code": country_code,
      "message": description,
    });
  }

  getfaq(){
    return httpRequest(REQUEST_TYPE.GET,faqUrl, {});
  }

  Future<List> getStates({countryShortname}) async {
    return await jsonDecode((await httpRequest(
            REQUEST_TYPE.GET, '$getStateUrl$countryShortname', {}))
        .body);
  }

  Future<List> getCity({countryShortname}) async {
    return await jsonDecode((await httpRequest(
            REQUEST_TYPE.GET, '$getCityUrl?country_code=$countryShortname', {}))
        .body);
  }

  Future<List> getCountry() async {
    return await jsonDecode(
        (await httpRequest(REQUEST_TYPE.GET, getCountryUrl, {})).body);
  }

  Future<List> getBusiness() async {
    return await jsonDecode(
        (await httpRequest(REQUEST_TYPE.GET, getBusinessUrl, {}))
            .body)["busniess"];
  }

// profile
  personalInfo(
      {firstName,
      lastName,
      nickName,
      userName,
      bio,
      image_size,
      profile_pic,
      cover_image,
      cover_image_y_axis,
      personal_link,
      country,
      state,
      phone_no,
      gender,
      country_code,
      doc_front,
      document_back,
      doc_type,
      dob,
      new_password,
      confirm_password,
      flag}) async {
    return await httpRequest(REQUEST_TYPE.POST, userPersonalInfo, {
      "first_name": firstName,
      "last_name": lastName,
      "nick_name": nickName,
      "user_name": userName,
      "bio": bio,
      "image_size": image_size,
      "profile_pic": profile_pic,
      "cover_image": cover_image,
      "cover_image_y_axis": cover_image_y_axis,
      "personal_link": personal_link,
      "country": country,
      "state": state,
      "phone_no": phone_no,
      "country_code": country_code,
      "doc_front": doc_front,
      "document_back": document_back,
      "doc_type": doc_type,
      "dob": dob,
      "gender": gender,
      "new_password": new_password,
      "confirm_password": confirm_password,
      "country_flag": flag
    });
  }

  editProfile(
      {firstName,
      lastName,
      nickName,
      userName,
      bio,
      image_size,
      profile_pic,
      cover_image,
      cover_image_y_axis,
      personal_link,
      country,
      state,
      phone_no,
      gender,
      country_code,
      doc_front,
      document_back,
      doc_type,
      dob,
      new_password,
      confirm_password,
      flag}) async {
    return await httpRequest(REQUEST_TYPE.PUT, editProfileUrl, {
      "first_name": firstName,
      "last_name": lastName,
      "nick_name": nickName,
      "user_name": userName,
      "bio": bio,
      "image_size": image_size,
      "profile_pic": profile_pic,
      "cover_image": cover_image,
      "cover_image_y_axis": cover_image_y_axis,
      "personal_link": personal_link,
      "country": country,
      "state": state,
      "phone_no": phone_no,
      "country_code": country_code,
      "doc_front": doc_front,
      "document_back": document_back,
      "doc_type": doc_type,
      "dob": dob,
      "gender": gender,
      "new_password": new_password,
      "confirm_password": confirm_password,
      "country_flag": flag
    });
  }

  updateDoc(
      {
        doc_front,
        document_back,
        doc_type,}) async {
    return await httpRequest(REQUEST_TYPE.PUT, editProfileUrl, {
      "doc_front": doc_front,
      "doc_back": document_back,
      "doc_type": doc_type,
    });
  }



  getStaticData(type) {
    return httpRequest(REQUEST_TYPE.GET, "$getStaticDataUrl?type=$type", {});
  }

  getProfile() async {
    return await httpRequest(REQUEST_TYPE.GET, profileUrl, {});
  }

  getOtherProfile(user_id, logged_user_id) async {
    return await httpRequest(
        REQUEST_TYPE.GET,
        "$otherUserprofile?user_id=$user_id${logged_user_id==null?"":"&logged_user_id=$logged_user_id"}",
        {});
  }

  getOtherPartnerNfts(id) async {
    return await httpRequest(REQUEST_TYPE.GET, "$otherPartnerNfts$id", {});
  }

  getActivites({id}) async {
    return await httpRequest(REQUEST_TYPE.GET, "$userActivities$id", {});
  }

  getCommunity() async {
    return await httpRequest(
        REQUEST_TYPE.GET, userCommunityUrl, {});
  }

  hideCommunity()async{
    return await httpRequest(
        REQUEST_TYPE.PATCH, hideCommunityUrl, {});
  }

  getOtherUserCommunity({id}) async {
    return await httpRequest(
        REQUEST_TYPE.GET, "$otherUserCommunityUrl$id", {});
  }

  getFollowers() async {
    return await httpRequest(REQUEST_TYPE.GET, getFollowersUrl, {});
  }

  getFollowing() async {
    return await httpRequest(REQUEST_TYPE.GET, getFollowingUrl, {});
  }
  /*---------------------*/

  forgetPasswordOtp({
    value,
    email,
    phone,
    countryCode,
  }) async {
    return httpRequest(REQUEST_TYPE.POST, forgetPassUrl, {
      "email": value == true ? email : "",
      "phone_no": value == true ? 0 : phone,
      "country_code": value == true ? "" : countryCode
    });
  }

  forgetVerifyOtp({value, email, phone, country, otp}) async {
    return httpRequest(REQUEST_TYPE.POST, otpVerifyUrl, {
      "email": value == true ? email : "",
      "phone_no": value == true ? 0 : phone,
      "country_code": value == true ? "" : country,
      "otp": otp
    });
  }

  changePassword({pass}) async {
    return httpRequest(REQUEST_TYPE.POST, changePass, {"password": pass});
  }

  sendOTp({phoneNo, countryCode, userType}) {
    return httpRequest(REQUEST_TYPE.POST, resendOTpUrl, {
      "phone_no": phoneNo,
      "country_code": countryCode,
      "user_type": userType
    });
  }

  sendEmailOTp({email, user_type}) async {
    List<String> phoneData = await getDeviceDetails();
    return httpRequest(REQUEST_TYPE.POST, resendEmailOtpUrl, {
      "email": email,
      "user_type": user_type,
      "device_type": phoneData[3].toUpperCase(),
    });
  }

  twoWayAuthentication(value) {
    return httpRequest(
        REQUEST_TYPE.POST, twoWayAuthenticationUrl, {"is_skip": value});
  }

  twoWayAuthenticationOTPResend({type}) {
    return httpRequest(REQUEST_TYPE.PATCH,
        type == 0 ? twoFAresendOTpUrl : twoFAresendEmailOtpUrl, {});
  }

  twoWayAuthenticationOTPResendLogin() {
    return httpRequest(REQUEST_TYPE.PATCH, twoFAresendOtpUrl, {});
  }

  twoFAVerifyOtp(String otp) async {
    return await httpRequest(REQUEST_TYPE.POST, twoFAVerifyOTp, {
      "otp": otp,
    });
  }

  phoneOtpVerify({otp, phone, countryCode, user_type}) {
    return httpRequest(REQUEST_TYPE.POST, phoneVerifyUrl, {
      "otp": otp,
      "phone_no": phone,
      "country_code": countryCode,
      // "user_type": user_type
    });
  }

  socialLogin(
      {socialType,
      socialToken,
      email,
      countryCode,
      phoneNumber,
      name, }) async {
    return httpRequest(REQUEST_TYPE.POST, socialLoginUrl, {
      "social_type": socialType,
      "social_token": socialToken,
      "email": email,
      "country_code": countryCode,
      "phone_no": phoneNumber ?? "",
      "name": name,
      "fcm_token": await StorageFunctions().getValue(firebaseToken)
    });
  }

  giftNft(emails, nft_id, userType) {
    return httpRequest(
        REQUEST_TYPE.POST, userType == 2 ? giftNftPartnerUrl : giftNftUserUrl, {
      "emails": emails,
      "nft_id": nft_id,
    });
  }

  getHomeScreenData() {
    return httpRequest(REQUEST_TYPE.GET, homeScreenUrl, {});
  }
  getSearch({string}) {
    return httpRequest(REQUEST_TYPE.GET, "$searchScreen?keyword=$string", {});
  }
  follow(id) async {
    return await httpRequest(REQUEST_TYPE.POST, followUrl, {"user_id": id});
  }

  //Follow User Nft-----
  getNewsFeed() {
    return httpRequest(REQUEST_TYPE.GET, newsfeedurl, {});
  }

  getOurPartnersList({page = 1, limit = 5}) {
    return httpRequest(
        REQUEST_TYPE.GET, "$partnersUrl?page=$page&limit=$limit", {});
  }
//NFts-------

  //Market Place-----
  getMarketPlaceNftResponse({page = 1, limit = 12}) {
    return httpRequest(REQUEST_TYPE.GET, "$nftsUrl?limit=$limit", {});
  }

  //Market Partner-----
  getPartnersNfts({page, limit,collection}) {
    return httpRequest(REQUEST_TYPE.GET, "$partnerNftUrl?page=$page&limit=$limit${collection!=null?"&collection_id=$collection":''}", {});
  }

  //NFtDetails----
  getNFtDetails(id,{isScanned=0,ownerId}) {
    return httpRequest(REQUEST_TYPE.GET, "$nftUrl=$id${ownerId!=null?"&owner_id=$ownerId":''}&is_scan=$isScanned", {});
  }

  addComments(text, id) {
    return httpRequest(
        REQUEST_TYPE.POST, nftCommentUrl, {"comment": text, "nft_id": id});
  }

  getActivePartner() {
    return httpRequest(REQUEST_TYPE.GET, activePartnerUrl, {});
  }

  //Like Nfts---
  likeNft(id) {
    return httpRequest(REQUEST_TYPE.POST, likeNftUrl, {"nft_id": id});
  }

  getRules() {
    return httpRequest(REQUEST_TYPE.GET,getPartnerRulesUrl,{});
  }
// reportType 1,2 user,nft

  reportUser(nftId, reason, message,index,reportType,userID){
    return httpRequest(REQUEST_TYPE.POST, reportType==1?reportUserUrl:reportNFtUrl,
        reportType==1?{
          "user_id": userID,
          "message": message,
          "type": index
        }:
        {
      "nft_id":nftId,
      "reason":reason,
      "message":message
    });
  }
  
  notificationList(type){
    return httpRequest(REQUEST_TYPE.GET,type==2?partnerNotification:userNotification,{});
  }


  giftHistory(){
    return httpRequest(REQUEST_TYPE.GET,giftHistoryUrl,{});
  }
  allCollection(){
    return httpRequest(REQUEST_TYPE.GET,hotProjectUrl,{});
  }

  setPartnerRules(count,rule,rule_id,type){
    return httpRequest(REQUEST_TYPE.POST,setPartnerRulesUrl,{
      "count": count,
      "rule": rule,
      "rule_id": rule_id,
      "type": type
    });

  }

  deleteRule({id}){
    return httpRequest(REQUEST_TYPE.DELETE, "$setPartnerRulesUrl/$id", {});
  }

  setNftForGift(id){
    return httpRequest(REQUEST_TYPE.POST,addNftRuleUrl,{
      "nft_id": id
    });

  }

  // Become A partner
  becomePartnerRequest(
      {firstName,
      lastName,
      country,
      state,
      phoneNumber,
      email,
      companyName,
      business,
      city,
      expLimit,
      countryCode}) {
    return httpRequest(REQUEST_TYPE.POST, requestPartner, {
      "first_name": firstName,
      "last_name": lastName,
      "country": country,
      "state": state,
      "phone_no": phoneNumber,
      "email": email,
      "company_name": companyName,
      "line_of_business": business,
      "city": city,
      "expected_limit": expLimit,
      "country_code": countryCode,
      "other_business": "String"
    });
  }

// Ongoing Campaigns
  onGoingCampaigns() {
    return httpRequest(REQUEST_TYPE.GET, onGoingCampaignsUrl, {});
  }

  twoFactorAuth(type, otp) {
    return httpRequest(
        REQUEST_TYPE.POST,
        "$twoWayAuthenticationUrl/verify/${type == 0 ? "email" : "phone"}",
        type == 0 ? {"email_otp": otp} : {"phone_otp": otp});
  }
}
