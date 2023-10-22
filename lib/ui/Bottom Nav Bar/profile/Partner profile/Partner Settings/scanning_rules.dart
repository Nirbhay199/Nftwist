import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nftwist/constant/color.dart';
import 'package:nftwist/provider/user.dart';
import 'package:nftwist/services/locator.dart';
import 'package:nftwist/ui/Bottom%20Nav%20Bar/profile/User%20profile/owned_nft_list.dart';
import 'package:nftwist/widget/appBar.dart';
import 'package:provider/provider.dart';

import '../../../../../constant/style.dart';
import '../../../../../constant/toaster.dart';
import '../../../../../services/navigation_service.dart';
import '../../../../../widget/button.dart';
import 'add_rule_page.dart';

class ScanningRules extends StatefulWidget {
  const ScanningRules({Key? key}) : super(key: key);
  static const route = "scanning_rules";

  @override
  State<ScanningRules> createState() => _ScanningRulesState();
}

class _ScanningRulesState extends State<ScanningRules> {
  var future;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    future = Provider.of<User>(context, listen: false).getRules();
  }

  @override
  Widget build(BuildContext context) {
    List rules = Provider.of<User>(context).rules;
    return Scaffold(
      appBar: const CustomAppBar(title: "Scanning Rules"),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            Container(
              height: 92,margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: blackBorderColor),
                  borderRadius: BorderRadius.circular(12)),
              child: Button_2(
                buttonTxt: " Add NFT For Automation",
                function: () {
                  locator<NavigationService>()
                      .push(MaterialPageRoute(builder: (context) => const OwnedNfts(type: 1),settings: const RouteSettings(name: OwnedNfts.route)));       },
                verticalPadding: 20,
                horizontalPadding: 20,
              ),
            ),
            Container(
              height: 92,
              decoration: BoxDecoration(
                  border: Border.all(color: blackBorderColor),
                  borderRadius: BorderRadius.circular(12)),
              child: Button_2(
                buttonTxt: " Add NFT Automation Rules",
                function: () {
                  if(rules.length>5){
                    locator<Toaster>()
                        .showToaster(msg: "Delete Some Rules ", bottomMargin: .8);
                  }else{
                    locator<NavigationService>()
                        .namedNavigateTo(AddRulesScreen.route);
                  }
                },
                verticalPadding: 20,
                horizontalPadding: 20,
              ),
            ),

            FutureBuilder(
              future: future,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: CircularProgressIndicator(
                        color: whiteColor,
                      ),
                    ),
                  );
                } else if (rules.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: Text("No Rules for Nft's"),
                    ),
                  );
                } else {
                  return ListView.separated(
                    padding: const EdgeInsets.only(
                      top: 10,
                    ),
                    shrinkWrap: true,
                    itemCount: rules.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ListTile(
                        horizontalTitleGap: 0,
                        contentPadding: EdgeInsets.zero,
                        minLeadingWidth: .8,
                        // onTap: () {
                        //   locator<NavigationService>().push(MaterialPageRoute(
                        //       builder: (context) => AddRulesScreen(
                        //           rule: rules[index]['rule'],
                        //           type: rules[index]['type'],
                        //           count: rules[index]['count'].toString(),
                        //           rule_id: rules[index]['_id']),
                        //       settings: const RouteSettings(
                        //           name: AddRulesScreen.route)));
                        // },
                        // leading: Padding(
                        //   padding: const EdgeInsets.only(right: 5),
                        //   child: Checkbox(
                        //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                        //     materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        //     visualDensity: const VisualDensity(horizontal: -4, vertical: 1),
                        //     side:const BorderSide(color:whiteColor2 ) ,
                        //     activeColor: whiteColor2,
                        //     checkColor: blackColor,
                        //     value: rules[index]["value"],
                        //     onChanged: (bool? value) {
                        //       setState((){
                        //         rules[index]["value"]=value;
                        //       });
                        //     },
                        //   ),
                        // ),
                        title: Text(
                          rules[index]['rule'],
                          style: w_400.copyWith(fontSize: 14),
                        ),
                        trailing: IconButton(onPressed: (){
                          Provider.of<User>(context,listen: false).delete(rules[index]['_id']);
                        }, icon: SvgPicture.asset("assets/icons/delete.svg",width: 20,)),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(
                      thickness: 1,
                      height: 0,
                      color: blackBorderColor,
                    ),
                    // itemCount: profileList.length
                  );
                }
              },
            ),

            const SizedBox(height: 5,),
            const Divider(
              thickness: 1,
              height: 0,
              color: blackBorderColor,
            ),
          ],
        ),
      ),
      // bottomNavigationBar: Container(
      //   padding: const EdgeInsets.symmetric(vertical: 20),
      //   color: blackColor,
      //   child: Button(buttonTxt: "Save Changes", function: () {}),
      // ),
    );
  }
}
