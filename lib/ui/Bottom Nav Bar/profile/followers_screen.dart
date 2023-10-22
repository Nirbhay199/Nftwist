import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nftwist/constant/color.dart';
import 'package:nftwist/widget/appBar.dart';
import 'package:provider/provider.dart';

import '../../../constant/apiConstant.dart';
import '../../../constant/style.dart';
import '../../../provider/user.dart';

class FollowerScreen extends StatefulWidget {
  const FollowerScreen({Key? key}) : super(key: key);
 static const route="followers";

  @override
  State<FollowerScreen> createState() => _FollowerScreenState();
}

class _FollowerScreenState extends State<FollowerScreen> {
   var future;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    future= Provider.of<User>(context,listen: false).getUserFollower();
  }
  @override
  Widget build(BuildContext context) {
    var follower =Provider.of<User>(context).userFollower;

    return Scaffold(
      appBar: const CustomAppBar(title: "Followers"),
   body:  FutureBuilder(future: future, builder: (context, snapshot) {
     if(snapshot.connectionState==ConnectionState.waiting){
       return const Center(child: CircularProgressIndicator(color:whiteColor,),);
     }if(follower.isEmpty){
       return const Center(child: Text("No Followers"),);
     }else{
       return ListView.separated(
         padding: const EdgeInsets.symmetric(horizontal: 20),
         shrinkWrap: true,
         itemCount: follower.length+1,
         physics: const NeverScrollableScrollPhysics(),
         itemBuilder: (context, index) {
           return index>follower.length-1?Container():ListTile(
             horizontalTitleGap: 10,
             contentPadding: EdgeInsets.zero,
             minLeadingWidth: .8,

             // onTap: rules[index]['fun'],
             leading:SizedBox(height: 40,width: 40,child: ClipOval(
               child: Image(
                 image: NetworkImage("$imageBaseUrl${follower[index].follow_by_profile_pic.toString()}")
                 ,fit: BoxFit.cover,
                 errorBuilder: (context, error, stackTrace) {
                   return Image.asset("assets/images/banner-image.png",fit: BoxFit.cover,height: 240,);
                 },
                 frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                   if(wasSynchronouslyLoaded==true) {
                     return const SizedBox(height:10,width:10,child: Center(child: CupertinoActivityIndicator(color: whiteColor,)));
                   } else {
                     return child;
                   }
                 },
               ),
             ),) ,
             title: Text(
               follower[index].follow_by_user_name.toString(),
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
       );
     }
   },),
    );
  }
}
