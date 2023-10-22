import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:nftwist/model/collection.dart';
import 'package:nftwist/provider/user.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../../constant/apiConstant.dart';
import '../../../constant/color.dart';
import '../../../constant/style.dart';
import '../../../provider/market_place_nfts.dart';
import '../../../services/locator.dart';
import '../../../services/navigation_service.dart';
import '../../../widget/appBar.dart';

import '../../../widget/home_widget/market_place.dart';
import '../../../widget/loader_screen.dart';
import 'nftDetails.dart';
class UserCollection extends StatefulWidget {
  final collection;
  const UserCollection({super.key, required this.collection,});
  static const route="user_collection";

  @override
  State<UserCollection> createState() => _UserCollectionState();
}

class _UserCollectionState extends State<UserCollection> {
   final ScrollController _scrollController = ScrollController();
   VideoPlayerController? _controller;
   late Future<void> _initializeVideoPlayerFuture;
  bool loading=false;

   void initState() {
     // TODO: implement initState
     super.initState();
        if(widget.collection.media_type=="VIDEO"){
         _controller = VideoPlayerController.networkUrl(Uri.parse("$videoBaseUrl${widget.collection.media}"));
         _initializeVideoPlayerFuture= _controller!.initialize().then((_) {
           // Ensure the video is looped.
           _controller?.setLooping(true);
           // Start playing the video.
           _controller?.play();
           setState(() {});
         });
       }
    }
   @override
   void dispose() {
     // TODO: implement dispose
     super.dispose();
     _controller?.dispose();
   }
  @override
  Widget build(BuildContext context) {
 
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: LoaderPage(
        loading: loading,
        child: Scaffold(
          body: InViewNotifierCustomScrollView(controller: _scrollController,
            isInViewPortCondition: (double deltaTop, double deltaBottom, double viewPortDimension) {
              return deltaTop < (0.5 * viewPortDimension) &&
                  deltaBottom > (0.5 * viewPortDimension);
            },
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 240,
                  child: Stack(
                    children: [
                     CachedNetworkImage(
                        imageUrl:"$imageBaseUrl${widget.collection.cover_image}",
                        height: 190,
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                        placeholder: (context, imageProvider) {
                          return const SizedBox(height:10,width:10,child: Center(child: CupertinoActivityIndicator(color: whiteColor,)));
                        },
                        errorWidget: (context, url, error) {
                          return Image.asset("assets/images/john_doe_cover.png",fit: BoxFit.cover,);
                        },
                      ),
                      const CustomAppBar(
                         toolbarHeight: 40,
                          appBarColor: Colors.transparent,
                         ),
                      Positioned(
                        bottom: 0,
                        left: 20,
                        child: Container(
                          height: 120,
                          width: 120,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFF00FFDD),
                                Color(0xFF2BCAE4),
                                Color(0xFF6383EE),
                                Color(0xFF904BF5),
                                Color(0xFFB123FA),
                                Color(0xFFC50AFE),
                                Color(0xFFCC01FF),
                              ],
                              stops: [
                                0.0,
                                0.1615,
                                0.3281,
                                0.5052,
                                0.6771,
                                0.8229,
                                1.0,
                              ],
                            ),
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(2),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                            child: widget.collection.media=="VIDEO"?_controller!=null?FutureBuilder(
                            future: _initializeVideoPlayerFuture,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const Center(
                                  child: CupertinoActivityIndicator(color: whiteColor),
                                );
                              }
                              else {
                                return VideoPlayer(_controller!);
                              }
                            },
                          ):const Center(
                        child: CupertinoActivityIndicator(color: whiteColor),
                      )

              :CachedNetworkImage(
        imageUrl:"${widget.collection.media_type=="IMAGE"?imageBaseUrl:gifBaseUrl}${widget.collection.media}",
          height: 190,
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width,
          placeholder: (context, imageProvider) {
            return const SizedBox(height:10,width:10,child: Center(child: CupertinoActivityIndicator(color: whiteColor,)));
          },
          errorWidget: (context, url, error) {
            return Image.asset("assets/images/banner-image.png",fit: BoxFit.cover,);
          },
        )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child:    Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Text(
                          "${widget.collection.name}",
                          style: w_700.copyWith(fontSize: 20),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        widget.collection.description??"",
                        style: w_400.copyWith(fontSize: 14), overflow: TextOverflow.ellipsis,maxLines: 5,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: (){
                          Clipboard.setData(ClipboardData(text: widget.collection.collection_address??''));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: blackColor,
                              borderRadius: BorderRadius.circular(100)),
                          padding: const EdgeInsets.fromLTRB(10, 6, 10, 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("${widget.collection.collection_address!.substring(0,5)}....${widget.collection.collection_address!.substring(widget.collection.collection_address!.length-5)}"),
                              const SizedBox(
                                width: 8.13,
                              ),
                              SvgPicture.asset("assets/icons/copy.svg")
                            ],
                          ),
                        ),
                      )

                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child:  Container(
                  margin: const EdgeInsets.fromLTRB(20,8,20,34),
                   padding: const EdgeInsets.symmetric(horizontal: 20),
                   height: 41,
                    decoration:     BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xff111111)),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          "Available NFTs:",
                          style: w_400.copyWith(fontSize: 12)
                      ),
                      Text(
                          "${(widget.collection.nft_count??0)>9||(widget.collection.nft_count??0)==0?widget.collection.nft_count:"0${widget.collection.nft_count}"}",
                          style: w_600.copyWith(fontSize: 14)
                      )
                    ],
                  ),
                ),
              ),
              SliverList(delegate: SliverChildBuilderDelegate((context, index) =>
                  LayoutBuilder(
                      builder: (BuildContext context, BoxConstraints constraints) {
                        return InViewNotifierWidget(
                          id: "${widget.collection.nft[index]['_id']}",
                          builder: (BuildContext context, bool isInView, Widget? child) {
                            return MarketPlace(
                              collectionName:
                              "${widget.collection.name}",wallet: true,
                              name: "${widget.collection.nft[index]['name']}",
                              // // available_nft: "${partnerNft[index].price}",
                              available_nft:
                              "${widget.collection.nft[index]['available']}/${widget.collection.nft[index]['no_of_copy']} Available",
                              // like:
                              // "${widget.collection.nft[index].likesCount}",
                              image: "${widget.collection.nft[index]['file']}",
                              id: "${widget.collection.nft[index]['_id']}",
                              media_type:
                              "${widget.collection.nft[index]['media_type']}",
                              multiple_nft:
                              widget.collection.nft[index]['type'] == 2,
                              // auction: widget.collection.nft[index]
                              //     .voucher?['auction_type'] ==
                              //     2,
                              isPaly: loading==true?false:widget.collection.nft.length==1?true:isInView,
                              onTap: ()async{
                                setState(() {
                                  loading=true;
                                });
                                await  Provider.of<Nfts>(context,listen: false).getNftDetails("${widget.collection.nft[index]['_id']}");

                                loading=await locator<NavigationService>().push(
                                    MaterialPageRoute(builder: (context) =>  const NftDetails(),settings: const RouteSettings(name: NftDetails.route)));
                                setState(() {
                                });
                              },
                            );
                          },);
                      }),childCount:widget.collection.nft==null?0:widget.collection.nft.length))

            ],
          ),
        ),
      ),
    );
  }
}
