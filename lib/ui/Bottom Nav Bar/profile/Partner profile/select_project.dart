import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nftwist/constant/apiConstant.dart';
import 'package:nftwist/constant/style.dart';
import 'package:nftwist/provider/user.dart';
import 'package:nftwist/services/locator.dart';
import 'package:nftwist/services/navigation_service.dart';
import 'package:nftwist/widget/appBar.dart';
import 'package:provider/provider.dart';

import '../../../../constant/color.dart';
import '../../../../widget/home_widget/market_place.dart';
class MyProjects extends StatelessWidget {
  const MyProjects({Key? key}) : super(key: key);
static const route ='my_projects';
  @override
  Widget build(BuildContext context) {
    var userCollection=Provider.of<User>(context).userCollection;
    return Scaffold(
      appBar: const CustomAppBar(title: "Select Project"),
      body:  ListView.builder(
        padding: EdgeInsets.zero,
         itemCount: userCollection.length,
        itemBuilder: (context, index) =>   InkWell(
          onTap: ()async{
            final id=await showCupertinoModalPopup(
               context: context, builder: (context) {
              return Scaffold(
                  appBar: const CustomAppBar(title: "Select NFT"),
                body: ListView.builder(
                  itemCount:userCollection[index].nft==null?0: userCollection[index].nft.length,
                  itemBuilder: (context, ind) {
                  return MarketPlace(owner: false,
                    giftFeature: true,
                    collectionName: userCollection[index].nft[ind]['name'],
                    image: userCollection[index].nft[ind]['file'],
                    media_type: userCollection[index].nft[ind]['media_type'],
                    available_nft:
                    "${userCollection[index].nft[ind]['available']}/${userCollection[index].nft[ind]['no_of_copy']} Available",
onTap: () {
  locator<NavigationService>().goBack(data:userCollection[index].nft[ind]['_id'] );
},
// name: userCollection[index].nft[ind]['description'],
                  );
                },),
              );
               },);
            Provider.of<User>(context,listen: false).setGiftNftId(id);
            locator<NavigationService>().goBack();
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
                border: Border.all(color: blackBorderColor),
                borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Column(
              children: [
                Container(height: 141,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  // decoration: BoxDecoration(
                  //     image:   DecorationImage(
                  //         image: CachedNetworkImageProvider("${userCollection[index].media}"),
                  //         onError: (exception, stackTrace) => Image.asset("assets/images/john_doe_cover.png",fit: BoxFit.cover,),
                  //         fit: BoxFit.cover
                  //     ),
                  //     borderRadius: BorderRadius.circular(12)
                  // ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(imageUrl: "${userCollection[index].media_type=="IMAGE"?imageBaseUrl:gifBaseUrl}${userCollection[index].media}",
                          fit: BoxFit.cover,
                        placeholder: (context, imageProvider) {
                          return const SizedBox(height:10,width:10,child: Center(child: CupertinoActivityIndicator(color: whiteColor,)));
                        },
                        errorWidget: (context, url, error) {
                         return Image.asset("assets/images/john_doe_cover.png",fit: BoxFit.cover,);
                        },
                      )),
                ),
                const SizedBox(height: 10,),
                Text("${userCollection[index].name}",style: w_700.copyWith(fontSize: 14),),
                const SizedBox(height: 8,),
                Text("${userCollection[index].total_available_nfts}/${userCollection[index].total_nfts} available",style: w_400.copyWith(fontSize: 14),)
              ],
            ),
          ),
        ),),
    );
  }
}
