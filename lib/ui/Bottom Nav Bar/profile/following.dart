import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nftwist/constant/apiConstant.dart';
import 'package:nftwist/constant/color.dart';
import 'package:nftwist/provider/user.dart';
import 'package:nftwist/widget/appBar.dart';
import 'package:provider/provider.dart';

import '../../../../../constant/style.dart';

class FollowingScreen extends StatefulWidget {
  const FollowingScreen({Key? key}) : super(key: key);
  static const route="following";

  @override
  State<FollowingScreen> createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen> {
  var future;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    future= Provider.of<User>(context,listen: false).getUserFollowing();
  }
  @override
  Widget build(BuildContext context) {
    var followings =Provider.of<User>(context).userFollowing;
    return Scaffold(
      appBar: const CustomAppBar(title: "Following"),
      body: FutureBuilder(future: future, builder: (context, snapshot) {
        if(snapshot.connectionState==ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator(color:whiteColor,),);
        }if(followings.isEmpty){
          return const Center(child: Text("No Following"),);
        }else{
          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            shrinkWrap: true,
            itemCount: followings.length+1,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return index>followings.length-1?Container():ListTile(
                horizontalTitleGap: 10,
                contentPadding: EdgeInsets.zero,
                minLeadingWidth: .8,

                // onTap: rules[index]['fun'],
                leading:SizedBox(height: 40,width: 40,child: ClipOval(
                  child: Image(image: NetworkImage("$imageBaseUrl${followings[index].follow_profile_pic.toString()}"),fit: BoxFit.cover,   errorBuilder: (context, error, stackTrace) {
                    return Image.asset("assets/images/banner-image.png",fit: BoxFit.cover,height: 240,);
                  },
                    frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                      if(wasSynchronouslyLoaded==true) {
                        return const SizedBox(height:10,width:10,child: Center(child: CupertinoActivityIndicator(color: whiteColor,)));
                      } else {
                        return child;
                      }
                    },),
                ),) ,
                title: Text(
                  followings[index].follow_user_name.toString(),
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
