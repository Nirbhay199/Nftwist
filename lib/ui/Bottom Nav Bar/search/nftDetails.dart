import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nftwist/constant/apiConstant.dart';
import 'package:nftwist/constant/style.dart';
import 'package:nftwist/provider/user.dart';
import 'package:nftwist/services/locator.dart';
import 'package:nftwist/services/navigation_service.dart';
import 'package:nftwist/ui/Bottom%20Nav%20Bar/search/qr_code.dart';
import 'package:nftwist/widget/appBar.dart';
import 'package:nftwist/widget/button.dart';
import 'package:nftwist/widget/gradient_txt.dart';
import 'package:nftwist/widget/gust_login_alert.dart';
import 'package:nftwist/widget/loader_screen.dart';
import 'package:nftwist/widget/textfiels/textfield.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../constant/color.dart';
import '../../../provider/market_place_nfts.dart';
import '../../../provider/other_profile.dart';

class NftDetails extends StatefulWidget {
  const NftDetails(
      {Key? key,})
      : super(key: key);
  static const route = 'nft-details';

  @override
  State<NftDetails> createState() => _NftDetailsState();
}

class _NftDetailsState extends State<NftDetails> {
  int currentIndex = 0;
  VideoPlayerController? _controller;
  late Future<void> _initializeVideoPlayerFuture;
  VideoPlayerController? _controllercollection;
  late Future<void> _initializeVideoPlayerFuturecollection;
  late Timer _timer;
  bool loading=false;
  Stream<int>? _stream;
  late int _secondsRemaining;

  final ScrollController controller=ScrollController();
  final FocusNode focusNode=FocusNode();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNode.addListener(() {
      if(focusNode.hasFocus){
       Future.delayed(const Duration(milliseconds:350)).then((value) =>  controller.animateTo(controller.position.maxScrollExtent, duration: const Duration(milliseconds: 400), curve:  Curves.linear));
      }
    });
    Future.delayed(Duration.zero).then((value)  {
  var nft=Provider.of<Nfts>(context,listen: false).nftDetail;
  if(nft.media_type=="VIDEO"){
        _controller = VideoPlayerController.networkUrl(Uri.parse("$videoBaseUrl${nft.file}"));
        _initializeVideoPlayerFuture= _controller!.initialize().then((_) {
            // Ensure the video is looped.
            _controller?.setLooping(true);
            // Start playing the video.
            _controller?.play();
            setState(() {});
          });
      }
  if(nft.collection_id?.media_type=="VIDEO"){
        _controllercollection = VideoPlayerController.networkUrl(Uri.parse("$videoBaseUrl${nft.collection_id!.media}"));
        _initializeVideoPlayerFuturecollection= _controllercollection!.initialize().then((_) {
            // Ensure the video is looped.
            // _controllercollection?.setLooping(true);
            // Start playing the video.
            // _controllercollection?.play();
            setState(() {});
          });
      }
if(nft.auction_type==2){
  Duration? auctionEnd= nft.voucher?.endTime!=null?DateTime.fromMillisecondsSinceEpoch(nft.voucher!.endTime!,isUtc: true).difference(DateTime.now().toUtc()):null;
  if(auctionEnd!=null&&auctionEnd.inMilliseconds>0){
    _secondsRemaining = auctionEnd.inSeconds;
    _stream = Stream.periodic(const Duration(seconds: 1), (i) => _secondsRemaining - i - 1)
        .takeWhile((count) => count >= 0);
    _timer = Timer(auctionEnd, () {
      // This function will be executed after Subscription end
    });
    setState(() {
    });
  }else{

  }
}
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller?.dispose();
    _controllercollection?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var nftDetails=Provider.of<Nfts>(context).nftDetail;
    var user=Provider.of<User>(context).user;
    TextEditingController _txt=TextEditingController();
    return DefaultTabController(
      length:nftDetails.auction_type==2?3:nftDetails.type==2?2:1,
      initialIndex: 0,
      child: WillPopScope(
        onWillPop: () async{
          locator<NavigationService>().goBack(data: false);
          return true;
        },
        child: RefreshIndicator(
          onRefresh: () async=>{
            Provider.of<Nfts>(context,listen: false).getNftDetails(nftDetails.id,refresh: true)
          } ,
          child: LoaderPage(
            loading: loading,
            child: Scaffold(
              extendBodyBehindAppBar: true,
              bottomNavigationBar: Padding(
                 padding:   EdgeInsets.only(bottom :MediaQuery.of(context).viewInsets.bottom,top: 10),
                 child: Column(mainAxisSize: MainAxisSize.min,
                  children: [
       if(currentIndex==0)TextFieldForm(
                        hintText: "Write comment here...",
                        tfController: _txt,
                        focusNode: focusNode,
                        postfix: IconButton(
                            onPressed:   (){
    if(user==null){
    alert(context);
    }else {
      if (_txt.text.trim() == '') {} else {
        Provider.of<Nfts>(context, listen: false).addComments(
            _txt.text, nftDetails.id, user?.first_name, user?.last_name,
            user?.profile_pic, user?.wallet_address);
        _txt.clear();
      }
    }  },
                            icon: const Icon(
                              Icons.send,
                              color: whiteColor,
                            )),
                        onFieldSubmitted: (_){
    if(user==null){
    alert(context);
    }else {
      if (_ == '') {} else {
        Provider.of<Nfts>(context, listen: false).addComments(
            _, nftDetails.id, user?.first_name, user?.last_name,
            user?.profile_pic, user?.wallet_address);
      }
    }   },

       ),
                    Container(
                      height: 102,
                      color: blackColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: (){
                              if(user==null){
                                alert(context);
                              }else{
                              Provider.of<Nfts>(context,listen: false).likeNft(nftDetails.id,isDetails: true);}
                            },
                            child: Container(
                              width: 81,
                              height: 52,
                              margin: const EdgeInsets.only(left: 20),
                              decoration: BoxDecoration(
                                border: Border.all(color: whiteBorderColor, width: 2),
                                borderRadius: BorderRadius.circular(38),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset("assets/icons/${nftDetails.is_liked==true?"favorite.svg":"favorite_border_24px.svg"}"),
                                  const SizedBox(width: 5),
                                  Text(
                                    nftDetails.nft_like_count.toString(),
                                    style: w_600.copyWith(fontSize: 16),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                              child:
                                  Button(buttonTxt: /*widget.send?"Send NFT":*/"View on nftwist.io", function: () {
                                    launchUrl(Uri.parse("$WebLink/nft-details/${nftDetails.id}"),mode: LaunchMode.externalApplication);
                                  },icon: SvgPicture.asset("assets/icons/card_giftcard_24px.svg"),))
                        ],
                      ),
                    ),
                  ],
              ),
               ),
              body: ListView(
                padding: EdgeInsets.zero,
                controller: controller,
                children: [
                  Container(
                    color: appColor,
                    height: nftDetails.user_id!.userType==2 ||nftDetails.auction_type==2 ? 320 : null,
                    child: Stack(
                      children: [
                        nftDetails.media_type=="VIDEO"?
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: SizedBox(
                            height: nftDetails.user_id!.userType==2 ||nftDetails.auction_type==2 ? 320 : null,
                            width: MediaQuery.of(context).size.width,
                            child:_controller!=null?FutureBuilder(
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
                            ),
                          ),
                        )
                            :CachedNetworkImage(
                          imageUrl:"${nftDetails.media_type=="IMAGE"?imageBaseUrl:gifBaseUrl}${nftDetails.file.toString()}",
                          height: 350,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          errorWidget: (context, url, error) {
                            return Image.asset("assets/images/john_doe_cover.png",fit: BoxFit.cover,);
                          },placeholder: (context, imageProvider) {
                          return const SizedBox(height:10,width:10,child: Center(child: CupertinoActivityIndicator(color: whiteColor,)));
                        },
                        ),
                        CustomAppBar(toolbarHeight: 50,
                            isBackButton: true,
                            appBarColor: Colors.transparent,data: false,
                            action: [
                              IconButton(
                                  onPressed: () {},
                                  icon: Container(
                                    height: 24,
                                    width: 24,
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
                                    child: const Icon(Icons.share,
                                        size: 12.6, color: whiteColor),
                                  ))
                            ]),
                        if ((nftDetails.type==2||nftDetails.type==1)&&nftDetails.auction_type==1)
                          Positioned(
                            bottom: 20,
                            right: 20,
                            child: TextButton(
                                onPressed: () async{

      if (nftDetails.media_type == "VIDEO") _controller?.pause();
      var a = await locator<NavigationService>().push(
          MaterialPageRoute(builder: (context) =>
              QRCode(nftQr: true,
                qrString: "details-${nftDetails.id}-/ownerID${nftDetails.creator
                    ?.id}",
                image: nftDetails.file /*,price: nftDetails.price*/,
                NFTname: nftDetails
                    .name, /*dollarValue: nftDetails.dollar_value,*/
                mediaType: nftDetails.media_type,
              ), settings: const RouteSettings(name: QRCode.route)));
      if (a != null) {
        if (nftDetails.media_type == "VIDEO") _controller?.play();
      }
},
                                style: TextButton.styleFrom(
                                  maximumSize: const Size(169, 50),
                                  backgroundColor: whiteColor2,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset("assets/icons/qr-code.svg"),
                                    const SizedBox(
                                      width: 6.13,
                                    ),
                                    Text(
                                      "Show QR Code",
                                      style: w_600.copyWith(
                                          fontSize: 14, color: appColor),
                                    )
                                  ],
                                )),
                          ),
                        if(nftDetails.auction_type==2)...[
                          Positioned(
                              top: 310,
                              left: 100,
                              right: 100,
                              child: Container(
                                constraints: const BoxConstraints(
                                    minWidth: 209, minHeight: 81),
                                decoration: BoxDecoration(
                                  color: blackColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Auction ends in",
                                          style: w_400.copyWith(fontSize: 14),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    StreamBuilder<int>(
                                      stream: _stream,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          final seconds = snapshot.data!;
                                          final day = (seconds / 86400).round();
                                          final hours = seconds ~/ 3600;
                                          final minutes = (seconds % 3600) ~/ 60;
                                          final remainingSeconds = seconds % 60;
                                          final hoursString = hours.toString();
                                          final minutesString = minutes.toString() ;
                                          final secondsString = remainingSeconds.toString();
                                          return Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Column(
                                                children: [
                                                  Text(
                                                    day.toString(),
                                                    style: w_600.copyWith(fontSize: 14),
                                                  ),
                                                  Text(
                                                    "days",
                                                    style: w_400.copyWith(fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                width: 16,
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    hoursString,
                                                    style: w_600.copyWith(fontSize: 14),
                                                  ),
                                                  Text(
                                                    "hours",
                                                    style: w_400.copyWith(fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                width: 16,
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    minutesString,
                                                    style: w_600.copyWith(fontSize: 14),
                                                  ),
                                                  Text(
                                                    "mins",
                                                    style: w_400.copyWith(fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                width: 16,
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    secondsString,
                                                    style: w_600.copyWith(fontSize: 14),
                                                  ),
                                                  Text(
                                                    "sec",
                                                    style: w_400.copyWith(fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          );
                                        } else {
                                          return const Text('Loading...',);
                                        }
                                      },
                                    )
                                  ],
                                ),
                              )),
                          Positioned(
                              bottom: 60,
                              right: 20,
                              child: IconButton(
                                onPressed: () async {
    if(user==null){
    alert(context);
    }else {
      if (nftDetails.media_type == "VIDEO") _controller?.pause();
      var a = await locator<NavigationService>().push(
          MaterialPageRoute(builder: (context) =>
              QRCode(nftQr: true,
                qrString: "details-${nftDetails.id}-/ownerID${nftDetails.creator
                    ?.id}",
                image: nftDetails.file, /*price: nftDetails.price,*/
                NFTname: nftDetails
                    .name, /*dollarValue: nftDetails.dollar_value,*/
                mediaType: nftDetails.media_type,
              ), settings: const RouteSettings(name: QRCode.route)));
      if (a != null) {
        if (nftDetails.media_type == "VIDEO") _controller?.play();
      }
    }     },
                                icon: CircleAvatar(
                                    backgroundColor: whiteColor,
                                    child: SvgPicture.asset(
                                      "assets/icons/qr-code.svg",
                                      height: 12.6,
                                      width: 12.6,
                                    )),
                              )),
                        ]
                      ],
                    ),
                  ),
                  Container(
                    color: appColor,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20.0, 20, 20, 8),
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          nftDetails.name,
                                          style: w_700.copyWith(fontSize: 18),
                                        ),
                                        if(nftDetails.type==2)Text(
                                          "${nftDetails.available}/${nftDetails.no_of_copy} available",
                                          style: w_400.copyWith(fontSize: 12),
                                        ),
                                       /* if(nftDetails.user_id!.userType==2)Text(
                                          "NFT Name #0001",
                                          style: w_400.copyWith(fontSize: 12),
                                        ),*/
                                      ],
                                    ),
                           /*     Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        if(nftDetails.user_id!.userType==1||nftDetails.auction_type!=2)
                                          Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(
                                                    0, 0, 4, 10),
                                                child: Image.asset(
                                                  "assets/icons/Ellipse.png",
                                                  height: 17,
                                                  width: 17,
                                                ),
                                              ),
                                            ],
                                          ),
                                        if(nftDetails.auction_type!=2)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${nftDetails.price??0} MATIC",
                                                style: w_600.copyWith(fontSize: 14,color: whiteColor),
                                              ),
                                              Text(
                                                "${(nftDetails.price??0*double.parse(nftDetails.dollar_value)).toStringAsFixed(6)} USD",
                                                style: w_400.copyWith(fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        if(nftDetails.auction_type==2)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Highest bid",
                                                style: w_400.copyWith(fontSize: 12),
                                              ),
                                              Text(
                                                "0.0004 MATIC",
                                                style: w_600.copyWith(fontSize: 14,color: whiteColor),
                                              ),
                                            ],
                                          ),
                                      ],
                                    )*/
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  nftDetails.description,
                                  style: w_400.copyWith(fontSize: 14), overflow: TextOverflow.ellipsis,maxLines: 5,
                                ),
                                Row(
                                  children: [
                                if(nftDetails.type==1||nftDetails.auction_type==2) ...[
                                      Expanded(
                                        child: InkWell(
                                          onTap: () async {
                                            setState(() {
                                              loading=true;
                                            });
                                            loading=await  Provider.of<OtherUserProfile>(context,listen: false).getOtherUserProfile(id: nftDetails.current_owner?.id,user_id:user?.id);
                                            setState(() {
                                              print("After---$loading");
                                            });
                                          },
                                          child: Container(
                                            height: 68,
                                            margin: const EdgeInsets.only(
                                                top: 16, bottom: 5),
                                            padding: const EdgeInsets.fromLTRB(19,8,5,8),

                                            decoration: BoxDecoration(
                                              color: blackColor,
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                    CircleAvatar(
                                                    foregroundImage: CachedNetworkImageProvider("$imageBaseUrl${nftDetails.current_owner?.cover_image}"),
                                                  ),
                                                  const SizedBox(
                                                    width: 8,
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                      children: [
                                                        SizedBox(width: 88,
                                                          child: Text(
                                                            nftDetails.auction_type == 2
                                                                ? "Highest bid by"
                                                                : "Owner",
                                                            style: w_400.copyWith(
                                                                fontSize: 14),
                                                          ),
                                                        ),
                                                        SizedBox(width: 88,
                                                          child: Text(
                                                              nftDetails.auction_type== 2
                                                                  ? "0x45489111"
                                                                  : nftDetails.current_owner!.user_name,
                                                              style: w_600.copyWith(color: whiteColor,
                                                                  fontSize: 13),overflow: TextOverflow.ellipsis),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ]),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                    ],
                                    Expanded(
                                      child: InkWell(
                                        onTap: () async {

      setState(() {
        loading = true;
      });
      loading = await Provider.of<OtherUserProfile>(context, listen: false)
          .getOtherUserProfile(id: nftDetails.creator?.id, user_id: user?.id);
      setState(() {
        print("After---$loading");
      });
        },
                                        child: Container(
                                          height: 68,
                                          margin:
                                              const EdgeInsets.only(top: 16, bottom: 5),
                                          padding: const EdgeInsets.fromLTRB(19,9,5,9),
                                          decoration: BoxDecoration(
                                            color: blackColor,
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Row(
                                              // mainAxisAlignment: MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                CircleAvatar(
                                                  backgroundImage: const AssetImage("assets/images/banner-image.png"),
                                                  foregroundImage: CachedNetworkImageProvider("$imageBaseUrl${nftDetails.creator?.cover_image}"),
                                                ),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Creator",
                                                      style:
                                                          w_400.copyWith(fontSize: 14),
                                                    ),
                                                SizedBox(width: 88,  child:      Text(nftDetails.creator!.user_name,
                                                        style: w_600.copyWith(color: whiteColor,
                                                            fontSize: 14),overflow: TextOverflow.ellipsis,),),
                                                    if(nftDetails.user_id!.userType==2) GradientTxt(
                                                        txt: "Royalities: ${nftDetails.royalty}%",
                                                        style: w_500.copyWith(
                                                            fontSize: 12))
                                                  ],
                                                )
                                              ]),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                InkWell(
                                  onTap: (){
                                  },
                                  child: Container(
                                    height: 68,
                                    margin: const EdgeInsets.only(top: 0, bottom: 5),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 9, horizontal: 19),
                                    decoration: BoxDecoration(
                                      color: blackColor,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                        // mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          nftDetails.collection_id?.media_type=="VIDEO"?
                                          FittedBox(
                                            fit: BoxFit.fitWidth,
                                            child: Container(
                                              height: 20,
                                              width: 20,
                                              decoration: const BoxDecoration(shape: BoxShape.circle),
                                              child:_controllercollection!=null?FutureBuilder(
                                                future: _initializeVideoPlayerFuturecollection,
                                                builder: (context, snapshot) {
                                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                                    return const Center(
                                                      child: CupertinoActivityIndicator(color: whiteColor),
                                                    );
                                                  } else {
                                                    return VideoPlayer(_controllercollection!);
                                                  }
                                                },
                                              ):null,
                                            ),
                                          )
                                              : CircleAvatar(
                                            foregroundImage: CachedNetworkImageProvider("${nftDetails.collection_id?.media_type=="IMAGE"?imageBaseUrl:gifBaseUrl}${nftDetails.collection_id?.media}",),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Collection",
                                                style: w_400.copyWith(fontSize: 14),
                                              ),
                                              Text(nftDetails.collection_id!.name/*==1?"Nftwist721 Collection":"Nftwist1155 Collection"*/,
                                                  style: w_600.copyWith(fontSize: 14,color: whiteColor)),
                                            ],
                                          )
                                        ]),
                                  ),
                                ),
                                const SizedBox(height: 8,)
                              ],
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Material(
                              color: blackColor,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: TabBar(
                                    dividerColor: Colors.transparent,
                                    indicatorColor: whiteColor,
                                    indicatorWeight: 1,
                                    indicatorSize: TabBarIndicatorSize.label,
                                    labelStyle: w_500.copyWith(
                                      fontSize: 14,
                                    ),
                                    labelColor: whiteColor2,
                                    unselectedLabelColor: whiteColor2,
                                    splashFactory: NoSplash.splashFactory,
                                    isScrollable: true,
                                    onTap: (tabIndex) {
                                      setState(() {
                                        currentIndex = tabIndex;
                                      });
                                    },
                                    labelPadding:
                                        const EdgeInsets.only(left: 10, right: 10),
                                    tabs: nftDetails.auction_type==1
                                        ? [
                                          SizedBox(
                                              height: 33,
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Text("Comments (${nftDetails.comments.length})"),
                                              ),
                                            ),
                                            if (nftDetails.type==2)
                                                const SizedBox(
                                                height: 33,
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text("Owners"),
                                                ),
                                              ),
                                      // if (nftDetails.user_id!.userType==2)
                                      //         const SizedBox(
                                      //           height: 33,
                                      //           child: Align(
                                      //             alignment: Alignment.center,
                                      //             child: Text("Other Sellers"),
                                      //           ),
                                      //         ),
                                          ]
                                        : const [
                                            SizedBox(
                                              height: 33,
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Text("Bids"),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 33,
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Text("Details"),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 33,
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Text("History"),
                                              ),
                                            ),
                                          ]),
                              ),
                            ),
                          ),
                          if (nftDetails.auction_type==1) ...[
                            if (currentIndex == 0) ...[
    ...nftDetails.comments.map<Widget>((e) =>                         Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 20, 20, 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children:   [
                    CircleAvatar(
                      backgroundImage: const AssetImage("assets/images/banner-image.png"),
                      foregroundImage: CachedNetworkImageProvider("$imageBaseUrl${e['profile_pic']}"),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${e['first_name']} ${e['last_name']}",
                              style: w_600.copyWith(fontSize: 14),
                            ),
                            Text(
                             "${DateTime.now().difference(DateTime.parse(e['created_at'])).inSeconds<60? "${DateTime.now().difference(DateTime.parse(e['created_at'])).inSeconds.abs()} sec":
                               DateTime.now().difference(DateTime.parse(e['created_at'])).inMinutes<60? "${DateTime.now().difference(DateTime.parse(e['created_at'])).inMinutes.abs()} mint":
                               DateTime.now().difference(DateTime.parse(e['created_at'])).inHours<24? "${DateTime.now().difference(DateTime.parse(e['created_at'])).inHours.abs()} hours":
                               "${DateTime.now().difference(DateTime.parse(e['created_at'])).inDays.abs()} days"} ago",
                              style: w_400.copyWith(fontSize: 12),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "${e['comment']}",
                          style: w_400.copyWith(fontSize: 12),
                        ),
                      ],
                    ))
              ],
            ),
    ),
    ).toList(),
                              const Divider(
                                thickness: 2,
                                color: blackColor2,
                              ),

                              const SizedBox(height: 5,),
                            ],
                            if(currentIndex==1) ...nftDetails.owners.map<Widget>((e) => ListTile(
                                leading:   CircleAvatar(
                                  backgroundImage: const AssetImage("assets/images/banner-image.png"),
                                  radius: 19,
                                  foregroundImage: CachedNetworkImageProvider('$imageBaseUrl${e['owner_id']['profile_pic']}'),
                                ),
                                trailing: nftDetails.user_id!.userType==2?null:Column(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(9.0),
                                    child: GradientTxt(
                                      txt: "Buy",
                                      style: w_600.copyWith(fontSize: 12),
                                    ),
                                  )
                                ]),
                                title: Text(
                                  e['owner_id']['user_name'].toString(),
                                  style: w_600.copyWith(fontSize: 14),
                                ),
                                subtitle: Text(
                                    "${e['available']}/${e['no_of_copy']} copies are available",
                                    style: w_400.copyWith(fontSize: 12))),).toList(),
                          ] else ...[
                            if (currentIndex == 0)
                              ListView.separated(
                                shrinkWrap: true,
                                padding: const EdgeInsets.symmetric(vertical: 20),
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: 3,
                                itemBuilder: (context, index) => ListTile(
                                    leading: const CircleAvatar(
                                      radius: 19,
                                      foregroundImage: NetworkImage(
                                          "https://images.unsplash.com/photo-1554151228-14d9def656e4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=686&q=80"),
                                    ),
                                    trailing: Column(children: [
                                      Text(
                                        "10 hours ago",
                                        style: w_400.copyWith(fontSize: 12),
                                      )
                                    ]),
// contentPadding: Ed,
                                    title: Text(
                                      "0.2 WETH",
                                      style: w_600.copyWith(fontSize: 14),
                                    ),
                                    subtitle: RichText(
                                      text: TextSpan(
                                          text: "by ",
                                          style: w_400.copyWith(fontSize: 12),
                                          children: [
                                            TextSpan(
                                                text: "William",
                                                style: w_500.copyWith(fontSize: 12)),
                                          ]),
                                    )),
                                separatorBuilder: (BuildContext context, int index) =>
                                    const Divider(height: 0,
                                  color: blackBorderColor,
                                ),
                              )
                            else if (currentIndex == 1)
                              GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2, childAspectRatio: 9 / 6),
                                itemBuilder: (context, index) => Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 16),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: blackBorderColor),
                                      borderRadius: BorderRadius.circular(12)),
                                  // padding: const EdgeInsets.symmetric(vertical: 28),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GradientTxt(
                                        txt: 'Property 1',
                                        style: w_400.copyWith(fontSize: 12),
                                      ),
                                      Text(
                                        "Lorem Ipsum",
                                        style: w_600.copyWith(fontSize: 14),
                                      ),
                                      Text(
                                        "3.9% rarity",
                                        style: w_400.copyWith(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                                itemCount: 2,
                              )
                            else
                              ListView.separated(
                                shrinkWrap: true,
                                padding: const EdgeInsets.symmetric(vertical: 20),
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: 3,
                                itemBuilder: (context, index) => ListTile(
                                    leading: const CircleAvatar(
                                      radius: 19,
                                      foregroundImage: NetworkImage(
                                          "https://images.unsplash.com/photo-1554151228-14d9def656e4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=686&q=80"),
                                    ),
                                    trailing: Column(children: [
                                      Text(
                                        "10 hours ago",
                                        style: w_400.copyWith(fontSize: 12),
                                      )
                                    ]),
// contentPadding: Ed,
                                    title: Text(
                                      "0.2 WETH",
                                      style: w_600.copyWith(fontSize: 14),
                                    ),
                                    subtitle: RichText(
                                      text: TextSpan(
                                          text: "by ",
                                          style: w_400.copyWith(fontSize: 12),
                                          children: [
                                            TextSpan(
                                                text: "William",
                                                style: w_500.copyWith(fontSize: 12)),
                                          ]),
                                    )),
                                separatorBuilder: (BuildContext context, int index) =>
                                    const Divider(height: 0,
                                  color: blackBorderColor,
                                ),
                              )
                          ]
                        ]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
