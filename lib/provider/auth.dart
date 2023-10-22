import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nftwist/provider/homeModule.dart';
import 'package:nftwist/provider/user.dart';
import 'package:nftwist/ui/Auth%20Screen/SignIn/2_way_auth_otp.dart';
import 'package:nftwist/ui/Auth%20Screen/SignIn/sign_in.dart';
import 'package:nftwist/ui/Bottom%20Nav%20Bar/bottom_nav_bar.dart';
import 'package:provider/provider.dart';
import '../constant/toaster.dart';
import '../services/api_response_handler.dart';
import '../services/locator.dart';
import '../services/navigation_service.dart';
import '../services/storageFunctions.dart';
import '../ui/Auth Screen/SignIn/forget_otp_verify.dart';
import '../ui/Auth Screen/SignIn/rest_password.dart';
import '../ui/Auth Screen/SignIn/2_way_auth.dart';
import '../ui/Auth Screen/SignIn/verify_phone_no2way.dart';
import '../ui/Auth Screen/Signup/personal_details.dart';
import '../ui/Auth Screen/Signup/sign_up.dart';
import '../ui/Auth Screen/Signup/verify_email.dart';
import '../ui/Auth Screen/Signup/verify_otp_screen.dart';
import '../widget/success_screen.dart';

class Auth with ChangeNotifier {
  var toast = locator<Toaster>();
  var navigation = locator<NavigationService>();

  bool validatePassword(password,{bottomMargin,message}) {
    bool valid = true;
    if (password == '' || password == null) {
      valid = false;
      toast.showToaster(
        msg: message?? "Please new enter Password",
      );
    } else if (!RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
        .hasMatch(password!)) {
      valid = false;
      toast.showToaster(
          msg:
              "Password should be alpha numeric with minimum 8 characters with 1 Uppercase,1 Lowercase and 1 Special Character. Eg:- London@001 or TeSt'@001.",
          bottomMargin: bottomMargin??.74,
          toasterHeight: 120,
          textAlign: TextAlign.start,
          toasterDurationMilli: 2100,
          loadingDuration: 7);
      // const Toaster(msg: ).showToaster(context,.77,toasterHeight: 120,textAlign: TextAlign.start,toasterDurationMilli:2100,loadingDuration: 7) ;
    }
    return valid;
  }
  bool validateSignInPassword(password) {
    bool valid = true;
    if (password == '' || password == null) {
      valid = false;
      toast.showToaster(
        msg: "Please enter Password",
      );
    }else if(password.toString().length< 5){
      valid = false;
      toast.showToaster(
        msg: "Please enter correct Password",
      );
    }
    return valid;
  }

  bool validateEmail(email) {
    bool valid = true;
    if (email == '' || email == null) {
      valid = false;
      locator<Toaster>().showToaster(msg: "Please provide your Email");
    } else if (!RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email!)) {
      valid = false;
      locator<Toaster>().showToaster(msg: "Please provide valid e-mail Address");
    }
    return valid;
  }

  bool validateConfirmPassword(confirmPassword, password,{bool signUp=false}) {
    bool valid = true;
    if (confirmPassword == '' || confirmPassword == null) {
      valid = false;
      toast.showToaster(
        msg: "Please Re-enter the password.",
      );
    } else if (confirmPassword != password) {
      valid = false;
      toast.showToaster(
        msg: signUp==true?"Password and Confirm Password does not match":"New password and Confirm new Password does not match",
      );
    }
    return valid;
  }

  signUp(context, {email, password, confirmPassword}) async {
    if (validateEmail(email) &&
        validatePassword(password,message: "Please enter Password") &&
        validateConfirmPassword(confirmPassword, password,signUp: true)) {
      var response = await ApiResponse()
          .signUp(email: email, password: password);
      response = await jsonDecode(response.body);
      if (response['message'] == "Success") {
        Provider.of<User>(context, listen: false)
            .fetchUser(response['result'], response['token']);
        // Provider.of<Nfts>(context,listen: false).getNewsFeeds();
        return navigation.namedNavigateTo(VerifyEmail.route);
      } else {
        toast.showToaster(
            msg: response['error_description'],
            toasterDurationMilli: 1400,
            loadingDuration: 5);
      }
    }
    return false;
  }

  verifyEmailDevice(context, { otps}) async {
    final response =
        await ApiResponse().signupEmailOtpVerify(otp: otps,);
    var data = await jsonDecode(response.body);
    print(data);
    if (response.statusCode == 200) {
       StorageFunctions().setValue(authToken, data['token']);
       Provider.of<User>(context,listen: false).editUser(data['data']);
       return navigation.namedNavigateTo(PersonalDetails.route);
    } else {
      locator<Toaster>().showToaster(msg:"Incorrect OTP entered");
    }
    return false;
  }

  signIn(context, {email, password, confirmPassword}) async {
    if (validateEmail(email) && validateSignInPassword(password)) {
      var result = await ApiResponse()
          .signIn(email: email, password: password);
      var response = await jsonDecode(result.body);
      if (result.statusCode == 200) {
        print("------DA$response");
        Provider.of<User>(context, listen: false).fetchUser(response['user'], response['token']);
        // Provider.of<Nfts>(context,listen: false).getNewsFeeds();
        // locator<NavigationService>().namedNavigateTo(TwoWayAuth.route);
        Provider.of<HomeModuleProvider>(context,listen: false).getHomeScreenDate(context);
      if(Provider.of<User>(context,listen: false).user?.user_type==2){
        return navigation
            .push(MaterialPageRoute(builder: (context) => const BottomNavBar(),settings: const RouteSettings(name: BottomNavBar.route)));
      }
      else if(Provider.of<User>(context,listen: false).user?.is_email_verified==false) {
           return navigation
              .push(MaterialPageRoute(builder: (context) => const VerifyEmail(screenType: 1,),settings: const RouteSettings(name: VerifyEmail.route))); }
        else if(Provider.of<User>(context,listen: false).user?.phone_no==null){
          return navigation
              .push(MaterialPageRoute(builder: (context) => const PersonalDetails(),settings: const RouteSettings(name: PersonalDetails.route)));
        }
        else if(Provider.of<User>(context,listen: false).user?.is_phone_verified==false){
          return navigation
              .push(MaterialPageRoute(builder: (context) => const OTPVerify(screenType: 1,),settings: const RouteSettings(name: OTPVerify.route)));
        }
        if(Provider.of<User>(context,listen: false).user?.is_two_way_auth_enabled==true){
          StorageFunctions().setValue(twoFADone,'0');
          return navigation
              .push(MaterialPageRoute(builder: (context) => const TwoFAAuth(),settings: const RouteSettings(name: TwoFAAuth.route)));
        }
        else{
          return navigation
              .push(MaterialPageRoute(builder: (context) => const BottomNavBar(),settings: const RouteSettings(name: BottomNavBar.route)));
        }
      } else {
        toast.showToaster(
            msg: response['error_description'],
            toasterDurationMilli: 1400,
            loadingDuration: 5);
      }
    }
    return false;
  }

  Future<bool> personalInfo(
    context, {
    firstName,
    lastName,
    userName,
    bio,
    profile_pic,
    cover_image,
    cover_image_y_axis,
    personal_link,
    country,
    state,
    phone_no,
    country_code,
    doc_front,
    document_back,
    doc_type,
    dob,gender,
    flag,double? bottomMargin
    // nickName,image_size, new_password, confirm_password
  }) async {
    var toaster = locator<Toaster>();
    if (firstName == null || firstName == '') {
      toaster.showToaster(msg: "Please provide your First Name",bottomMargin:bottomMargin );
    } else if (lastName == null || lastName == '') {
      toaster.showToaster(msg: "Please provide your Last Name",bottomMargin:bottomMargin );
    } else if (userName == null || userName == '') {
      toaster.showToaster(msg: "Please provide your User Name",bottomMargin:bottomMargin );
    } else if ((phone_no == null || phone_no == '')) {
      toaster.showToaster(msg: "Please provide your Phone Number",bottomMargin:bottomMargin );
    } else if ((country == null || country == '')) {
      toaster.showToaster(msg: "Please provide your Country",bottomMargin:bottomMargin );
    } else if ((state == null || state == '')) {
      toaster.showToaster(msg: "Please provide your State",bottomMargin:bottomMargin );
    } else {
      var response = await ApiResponse().personalInfo(
        firstName: firstName,
        lastName: lastName,
        flag: flag,
        // nickName: nickName,
        userName: userName,
        bio: bio,
        // image_size: image_size,
        profile_pic: profile_pic,
        cover_image: cover_image,
        cover_image_y_axis: cover_image_y_axis,
        personal_link: personal_link,
        country: country,
        state: state,
        phone_no: phone_no,
        country_code: country_code,
        doc_front: doc_front,
        document_back: document_back,
        doc_type: doc_type,
        dob: dob,gender: gender
        // new_password: new_password,
        // confirm_password: confirm_password,
      );
      if (response.statusCode == 200) {
        response = await jsonDecode(response.body);
        Provider.of<User>(context, listen: false).editUser(response['user']);
           navigation.push(CupertinoPageRoute(
              builder: (context) => const OTPVerify(),
              settings: const RouteSettings(name: OTPVerify.route)));
       } else {
        response = await jsonDecode(response.body);
        toast.showToaster(
            msg: response['error_description'],
            toasterDurationMilli: 1400,
            loadingDuration: 5,bottomMargin:bottomMargin );
        return false;
      }
    }
    return false;
  }


  Future<bool> editProfile(
      context, {
        firstName,
        lastName,
        userName,
        bio,
        profile_pic,
        cover_image,
        cover_image_y_axis,
        personal_link,
        country,
        state,
        phone_no,
        country_code,
        doc_front,
        document_back,
        doc_type,
        dob,gender,
        flag
        // nickName,image_size, new_password, confirm_password
      }) async {
    var toaster = locator<Toaster>();
    if (firstName == null || firstName == '') {
      toaster.showToaster(msg: "Please provide your First Name",bottomMargin:.75, );
    } else if (lastName == null || lastName == '') {
      toaster.showToaster(msg: "Please provide your Last Name",bottomMargin:.75, );
    } else if (userName == null || userName == '') {
      toaster.showToaster(msg: "Please provide your User Name",bottomMargin:.75, );
    } else if ((phone_no == null || phone_no == '')) {
      toaster.showToaster(msg: "Please provide your Phone Number",bottomMargin:.75, );
    }else {
      var response = await ApiResponse().editProfile(
          firstName: firstName,
          lastName: lastName,
          flag: flag,
          // nickName: nickName,
          userName: userName,
          bio: bio,
          // image_size: image_size,
          profile_pic: profile_pic,
          cover_image: cover_image,
          cover_image_y_axis: cover_image_y_axis,
          personal_link: personal_link,
          country: country,
          state: state,
          phone_no: phone_no,
          country_code: country_code,
          doc_front: doc_front,
          document_back: document_back,
          doc_type: doc_type,
          dob: dob,gender: gender
        // new_password: new_password,
        // confirm_password: confirm_password,
      );
      if (response.statusCode == 200) {
        response = await jsonDecode(response.body);
        Provider.of<User>(context, listen: false).editUser(response['data']);
          Navigator.pop(context);
          return false;
      } else {
        response = await jsonDecode(response.body);
        toast.showToaster(
            msg: response['error_description'],
            toasterDurationMilli: 1400,
            loadingDuration: 5,bottomMargin:.75, );
        return false;
      }
    }
    return false;
  }




  Future<bool> updateDoc(
      context, {
        doc_front,
        document_back,
        doc_type,
       }) async {
      var response = await ApiResponse().updateDoc(
          doc_front: doc_front,
          document_back: document_back,
          doc_type: doc_type,
      );
      if (response.statusCode == 200) {
        response = await jsonDecode(response.body);
        Provider.of<User>(context, listen: false).editUser(response['data']);
        Navigator.pop(context);
        return false;
      } else {
        response = await jsonDecode(response.body);
        toast.showToaster(
          msg: response['error_description'],
          toasterDurationMilli: 1400,
          loadingDuration: 5,bottomMargin:.67, );
        return false;
      }
  }


  forgetPasswordSendOpt({value, email, phone, country,resend=false}) async {
    if (value == true ? validateEmail(email) : phone.toString().isNotEmpty) {
      var response = await ApiResponse().forgetPasswordOtp(
          email: email, phone: phone, countryCode: country, value: value);
      var data = await jsonDecode(response.body);
      if (response.statusCode == 200) {
       if(!resend) {
         locator<NavigationService>().namedNavigateTo(ForgetVerifyPassword.route,
            arguments: {
              "email": email,
              "phone": phone,
              "countryCode": country,
              "value": value
            });
       }
        return true;
        // navigation.push(CupertinoPageRoute(builder: (context) => const OTPVerify(screenType: 1),settings: const RouteSettings(name: OTPVerify.route)));
      } else {
        locator<Toaster>().showToaster(msg: data["error_description"]);
        return false;
      }
    }
  }

  Future<bool> resendOtp({countryCode, phoneNo, userType}) async {
    final response = await ApiResponse().sendOTp(
        countryCode: countryCode, phoneNo: phoneNo, userType: userType);
    if (response.statusCode == 200) {
      return true;
    } else {
      var data = await jsonDecode(response.body);
      locator<Toaster>().showToaster(msg: data["error_description"]);
      return false;
    }
  }

  TwoFA(type)async {
    final result=await ApiResponse().twoWayAuthenticationOTPResend(type: type);
    print(result.body);
    if(result.statusCode==200){
      return true;
    }else{
      return false;
    }
  }
  TwoFALoginOtp()async {
    final result=await ApiResponse().twoWayAuthenticationOTPResendLogin();
    print(result.body);
    if(result.statusCode==200){
      return true;
    }else{
      return false;
    }
  }

  Future<bool> resendEmailOtp({
    email,userType
  }) async {
    final response = await ApiResponse().sendEmailOTp(email: email,user_type: userType);
    print(response.body);
    if (response.statusCode == 200) {
      return true;
    } else {
      var data = await jsonDecode(response.body);
      locator<Toaster>().showToaster(msg: data["error_description"]);
      return false;
    }
  }

  twoWayAuthentication(int value) async {
    var response = await ApiResponse().twoWayAuthentication(value);
    print(response.body);
    if (response.statusCode == 200) {
      if (value == 0) {
        locator<NavigationService>().namedNavigateTo(Verify2wayPhone.route);
      } else {
        locator<NavigationService>().namedNavigateTo(BottomNavBar.route);
      }
    } else {
      print(response.body);
    }
  }

  verifyPhoneOtp(context,{otp, cc, ph,type}) async {
    var response = await ApiResponse()
        .phoneOtpVerify(otp: otp, countryCode: cc, phone: ph,user_type: type);
    var data = await jsonDecode(response.body);
    print(data);
    if (response.statusCode == 200) {
      Provider.of<User>(context,listen: false).editUser(data['user']);
      // locator<NavigationService>().namedNavigateTo(BottomNavBar.route);
      data['social_type']==null?
          locator<NavigationService>().namedNavigateTo(TwoWayAuth.route):locator<NavigationService>().namedNavigateTo(BottomNavBar.route)
      ;
    } else {
      locator<Toaster>().showToaster(msg: data["error_description"]);
    }
    return false;
  }

  updatePassword(old_pass, new_pass,confirm_pass)async{
    if(validatePassword(new_pass,bottomMargin: .7) &&
        validateConfirmPassword(confirm_pass, new_pass)){
      var result=await ApiResponse().updatePassword(old_pass, new_pass);
      if(result.statusCode==200){
        locator<NavigationService>().namedNavigateTo(SuccessFullScreen.route,arguments: "Password Changed");
      }else{
        result = await jsonDecode(result.body);
        locator<Toaster>().showToaster(msg: result["error_description"]);
      }
    }
  }
  // forgetVerifyOtp({emails, otps, newPass, confirmPass}) async {
  //   var response = await ApiResponse().forgetVerifyOtp(email: emails, otp: otps);
  //   var data = await jsonDecode(response.body);
  //   if (response.statusCode == 200) {
  //     StorageFunctions().setValue(authToken, data['token']);
  //     var res = await ApiResponse().changePassword(pass: confirmPass);
  //
  //     if (response.statusCode == 200) {
  //       // locator<Toaster>().showToaster(msg:await jsonDecode(response["message"]));
  //     } else {
  //       locator<Toaster>().showToaster(msg: data["error_description"]);
  //     }
  //   } else {
  //     locator<Toaster>().showToaster(msg: data["error_description"]);
  //   }
  // }

  forgetPasswordVerifyOtp(context, {value, email, phone, country, otp}) async {
    var response = await ApiResponse().forgetVerifyOtp(
        email: email, country: country, otp: otp, value: value, phone: phone);
    var data = await jsonDecode(response.body);
    if (response.statusCode == 200) {
      StorageFunctions().setValue(authToken, data['token']);
      locator<NavigationService>().namedNavigateTo(
        RestPassword.route,
      );
    } else {
      locator<Toaster>().showToaster(msg: data["error_description"]);
    }
    return false;
  }

  setForgetPassword(newPass, confirmPass) async {
    if (validatePassword(newPass) &&
        validateConfirmPassword(confirmPass, newPass)) {
      var res = await ApiResponse().changePassword(pass: confirmPass);
      var data = await jsonDecode(res.body);
      if (res.statusCode == 200) {
        locator<NavigationService>().namedNavigateTo(SignUp.route);
        locator<NavigationService>().namedNavigateTo(SignIn.route);
      } else {
        locator<Toaster>().showToaster(msg: data["error_description"]);
      }
    }
    return false;
  }

  socialLogin(context,{socialType,socialToken,email,countryCode,phoneNumber,name,fcmtoken}) async {
    /*List<String> phoneData = await getDeviceDetails();*/
    print("___$socialToken");
    var response=await ApiResponse().socialLogin(
        socialType: socialType,
        socialToken: socialToken,
        name: name,
        email: email,
     );
    print(response.body);
    if (response.statusCode==200){
      response = await jsonDecode(response.body);
      Provider.of<User>(context, listen: false).fetchUser(response['user'], response['token']);
      if(Provider.of<User>(context,listen: false).user?.user_type==2){
        return navigation
            .push(MaterialPageRoute(builder: (context) => const BottomNavBar(),settings: const RouteSettings(name: BottomNavBar.route)));
      }
      else   if(Provider.of<User>(context,listen: false).user?.is_email_verified==false) {
        return navigation
            .push(MaterialPageRoute(builder: (context) => const VerifyEmail(screenType: 1,),settings: const RouteSettings(name: VerifyEmail.route))); }
      else if(Provider.of<User>(context,listen: false).user?.phone_no==null){
        return navigation
            .push(MaterialPageRoute(builder: (context) => const PersonalDetails(),settings: const RouteSettings(name: PersonalDetails.route)));
      }
      else if(Provider.of<User>(context,listen: false).user?.is_phone_verified==false){
        return navigation
            .push(MaterialPageRoute(builder: (context) => const OTPVerify(screenType: 1,),settings: const RouteSettings(name: OTPVerify.route)));
      }else{
        // Provider.of<Nfts>(context,listen: false).getNewsFeeds();
        return navigation
            .push(MaterialPageRoute(builder: (context) => const BottomNavBar(),settings: const RouteSettings(name: BottomNavBar.route)));
      }
    }else{
      response = await jsonDecode(response.body);
      locator<Toaster>().showToaster(msg: response["error_description"]);
    }
    // final response=await httpRequest(REQUEST_TYPE.POST, socialLoginUrl, {
    //   "social_id":socialId,
    //   "provider_id":provider_id,
    //   "name":displayName,
    //   "email":email,
    //   "login_via":phoneData[3]
    // }, context: context);
    // if(response.statusCode==200){
    //   var data=await jsonDecode(response.body);
    //   print(data["data"]["access_token"]);
    //   Provider.of<UserDataProvider>(context,listen: false).setStorage(data["data"]["access_token"]);
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => const HomeScreen()),
    //   );
    // }else{
    //
    // }
  }
  becomePartnerRequest({firstName,lastName,country,state,phoneNumber,email,companyName,business,city,expLimit,countryCode}) async {
    var response = await ApiResponse().becomePartnerRequest(country: country,
        countryCode: countryCode,
        email: email,business: business,city: city,companyName: companyName,expLimit: expLimit,firstName: firstName,lastName: lastName,phoneNumber: phoneNumber,state:state );
    var data = await jsonDecode(response.body);
    if(response.statusCode==200){
      locator<NavigationService>().namedNavigateTo(SuccessFullScreen.route,arguments: "Your request is sent.");
      // locator<NavigationService>().goBack();
      // locator<Toaster>().showToaster(msg: "Your request is sent",loadingDuration: 4,toasterDurationMilli: 1400,color: Colors.green);
    }else{
      locator<Toaster>().showToaster(msg: data["error_description"]);
    }
    return false;
  }

  verifyTwoAF(context,otp)async{
    final result= await ApiResponse().twoFAVerifyOtp(otp);
    final data= await jsonDecode(result.body);
    if(result.statusCode==200){
      // Provider.of<Nfts>(context,listen: false).getNewsFeeds();
      StorageFunctions().setValue(twoFADone,'1');
      Provider.of<User>(context, listen: false).fetchUser(data['user'], data['token']);
      return navigation
          .push(MaterialPageRoute(builder: (context) => const BottomNavBar(),settings: const RouteSettings(name: BottomNavBar.route)));
    }else{
      locator<Toaster>().showToaster(msg: data["error_description"]);

    }
    return false;
  }
  coutactUs(firstName,lastName,email,phoneNo,description,country_code) async {
    var toaster = locator<Toaster>();
    if (firstName == null || firstName == '') {
      toaster.showToaster(msg: "Please provide your First Name" );
    } else if (lastName == null || lastName == '') {
      toaster.showToaster(msg: "Please provide your Last Name");
    } else if (validateEmail(email)==false) {
    } else if ((phoneNo == null || phoneNo == '')) {
      toaster.showToaster(msg: "Please provide your Phone Number");
    } else if ((description == null || description == '')) {
      toaster.showToaster(msg: "Please provide your Description");
    } else{

      var result=await ApiResponse().contactUs(firstName, lastName, email, phoneNo, description,country_code);
      if(result.statusCode==200){
        locator<NavigationService>().namedNavigateTo(SuccessFullScreen.route,arguments: "Thank you for getting in touch!");
        return true;
      }else{
        result = await jsonDecode(result.body);
        print(result);
        locator<Toaster>().showToaster(msg: result["error_description"]);
        return false;
      }}

  }

}
