import 'package:flutter/material.dart';
import 'package:nftwist/constant/color.dart';
import 'package:nftwist/constant/style.dart';
import 'package:nftwist/provider/app_content.dart';
import 'package:nftwist/provider/user.dart';
import 'package:nftwist/services/locator.dart';
import 'package:nftwist/services/navigation_service.dart';
 import 'package:nftwist/ui/Bottom%20Nav%20Bar/profile/Partner%20profile/Partner%20Settings/scanning_rules.dart';
import 'package:nftwist/ui/Bottom%20Nav%20Bar/profile/about_us.dart';
import 'package:nftwist/widget/alert_dialog.dart';
import 'package:nftwist/widget/loader_screen.dart';
import 'package:provider/provider.dart';
import '../../../../../constant/app_content_modal.dart'as modal;

import '../../../../../widget/appBar.dart';
import '../../User profile/User Settings/Privacy_policy.dart';
import '../../User profile/User Settings/change_password.dart';
import '../../User profile/User Settings/faqs.dart';
import '../../help_center.dart';


class PartnerSettingScreen extends StatefulWidget {
  const PartnerSettingScreen({Key? key}) : super(key: key);
  static const route="partner_settings";

  @override
  State<PartnerSettingScreen> createState() => _PartnerSettingScreenState();
}

class _PartnerSettingScreenState extends State<PartnerSettingScreen> {
  bool showAlert=false;
  bool loader=false;
  @override
  Widget build(BuildContext context) {
    List accountSettings = [
      {
        "txt": "Change Password",
        "fun": () {
          locator<NavigationService>().namedNavigateTo(ChangePassword.route);
        },
      },
      {
        "txt": "Scanning Rules",
        "fun": () {
          locator<NavigationService>().namedNavigateTo(ScanningRules.route);
        },
      },
    ];
    List supportSettings = [
      {
        "txt": "FAQ",
        "fun": () {
          locator<NavigationService>().namedNavigateTo(FAQsScreen.route);},
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
          Provider.of<AppContents>(context,listen: false).getAppData(modal.type.PRIVACY_POLICY.name);
          locator<NavigationService>().namedNavigateTo(PrivacyPolicyScreen.route);

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
            margin: const EdgeInsets.symmetric(horizontal: 20),
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
                const SizedBox(height: 35,),
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
                      onTap:supportSettings[index]['fun'],
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
    );
  }
}