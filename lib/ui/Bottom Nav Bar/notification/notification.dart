import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nftwist/constant/apiConstant.dart';
import 'package:nftwist/constant/color.dart';
import 'package:nftwist/provider/user.dart';
import 'package:nftwist/widget/appBar.dart';
import 'package:nftwist/widget/loader_screen.dart';
import 'package:nftwist/widget/nft_list_tile.dart';
import 'package:provider/provider.dart';

import '../../../constant/style.dart';
import '../../../provider/market_place_nfts.dart';
import '../../../services/locator.dart';
import '../../../services/navigation_service.dart';
import '../search/nftDetails.dart';
class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  bool loading=false;
  @override
  Widget build(BuildContext context) {
    var future=Provider.of<User>(context,listen: false).getNotification();
    var notification=Provider.of<User>(context,listen: false).notification;
    return Scaffold(
      appBar: const CustomAppBar(title: "Notifications",isBackButton: false),
      body: LoaderPage(
        loading: loading,
        child: FutureBuilder(future: future, builder: (context, snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(color: whiteColor,),);
          }else if(notification.isEmpty){
            return const Center( child: Text("No Notification Yet"),);
          } else{
            return ListView.separated(
              padding: EdgeInsets.zero,
              separatorBuilder: (context, index) => const Divider(color: blackBorderColor,),
              itemCount:notification.length ,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.fromLTRB(20, 0,20,10),
                child: notification[index].type=="GIFT_NFT"||notification[index].type=="GIFT_COUPON"?
                InkWell(
                  onTap: () async {
                    if(notification[index].type=="GIFT_NFT"){
                      setState(() {
                        loading=true;
                      });
                      await  Provider.of<Nfts>(context,listen: false).getNftDetails(notification[index].nftId.id);

                      loading=await locator<NavigationService>().push(
                          MaterialPageRoute(builder: (context) =>  const NftDetails(),settings: const RouteSettings(name: NftDetails.route)));
                      setState(() {
                      });
                    }
                  },
                  child: Column(crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ActivityNFTs(image: notification[index].nftId.file,mediaType: notification[index].nftId.mediaType),
                            const SizedBox(width: 12,),
                            Padding(
                              padding: const EdgeInsets.only(top:3.0),
                              child: Column(crossAxisAlignment:CrossAxisAlignment.start,children: [
                                Row(
                                  children: [
                                    SizedBox(width: 240,child: Text("Congrats! You got a free ${notification[index].nftId.name} NFT.",style: w_600.copyWith(fontSize: 16),)),
                                     ],
                                ),
                                const SizedBox(width: 4,),
                                SizedBox(width: 240,
                                  child: Text(notification[index].message??'',style: w_400.copyWith(
                                      fontSize: 12
                                  ),),
                                ),
                              ]),
                            ),
                          ]),
                      Text(
                        "${DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(int.parse(notification[index].createdAt))).inSeconds<60?
                        "${DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(int.parse(notification[index].createdAt))).inSeconds.abs()} ${DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(int.parse(notification[index].createdAt))).inSeconds.abs()==1?"sec":"secs"}":
                        DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(int.parse(notification[index].createdAt))).inMinutes<60?
                        "${DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(int.parse(notification[index].createdAt))).inMinutes.abs()} ${DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(int.parse(notification[index].createdAt))).inMinutes.abs()==1?"mint":"mints"}":
                        DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(int.parse(notification[index].createdAt))).inHours<24?
                        "${DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(int.parse(notification[index].createdAt))).inHours.abs()} ${DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(int.parse(notification[index].createdAt))).inHours.abs()==1?"hour":"hours"}":
                        "${DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(int.parse(notification[index].createdAt))).inDays.abs()} ${DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(int.parse(notification[index].createdAt))).inDays.abs()==1?"day":"days"}"
                        } ago",
                        style: w_400.copyWith(fontSize: 10),
                      ),
                    ],
                  ),
                )
                    :/*notification[index].type=="PARTNER_GIFT"?*/
                Column(crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ActivityNFTs(image: notification[index].nftId.file,mediaType: notification[index].nftId.mediaType),
                          const SizedBox(width: 12,),
                          Padding(
                            padding: const EdgeInsets.only(top: 3.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        notification[index].nftId.name ,
                                        style: w_600.copyWith(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Row(
                                    children: [
                                      if(notification[index].type!="PARTNER_NOTIFICATION")...[
                                        Text(
                                          "1 copy is gifted form",
                                          style: w_400.copyWith(fontSize: 12),
                                        ),
                                        const SizedBox(
                                        width: 5,
                                      ),  CircleAvatar(
                                        radius: 10,backgroundImage: const AssetImage("assets/images/banner-image.png",),
                                        foregroundImage: CachedNetworkImageProvider(
                                            "$imageBaseUrl${notification[index].sentBy?.profilePic}"),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ), Text(
                                        "${notification[index].sentBy?.userName}",
                                        style: w_600.copyWith(fontSize: 12),
                                        overflow: TextOverflow.ellipsis,
                                      ),]else...[
                                        Text(
                                          "1 copy is gifted to",
                                          style: w_400.copyWith(fontSize: 12),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),  CircleAvatar(
                                          radius: 10,backgroundImage: const AssetImage("assets/images/banner-image.png",),
                                          foregroundImage: CachedNetworkImageProvider(
                                              "$imageBaseUrl${notification[index].sentTo.profilePic}"),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ), Text(
                                          notification[index].sentTo.userName,
                                          style: w_600.copyWith(fontSize: 12),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ]
                                    ],
                                  ),
                                ]),
                          ),

                        ]),
                    Text(
                      "${DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(int.parse(notification[index].createdAt))).inSeconds<60?
                      "${DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(int.parse(notification[index].createdAt))).inSeconds.abs()} ${DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(int.parse(notification[index].createdAt))).inSeconds.abs()==1?"sec":"secs"}":
                      DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(int.parse(notification[index].createdAt))).inMinutes<60?
                      "${DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(int.parse(notification[index].createdAt))).inMinutes.abs()} ${DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(int.parse(notification[index].createdAt))).inMinutes.abs()==1?"mint":"mints"}":
                      DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(int.parse(notification[index].createdAt))).inHours<24?
                      "${DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(int.parse(notification[index].createdAt))).inHours.abs()} ${DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(int.parse(notification[index].createdAt))).inHours.abs()==1?"hour":"hours"}":
                      "${DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(int.parse(notification[index].createdAt))).inDays.abs()} ${DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(int.parse(notification[index].createdAt))).inDays.abs()==1?"day":"days"}"
                      } ago",
                      style: w_400.copyWith(fontSize: 10),
                    ),
                  ],
                ),
              ),
            );
          }
        },),
      )
    );
  }
}
