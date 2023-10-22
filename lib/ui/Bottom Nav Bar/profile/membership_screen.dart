import 'package:flutter/material.dart';
import 'package:nftwist/constant/apiConstant.dart';
import 'package:nftwist/constant/color.dart';
import 'package:nftwist/provider/user.dart';
import 'package:nftwist/widget/appBar.dart';
import 'package:nftwist/widget/loader_screen.dart';
import 'package:provider/provider.dart';

import '../../../constant/style.dart';
import '../../../provider/other_profile.dart';

class MemberShipScreen extends StatefulWidget {
  const MemberShipScreen({Key? key}) : super(key: key);
  static const route="member_ship";

  @override
  State<MemberShipScreen> createState() => _MemberShipScreenState();
}

class _MemberShipScreenState extends State<MemberShipScreen> {
  bool loading=false;
  @override
  Widget build(BuildContext context) {
    List members=Provider.of<User>(context).user?.memberships;
    var user = Provider.of<User>(context).user;
    return LoaderPage(
      loading: loading,
      child: Scaffold(
        appBar: const CustomAppBar(title: "Membership"),
        body: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          shrinkWrap: true,
          itemCount: members.length+1,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return index>members.length-1?Container():ListTile(
              horizontalTitleGap: 10,
              contentPadding: EdgeInsets.zero,
              minLeadingWidth: .8,
              onTap: () async {
                setState(() {
                  loading=true;
                });
                loading=await  Provider.of<OtherUserProfile>(context,listen: false).getOtherUserProfile(id: members[index]['_id'],user_id:user?.id);
                setState(() {
                  print("After---$loading");
                });
              },
              // onTap: rules[index]['fun'],
              leading:SizedBox(height: 40,width: 40,child: ClipOval(
                child: Image(image: NetworkImage("$imageBaseUrl${members[index]["profile_pic"]}"),fit: BoxFit.cover,errorBuilder: (context, error, stackTrace) => Image.asset("assets/images/banner-image.png",fit:BoxFit.cover,),),
              ),) ,
              title: Text(
                user?.memberships[index]['first_name']??user?.memberships[index]['user_name'],
                style: w_400.copyWith(fontSize: 14),
              ),
            );
          },
          separatorBuilder: (context, index) => const Divider(
            thickness: 1,
            height: 10,
            color: blackBorderColor,
          ),
          // itemCount: profileList.length
        ),

      ),
    );
  }
}
