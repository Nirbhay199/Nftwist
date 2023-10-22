import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nftwist/constant/apiConstant.dart';
import 'package:nftwist/provider/user.dart';
import 'package:nftwist/services/locator.dart';
import 'package:nftwist/services/navigation_service.dart';
import 'package:nftwist/widget/gradient_txt.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import '../../constant/color.dart';
import '../../constant/style.dart';
class MarketPlace extends StatefulWidget {
  final String  id;
  final String? collectionName;
  final String? name;
  final String? available_nft;
  final String? image;
  final String? like;
  final bool isLike;
  // final bool sendButton;
  final bool multiple_nft;
  final bool auction;
  final bool giftFeature;
  // final bool otherUser;
  final bool owner;
  final bool wallet;
  final bool isPaly;
  final bool isPrivate;
  final String? media_type;
  final void Function()? onTap;
  final void Function(String)?popupMenuButton;
  final void Function()? likeNft;
   const MarketPlace({Key? key,this.multiple_nft=false,
     this.collectionName,this.name,this.image,this.like,this.available_nft,
     this.owner=false,this.auction=false,/* this.otherUser=false,*/ this.isPrivate=false,
     this.id='64a80d38db0007c55b79eddb', this.media_type, this.isPaly=false, this.onTap,
     this.likeNft, this.isLike=false, this.giftFeature=false, this.popupMenuButton,this.wallet=false,}) : super(key: key);

  @override
  State<MarketPlace> createState() => _MarketPlaceState();
}

class _MarketPlaceState extends State<MarketPlace> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.media_type=="VIDEO"){
_controller=VideoPlayerController.networkUrl(Uri.parse("$videoBaseUrl${widget.image.toString()}"));
      _initializeVideoPlayerFuture =
          _controller.initialize().then((_) {
              setState(() {});
            });
if (widget.isPaly) {
  _controller.play();
  _controller.setLooping(true);
}    }

  }



  @override
  void didUpdateWidget(oldWidget) {
       if (oldWidget.isPaly != widget.isPaly&&widget.media_type=="VIDEO"&&oldWidget.media_type=="VIDEO") {
        if (widget.isPaly) {
          _controller.play();
          _controller.setLooping(true);
        } else {
          _controller.pause();
        }
      }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
  if(widget.media_type=="VIDEO"){
    _controller.dispose();
  }
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 20),
        height:370,
        child: Stack(
          children: [
         if(widget.multiple_nft)...[
           Positioned(
             bottom: -10.4,
             width: MediaQuery.of(context).size.width,
             child: Container(
               height: 100,
               width: MediaQuery.of(context).size.width,
               margin:const EdgeInsets.symmetric(horizontal: 24,vertical: 16),
               decoration: BoxDecoration(
                   border: Border.all(color: blackBorderColor,width: 1.5),
                   borderRadius: BorderRadius.circular(12)
               ),
             ),
           ),
           Positioned(
             bottom: -13,
             width: MediaQuery.of(context).size.width,
             child: Container(
               height: 100,
               width: MediaQuery.of(context).size.width,
               margin:const EdgeInsets.symmetric(horizontal: 26,vertical: 16),
               decoration: BoxDecoration(
                   border: Border.all(color: blackBorderColor,width: 1.5),
                   borderRadius: BorderRadius.circular(12)
               ),
             ),
           ),
           Positioned(
             bottom: -16,
             width: MediaQuery.of(context).size.width,
             child: Container(
               height: 100,
               width: MediaQuery.of(context).size.width,
               margin:const EdgeInsets.symmetric(horizontal: 28,vertical: 16),
               decoration: BoxDecoration(
                   border: Border.all(color: blackBorderColor,width: 1.5),
                   borderRadius: BorderRadius.circular(12)
               ),
             ),
           ),
           Container(
             color: appColor,
             height: 360,
             width: MediaQuery.of(context).size.width,

           ),

         ],
            Container(
              height: 370,
              margin:const EdgeInsets.symmetric(horizontal: 20,vertical: 8),
              decoration: BoxDecoration(
                  border: Border.all(color: blackBorderColor,width: 1.5),
                  borderRadius: BorderRadius.circular(12)
              ),
              child: Column(
                children: [
                  Stack(
                    children: [
                     Container(
                        height: 230,
                       width: MediaQuery.of(context).size.width,
                       decoration:widget.media_type=="VIDEO"? null:  BoxDecoration(
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(11),topRight: Radius.circular(11)),
                            image:DecorationImage(
                                image: CachedNetworkImageProvider("${widget.media_type=="IMAGE"?imageBaseUrl:gifBaseUrl}${widget.image.toString()}"),
                                fit: BoxFit.cover
                            ),
                        ),
                       child:  widget.media_type=="VIDEO"?
                       ClipRRect(borderRadius: const BorderRadius.only(topLeft: Radius.circular(11),topRight: Radius.circular(11)),
                         child: FittedBox(
                           fit: BoxFit.fitWidth,
                           child: SizedBox(
                             height: 350,
                             width: MediaQuery.of(context).size.width,
                             child: FutureBuilder(
                               future: _initializeVideoPlayerFuture,
                               builder: (context, snapshot) {
                                 if (snapshot.connectionState == ConnectionState.done) {
                                   return VideoPlayer(_controller);
                                 }
                                 else {
                                   return const Center(
                                     child: CupertinoActivityIndicator(color: whiteColor),
                                   );
                                 }
                               },
                             )
                            ),
                         ),
                       )
                           : null,
                      ),
                      if(widget.likeNft!=null)       Positioned(
                        right: 24,
                        top: 24,
                        child: Row(children: [
                          Text("${widget.like ?? 0}",style: w_600.copyWith(fontSize: 14),),
                          const SizedBox(width: 10,),
                          InkWell(
                               onTap: widget.likeNft,
                              child: SvgPicture.asset("assets/icons/${widget.isLike?"favorite.svg":"favorite_border_24px.svg"}",height: 20,width: 18.4,))
                        ],),
                      ),
                       if(!widget.isPrivate&&widget.owner) Positioned(
                          left: 16,
                          bottom: 16,
                          child: Container(width: 82,height: 23,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(4)
                            ),child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SvgPicture.asset("assets/icons/eye.svg"),
                                Text("Public",style: w_500.copyWith(fontSize: 12,color: appColor),)
                              ],
                            ),
                          )),
                      if(widget.auction==true)   Positioned(
                            right: 16,
                            bottom: 16,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 4),
                              decoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: BorderRadius.circular(4)
                              ),child:Text(widget.auction==true?"Auction Started":"${widget.available_nft}",style: w_500.copyWith(fontSize: 12,color: appColor),),
                            )),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Stack(
                      children: [
                       widget.giftFeature||widget.wallet?Container():Positioned(
                          right: -20,
                          top: 8,
                          child: PopupMenuButton<String>(
                            constraints: widget.owner==false?const BoxConstraints.expand(width: 71,height:35):null,
                            icon: const Icon(Icons.more_vert,color: whiteColor2,),color: blackColor2,
                            onSelected: widget.popupMenuButton,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            itemBuilder: (BuildContext context) {

                              return widget.owner==true?[
                                      {0:'Make Private'}, {1:'Send as Gift'},
                                    ].map((Map item) {
                              return PopupMenuItem<String>(
                              value: item.keys.first.toString(),padding: const EdgeInsets.fromLTRB(10,0,0,0),height: 28,
                              child: Text(item[item.keys.first].toString(),style: w_400.copyWith(fontSize: 14),),
                              );
                              }).toList():['Report'].map((String item) {
                              return PopupMenuItem<String>(
                              value: item,padding: const EdgeInsets.fromLTRB(10,0,0,0),height: 10,
                              child: Text(item,style: w_400.copyWith(fontSize: 14),),
                              );
                              }).toList();
                            },
                          ),
                        ),
                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16,),
                            Text(widget.collectionName??"",style: w_400.copyWith(fontSize: 14),),
                            const SizedBox(height: 8,),
                            SizedBox(
                                width: 264,
                                child: Text(widget.name??"",style:w_700.copyWith(fontSize: 14),)),
                            const SizedBox(height: 16,),
                            Row(
                              children: [
                                // Image.asset("assets/images/image 20.png"),
                                // const SizedBox(width: 6),
                                // Text("${widget.price} BNB",style: w_600.copyWith(fontSize: 14),),
                                Text("${widget.available_nft}",style: w_600.copyWith(fontSize: 14),),
                                const Spacer(),
                                if(widget.onTap!=null)     InkWell(
                                    onTap: widget.onTap??(){
                                      // locator<NavigationService>().push(
                                      //     MaterialPageRoute(builder: (context) =>  NftDetails(
                                      //     id: widget.id,),settings: const RouteSettings(name: NftDetails.route)));
                                    },
                                    child:  GradientTxt(txt:widget.giftFeature ?  "Gift NFT":"View NFT",style: w_700.copyWith(fontSize: 14),) )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
  }
}
