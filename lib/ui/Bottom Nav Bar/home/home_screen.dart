import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:nftwist/constant/style.dart';
import 'package:nftwist/provider/homeModule.dart';
import 'package:nftwist/provider/other_profile.dart';
import 'package:nftwist/provider/partner_nft.dart';
import 'package:nftwist/provider/user.dart';
import 'package:nftwist/services/locator.dart';
import 'package:nftwist/services/navigation_service.dart';
import 'package:nftwist/ui/Bottom%20Nav%20Bar/home/become_partner.dart';
import 'package:nftwist/ui/Bottom%20Nav%20Bar/home/news_feed.dart';
import 'package:nftwist/ui/Bottom%20Nav%20Bar/home/ongoing_campaigns.dart';
import 'package:nftwist/ui/Bottom%20Nav%20Bar/home/wallet.dart';
import 'package:nftwist/ui/Bottom%20Nav%20Bar/profile/Other%20User%20Profile/otheruser_partnerprofile.dart';
import 'package:nftwist/widget/button.dart';
import 'package:nftwist/widget/gradient_txt.dart';
import 'package:nftwist/widget/home_widget/market_place.dart';
import 'package:nftwist/widget/home_widget/news_feed.dart';
import 'package:nftwist/widget/home_widget/partner_widget.dart';
import 'package:nftwist/widget/loader_screen.dart';
import 'package:provider/provider.dart';

import '../../../constant/apiConstant.dart';
import '../../../constant/color.dart';
import '../../../provider/market_place_nfts.dart';
import '../../../widget/gust_login_alert.dart';
import '../bottom_nav_bar.dart';
import '../search/nftDetails.dart';

class Home extends StatefulWidget {
  final TabController tabController;
  const Home({Key? key, required this.tabController}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String focusVideoID='';
  bool loading=false;  Timer? timer;

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer = Timer.periodic(
        const Duration(minutes: 10),
            (Timer t) => Provider.of<User>(context, listen: false).getWalletValue());
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context).user;
    var homeScreenData = Provider.of<HomeModuleProvider>(context);
    var nftMarketPlace = Provider.of<Nfts>(context);
    var partnerNft = Provider.of<Nfts>(context).partnerNFTs;
    return RefreshIndicator(
      onRefresh: () async {
        Provider.of<HomeModuleProvider>(context,listen: false).getHomeScreenDate(context);
    },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: blackColor,
          centerTitle: false,
          leading: Container(),
          toolbarHeight: 90,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(bottom: 22.0, left: 20, right: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     SizedBox(width: 200,
                      child: Text(
                        "Hello, ${user?.first_name ?? "Guest"}",
                        style: w_600,overflow:TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text("Welcome to NFTwist", style: w_100)
                  ],
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    if(Provider.of<User>(context,listen: false).user==null){
                      alert(context);
                    }else
                    {
                      locator<NavigationService>().namedNavigateTo(Wallet.route);
                    }
                  },
                  child: CircleAvatar(
                    backgroundColor: appColor,
                    radius: 30,
                    child: SvgPicture.asset(
                      "assets/icons/wallet.svg",
                      height: 27,
                      width: 22,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        body: LoaderPage(
          loading: loading,
          child: InViewNotifierCustomScrollView(
            isInViewPortCondition:
                (double deltaTop, double deltaBottom, double viewPortDimension) {
              return deltaTop < (0.5 * viewPortDimension) &&
                  deltaBottom > (0.5 * viewPortDimension);
            },
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(14, 20, 20, 20),
                  child: Row(
                    children: [
                      Text(
                        'Our Partners',
                        style: w_700.copyWith(fontSize: 20),
                      ),
                      const Spacer(),
                      const BlinkingTextAnimation()
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(child:   SizedBox(
                height: 120,
                child: ListView.builder(
                  itemCount: homeScreenData.partners.length + 1,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => index == 0
                      ? PartnerWidget(
                    onTap: () {
                   locator<NavigationService>().namedNavigateTo(BecomePartner.route);
                    },
                  )
                      : PartnerWidget_2(
                      image: homeScreenData.partners[index - 1].profilePic??'',
                      onImageTitle: homeScreenData.partners[index - 1].userName??"${homeScreenData.partners[index - 1].firstName} ${homeScreenData.partners[index - 1].lastName}", media_type: "IMAGE",onTap: () async {

    // if(user==null){
    // alert(context);
    // }else {
      setState(() {
        loading = true;
      });
      loading = await Provider.of<OtherUserProfile>(context, listen: false)
          .getOtherUserProfile(
          id: homeScreenData.partners[index - 1].sId, user_id: user?.id);
      setState(() {
        print("After---$loading");
      });
    // }
                      }),
                ),
              ),),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 55, 20, 0),
                  child: Row(
                    children: [
                      Text(
                        'News feed',
                        style: w_700.copyWith(fontSize: 20),
                      ),
                      // const Spacer(),
                      // SvgPicture.asset("assets/icons/news_feed.svg"),
                      // TextButton(onPressed: (){
                      //   locator<NavigationService>().nftMarketPlace(NewsFeeds.route);
                      // }, child: Text('Open News Feed',style: w_400.copyWith(fontSize: 12),),)
                    ],
                  ),
                ),
              ),
              const SliverToBoxAdapter (child:SizedBox(
                height: 16,
              ), ),
                FutureBuilder(future: future, builder: (context, snapshot) {
                  if(snapshot.connectionState==ConnectionState.waiting){
                    return const SliverToBoxAdapter(child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 50.0),
                      child: CupertinoActivityIndicator(color: whiteColor,),
                    ),);
                  }else if(nftMarketPlace.newsFeeds.isEmpty){
                    return SliverToBoxAdapter(child: Center(child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 50.0,horizontal: 20),
                      child: Text("Follow other Users/Partners to view Newsfeeds",style: w_400.copyWith(fontSize: 14),),
                    )));
                  } else{
                    return SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) =>   LayoutBuilder(builder:  (BuildContext context, BoxConstraints constraints) {
                          return InViewNotifierWidget(id: nftMarketPlace.newsFeeds[index].id.toString(), builder: (context, isInView, child) {
                            return NewsFeed(
                              name: nftMarketPlace.newsFeeds[index].name,createAt:nftMarketPlace.newsFeeds[index].created_at,
                              collection_name: nftMarketPlace.newsFeeds[index].collection_name,
                              collection_symbol: nftMarketPlace.newsFeeds[index].collection_symbol,
                              comment_count: nftMarketPlace.newsFeeds[index].comment_count,
                              description: nftMarketPlace.newsFeeds[index].description,
                              first_name: nftMarketPlace.newsFeeds[index].first_name,
                              is_private: nftMarketPlace.newsFeeds[index].is_private,
                              last_name: nftMarketPlace.newsFeeds[index].last_name,
                              likes_count: nftMarketPlace.newsFeeds[index].likes_count,
                              profile_pic: nftMarketPlace.newsFeeds[index].profile_pic,
                              user_name: nftMarketPlace.newsFeeds[index].user_name,
                              media_type: nftMarketPlace.newsFeeds[index].media_type,
                              file: nftMarketPlace.newsFeeds[index].file,
                              isPaly: loading==true?false:isInView,
                              onTap: ()async{
                                setState(() {
                                  loading=true;
                                });
                                await Provider.of<Nfts>(context,listen: false).getNftDetails(nftMarketPlace.newsFeeds[index].id);
                                loading=await locator<NavigationService>().push(
                                    MaterialPageRoute(builder: (context) =>  const NftDetails(),settings: const RouteSettings(name: NftDetails.route)));
                                setState(() {
                                });      },
                            );
                          },);
                        },),childCount:nftMarketPlace.newsFeeds.length>4?4:nftMarketPlace.newsFeeds.length));
                  }
                },),
                if(nftMarketPlace.newsFeeds.isNotEmpty)SliverToBoxAdapter(
                 child:Button(
                   buttonTxt: "Open News Feed",
                   function: () {
                     locator<NavigationService>().namedNavigateTo(NewsFeeds.route);
                   },
                   verticalPadding: 10,
                 ),
               ),
              SliverToBoxAdapter(child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Row(
                  children: [
                    Text(
                      'Partner’s NFTs',
                      style: w_700.copyWith(fontSize: 20),
                    ),
                    const Spacer(),
                    SvgPicture.asset("assets/icons/campaigns.svg"),
                    const SizedBox(
                      width: 6,
                    ),
                    InkWell(
                      onTap: (){
                        widget.tabController.animateTo(1);
                      },
                      child: Text(
                        'Explore More',
                        style: w_400.copyWith(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),),
              SliverToBoxAdapter(child: SizedBox(
                height: 160,
                child: partnerNft.isNotEmpty?ListView.builder(
                  padding: const EdgeInsets.only(left: 20),
                  itemCount: partnerNft.length>4?4:partnerNft.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => PartnerWidget_2(
                      image: partnerNft[index].file!,
                      onImageTitle: partnerNft[index].name,
                      onImageSubtitle: partnerNft[index].userName,media_type: partnerNft[index].mediaType,
                      minHeight: 150,
                      minWidth: 150,onTap: () async {
                    setState(() {
                      loading=true;
                    });
                    await  Provider.of<Nfts>(context,listen: false).getNftDetails("${partnerNft[index].sId}");
                    loading=await locator<NavigationService>().push(
                        MaterialPageRoute(builder: (context) =>  const NftDetails(),settings: const RouteSettings(name: NftDetails.route)));
                    setState(() {
                    });
                  }),
                ):Center(child: Text("No Partner NFT available.",style: w_400,)),
              ),),
             /* SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 60, 20, 10),
                  child: Row(
                    children: [
                      Text(
                        'Marketplace',
                        style: w_700.copyWith(fontSize: 20),
                      ),
                      Spacer(),
                      const GradientTxt(txt: "Coming Soon", style: TextStyle(fontSize: 10))
                    ],
                  ),
                ),
              ),
              SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) => LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return InViewNotifierWidget(
          id: "${nftMarketPlace.marketPlaceNfts[0].data?[index].sId}", builder: (BuildContext context, bool isInView, Widget? child) {
          return  MarketPlace(
            collectionName:
            "${nftMarketPlace.marketPlaceNfts[0].data?[index].collectionName}"
            ,name: "${nftMarketPlace.marketPlaceNfts[0].data?[index].name}",
            available_nft: "${nftMarketPlace.marketPlaceNfts[0].data?[index].price}",
            like: "${nftMarketPlace.marketPlaceNfts[0].data?[index].likesCount}",
            image: "${nftMarketPlace.marketPlaceNfts[0].data?[index].file}",
            id: "${nftMarketPlace.marketPlaceNfts[0].data?[index].sId}",
            media_type: "${nftMarketPlace.marketPlaceNfts[0].data?[index].mediaType}",
            multiple_nft: nftMarketPlace.marketPlaceNfts[0].data?[index].type==2,isLike: nftMarketPlace.marketPlaceNfts[0].data?[index].isLiked??false,
            auction:  nftMarketPlace.marketPlaceNfts[0].data?[index].voucher?.auctionType==2,
            isPaly: loading==true?false:isInView,
            viewNft: ()async{
              setState(() {
                loading=true;
              });
              await  Provider.of<Nfts>(context,listen: false).getNftDetails("${nftMarketPlace.marketPlaceNfts[0].data?[index].sId}");

              loading=await locator<NavigationService>().push(
                  MaterialPageRoute(builder: (context) =>  const NftDetails(),settings: const RouteSettings(name: NftDetails.route)));
              setState(() {
              });    },
            likeNft: ()async{
              Provider.of<Nfts>(context,listen: false).likeNft(nftMarketPlace.marketPlaceNfts[0].data?[index].sId,1);
            },
          ); },
        );
      }),childCount:nftMarketPlace.marketPlaceNfts[0].data!.length>4?4:nftMarketPlace.marketPlaceNfts[0].data?.length)),
              SliverToBoxAdapter(
                child:Button(
                  buttonTxt: "Explore More",
                  function: () {
                    Provider.of<Nfts>(context,listen: false).getMarketPlaceNft(limit: 10);
                    widget.tabController.animateTo(1);
                  },
                  verticalPadding: 10,
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}

class BlinkingTextAnimation extends StatefulWidget {
  const BlinkingTextAnimation({super.key});

  @override
  _BlinkingAnimationState createState() => _BlinkingAnimationState();
}

class _BlinkingAnimationState extends State<BlinkingTextAnimation>
    with SingleTickerProviderStateMixin {
  late Animation<Color?> textAnimation;
  late Animation<Decoration?> buttonAnimation;
  late AnimationController controller;

  @override
  initState() {
    super.initState();

    controller = AnimationController(duration: const Duration(seconds: 5), vsync: this);

    final CurvedAnimation curve =
    CurvedAnimation(parent: controller, curve: Curves.ease);

    textAnimation = ColorTween(begin: blackColor, end: whiteColor).animate(curve);
    buttonAnimation = DecorationTween(end: BoxDecoration(
      borderRadius: BorderRadius.circular(56),
      gradient:  const LinearGradient(
        colors:[
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
          0.2,
          0.4,
          0.5052,
          0.6771,
          0.8229,
          1.0,
        ],
      ),
    ),begin:BoxDecoration(
      borderRadius: BorderRadius.circular(56),
      gradient:  const LinearGradient(
        colors:[ Colors.white,
          Colors.white,
          Colors.white,
          Colors.white,
          Colors.white,
          Colors.white,
          Colors.white,],
        stops: [
          0.0,
          0.2,
          0.4,
          0.5052,
          0.6771,
          0.8229,
          1.0,
        ],
      ),
    ) ).animate(curve);

    textAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reset();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: textAnimation,
      builder: (context, child) {
        return InkWell(
          onTap: () {
            locator<NavigationService>()
                .namedNavigateTo(OngoingCampaigns.route);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: buttonAnimation.value,
            child: Row(children: [
              SvgPicture.asset(
                "assets/icons/campaigns.svg",
                color: blackColor,
              ),
              const SizedBox(
                width: 8,
              ),
              Text('Ongoing Campaigns',
                  style: w_700.copyWith(fontSize: 12, color: textAnimation.value)),
            ]),
          ),
        );
      },
    );
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }
}


