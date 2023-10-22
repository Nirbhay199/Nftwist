import 'package:flutter/material.dart';
import 'package:nftwist/constant/style.dart';
import 'package:nftwist/provider/auth.dart';
import 'package:nftwist/services/locator.dart';
import 'package:nftwist/services/navigation_service.dart';

import 'package:nftwist/ui/Bottom%20Nav%20Bar/home/become_partner.dart';

import 'package:nftwist/ui/Bottom%20Nav%20Bar/profile/User%20profile/User%20Settings/terms_conditions.dart';
import 'package:nftwist/ui/Bottom%20Nav%20Bar/profile/User%20profile/User%20Settings/verify.dart';
import 'package:nftwist/widget/alert_dialog.dart';

import 'package:nftwist/widget/appBar.dart';
import 'package:nftwist/widget/loader_screen.dart';
import 'package:provider/provider.dart';

import '../../../../../constant/app_content_modal.dart'as modal;
import '../../../../../constant/color.dart';
import '../../../../../provider/app_content.dart';
import '../../../../../provider/user.dart';
import '../../../../../services/storageFunctions.dart';
import '../../../../Auth Screen/SignIn/verify_phone_no2way.dart';
import '../../about_us.dart';
import 'Privacy_policy.dart';
import 'change_password.dart';
import 'faqs.dart';
import '../../help_center.dart';


class UserSettingScreen extends StatefulWidget {
  const UserSettingScreen({Key? key}) : super(key: key);
  static const route="user_settings";

  @override
  State<UserSettingScreen> createState() => _UserSettingScreenState();
}

class _UserSettingScreenState extends State<UserSettingScreen> {
  bool showAlert=false;
  bool loader=false;
  @override
  Widget build(BuildContext context) {
    final user=Provider.of<User>(context).user;
    List accountSettings = [
      {
        "txt": "Change Password",
        "fun": () {
          locator<NavigationService>().namedNavigateTo(ChangePassword.route);
        },
      },
      if(user?.is_two_way_auth_verified==false){
        "txt": "2 Factor Autentication",
        "fun": () {
          Provider.of<Auth>(context,listen: false).twoWayAuthentication(0);
          locator<NavigationService>().push(MaterialPageRoute(builder: (context) => Verify2wayPhone(screenType: 1),settings: RouteSettings(name: Verify2wayPhone.route)));
        },
      },
      if(user?.document_status!=2&&user?.document_status!=3)   {
        "txt": "Verify",
        "fun": () {
          locator<NavigationService>().namedNavigateTo(VerifyScreen.route);
        },
      },
      {
        "txt": "Become a Partner",
        "fun": () {
          locator<NavigationService>().namedNavigateTo(BecomePartner.route);
        },
      },
    ];
    List supportSettings = [
      {
        "txt": "FAQ",
        "fun": () {
          locator<NavigationService>().namedNavigateTo(FAQsScreen.route);
        },
      },
      {
        "txt": "About Us",
        "fun": () {
          locator<NavigationService>().namedNavigateTo(AboutUsScreen.route);
        },
      },
      {
        "txt": "Privacy Policy",
        "fun": () {
          locator<NavigationService>().namedNavigateTo(PrivacyPolicyScreen.route);
        },
      },{
        "txt": "Terms & Conditions",
        "fun": () {
          locator<NavigationService>().namedNavigateTo(TermsConditions.route);
        },
      },
      {
        "txt": "Help Center",
        "fun": () {
          locator<NavigationService>().namedNavigateTo(HelpCenter.route);
        }
      },
      {
        "txt": "Log Out",
        "fun": () {
          setState(() {
            showAlert=true;
          });
        }
      },
    ];
    return CustomAlertDialog(
      loading: showAlert,
      title:'Confirmation !',
      subtitle:  'Are you sure you want to Logout ?',
      button1Txt: "Yes",
      button2Txt:  "No",
      button2fun: (){
        setState(() {
          showAlert=false;
        });
      },
      button1fun: ()async{
        setState(() {
          showAlert=false;
          loader=true;
        });
        Provider.of<User>(context,listen: false).logOut(context);
            },
      child: Scaffold(
        appBar: const CustomAppBar(title: "Settings"),
        body: LoaderPage(
          loading: loader,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  Text("ACCOUNT SETTINGS",style: w_400.copyWith(fontSize: 14),),
                  ListView.separated(
                    padding: const EdgeInsets.only(top: 10, ),
                    shrinkWrap: true,
                    itemCount: accountSettings.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ListTile(
                        horizontalTitleGap: 0,
                        contentPadding: EdgeInsets.zero,
                        onTap: accountSettings[index]['fun'],
                        title:  Text(
                          accountSettings[index]['txt'],
                          style: w_500.copyWith(fontSize: 16),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios,color: whiteColor,size: 14,),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(
                      thickness: 1,
                      height: 0,
                      color: blackBorderColor,
                    ),
                    // itemCount: profileList.length
                  ),
                  const Divider(
                    thickness: 1,
                    height: 0,
                    color: blackBorderColor,
                  ),
                  SizedBox(height: 35,),
                  Text("SUPPORT",style: w_400.copyWith(fontSize: 14),),
                  ListView.separated(
                    padding: const EdgeInsets.only(top: 10,),
                    shrinkWrap: true,
                    itemCount: supportSettings.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ListTile(
                        horizontalTitleGap: 0,
                        contentPadding: EdgeInsets.zero,
                        onTap: supportSettings[index]['fun'],
                        title:  Text(
                          supportSettings[index]['txt'],
                          style: w_500.copyWith(fontSize: 16),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios,color: whiteColor,size: 14,),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(
                      thickness: 1,
                      height: 0,
                      color: blackBorderColor,
                    ),
                    // itemCount: profileList.length
                  ),
                  const Divider(
                    thickness: 1,
                    height: 0,
                    color: blackBorderColor,
                  ),
                ],),
            ),
          ),
        ),
       ),
    );
  }
}