import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:nftwist/constant/apiConstant.dart';
import 'package:nftwist/constant/color.dart';
import 'package:nftwist/constant/style.dart';
import 'package:nftwist/provider/user.dart';
import 'package:nftwist/ui/Bottom%20Nav%20Bar/home/report.dart';
import 'package:nftwist/ui/Bottom%20Nav%20Bar/search/search_screen.dart';
import 'package:nftwist/ui/Bottom%20Nav%20Bar/search/user_market_place.dart';
import 'package:nftwist/widget/button.dart';
import 'package:nftwist/widget/gradient_txt.dart';
import 'package:nftwist/widget/textfiels/textfield.dart';
import 'package:provider/provider.dart';

import '../../../provider/market_place_nfts.dart';
import '../../../provider/partner_nft.dart';
import '../../../services/locator.dart';
import '../../../services/navigation_service.dart';
import '../../../widget/gust_login_alert.dart';
import '../../../widget/home_widget/market_place.dart';
import '../../../widget/loader_screen.dart';
import 'featured_news_list_images.dart';
import 'nftDetails.dart';
import 'filter.dart';



class Marketplace extends StatefulWidget {
  const Marketplace({Key? key}) : super(key: key);

  @override
  State<Marketplace> createState() => _MarketplaceState();
}

class _MarketplaceState extends State<Marketplace> {
  // int selectedTab=0;
  int selectedTab=1;
  bool loading=false;
  bool pageLoading=false;
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels > _scrollController.position.maxScrollExtent&&pageLoading==false) {
      _loadMoreData();
    }
  }

  void _loadMoreData() {
    setState(() {
      pageLoading = true;
    });
   Provider.of<Nfts>(context,listen: false).getPartnerNFTs().then((_){
     setState(() {
     pageLoading = false;
     });
   });
    // Set loading to false after loading data
  }

  @override
  Widget build(BuildContext context) {
    var nftMarketPlace = Provider.of<Nfts>(context);
    var partnerNft = Provider.of<Nfts>(context).partnerNFTs;
    var user = Provider.of<User>(context).user;
    return RefreshIndicator(
      onRefresh: () async{
        Provider.of<Nfts>(context,listen: false).getActivePartner();
      },
      child: Scaffold(
        body: LoaderPage(
          loading: loading,
          child: InViewNotifierCustomScrollView(controller: _scrollController,
          isInViewPortCondition:
          (double deltaTop, double deltaBottom, double viewPortDimension) {
        return deltaTop < (0.5 * viewPortDimension) &&
            deltaBottom > (0.5 * viewPortDimension);
      }, slivers: [
            SliverToBoxAdapter(
              child: Stack(
                children: [

                  Container(
                    width: MediaQuery.of(context).size.width,
                height: 283,
                  padding: const EdgeInsets.symmetric(horizontal:50),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
              image: AssetImage("assets/images/marketplace_bg.6fa0e1af2002cf24.png",),
                      fit: BoxFit.cover,
        )
                  ),
                  child: SvgPicture.asset("assets/images/logo_white_large.svg" ,fit: BoxFit.fitWidth,),
                  ),

                  Positioned(
                    width: MediaQuery.of(context).size.width,
                    bottom: 0,
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: (){
                            setState(() {
                              selectedTab=0;
                            });
                          },
                          child: Container(
                            height: 49,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration:  BoxDecoration(color: selectedTab!=0?const Color(0xFF1B1A1A):appColor,
                                borderRadius: const BorderRadius.only(/*topRight: Radius.circular(20),*/topLeft: Radius.circular(20))),
                            child: Center(child: selectedTab!=0?Text("Marketplace",style: w_600.copyWith(fontSize: 14)):GradientTxt(txt: "Marketplace", style: w_600.copyWith(fontSize: 14))),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            setState(() {
                              selectedTab=1;
                            });
                          },
                          child: Container(
                            height: 49,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration:  BoxDecoration(color:selectedTab!=1?const Color(0xFF1B1A1A):appColor,
                                borderRadius: const BorderRadius.only(topRight: Radius.circular(20),/*topLeft: Radius.circular(20)*/)
                            ),
                            child: Center(child: selectedTab!=1?Text("Partner's NFT",style: w_600.copyWith(fontSize: 14)):GradientTxt(txt: "Partner's NFT", style: w_600.copyWith(fontSize: 14))),
                          ),
                        ),
            /*              InkWell(
                          onTap: (){
                            setState(() {
                              selectedTab=2;
                            });
                          },
                          child: Container(
                            height: 49,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration:  BoxDecoration(color:selectedTab!=2?const Color(0xFF1B1A1A):appColor,),
                            child: Center(child: selectedTab!=2?Text("Featured News",style: w_600.copyWith(fontSize: 14)):GradientTxt(txt: "Featured News", style: w_600.copyWith(fontSize: 14))),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            setState(() {
                              selectedTab=3;
                            });
                          },
                          child: Container(
                            height: 49,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration:  BoxDecoration(color:selectedTab!=3?const Color(0xFF1B1A1A):appColor,
                                borderRadius: const BorderRadius.only(topRight: Radius.circular(20),*/ /*topLeft: Radius.circular(20)*//*)),
                            child: Center(child: selectedTab!=3?Text("Hot Projects",style: w_600.copyWith(fontSize: 14)):GradientTxt(txt: "Hot Projects", style: w_600.copyWith(fontSize: 14))),
                          ),
                        ),*/
                      ],
                    ),
                  ),
                  Positioned(
                      top: 60,right: 12,
                      child: IconButton(
                          onPressed: () {
                            locator<NavigationService>().namedNavigateTo(SearchScreen.route);
                           },
                          icon: const Icon(Icons.search,color: whiteColor,size: 24,))),

                ],
              ),
            ),
             if(selectedTab==2||selectedTab==3)SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 32.0,bottom: 16,left: 20.0,right: 20),
                child: Text(selectedTab==2?"Featured News":"Hot Projects",style: w_700.copyWith(fontSize: 20),),
              ),
            ),
      if(selectedTab==1/*||selectedTab==0*/)SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10,),
                    Text("Most Active Partners",style: w_700.copyWith(fontSize: 20),),
                    SizedBox(
                      height: 100,
                      child: nftMarketPlace.activePartner.isEmpty?const Center(child: Text("No Active Partner currently")):ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: nftMarketPlace.activePartner.length,
                        padding:  EdgeInsets.zero,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                                CircleAvatar(
                                maxRadius: 30,backgroundColor: blackColor2,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: CachedNetworkImage(
                                    height: 80,fit: BoxFit.cover,
                                    width: 100,
                                    imageUrl: "$imageBaseUrl${nftMarketPlace.activePartner[index].gifter_data?.profile_pic}",
                                    errorWidget: (context, url, error) {
                                      return Image.asset("assets/images/banner-image.png",fit: BoxFit.cover,);
                                    },placeholder: (context, imageProvider) {
                                    return const Center(child: CupertinoActivityIndicator(color: whiteColor,));
                                  },
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10,),
                              Text("${index + 1}). ",style: w_600.copyWith(fontSize: 14)),
                              Text("${nftMarketPlace.activePartner[index].gifter_data?.first_name} ${nftMarketPlace.activePartner[index].gifter_data?.last_name}",style: w_600.copyWith(fontSize: 14)),
                            ],
                          ),
                        ),),
                    ),
                  ],
                ),
              ),
            ),
            if(selectedTab==1/*||selectedTab==0*/)SliverToBoxAdapter(
              child: Padding(
                padding:const EdgeInsets.only(top: 0.0,bottom: 0,left: 20.0,right: 20),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Marketplace",style: w_700.copyWith(fontSize: 20),),
                    InkWell(
                      onTap: (){
                        locator<NavigationService>().push(MaterialPageRoute(builder: (context) =>Filter(type: selectedTab),settings: const RouteSettings(name: Filter.route)));
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 20,),
                        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: whiteColor2),
                            borderRadius: BorderRadius.circular(30)),
                        child: Row(children: [
                          SvgPicture.asset("assets/icons/sort.svg"),
                          const SizedBox(width: 4,),
                          Text("Filter",style: w_600.copyWith(fontSize: 12),)
                        ]),
                      ),
                    )
                  ],
                ),
              ),
            ),

            if(selectedTab==0) SliverToBoxAdapter(child: Center(child: Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*.24),
              child: GradientTxt(txt: "Coming Soon....\nStay Tuned!", style: w_600,textAlign: TextAlign.center),
            ),)),
              /*  SliverList(
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
                    }),childCount:nftMarketPlace.marketPlaceNfts[0].data?.length )),*/
            if(selectedTab==1)    SliverList(
                delegate: SliverChildBuilderDelegate((context, index) => LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints) {
                     if(index<partnerNft.length){
                       return InViewNotifierWidget(
                         id: "${partnerNft[index].sId}", builder: (BuildContext context, bool isInView, Widget? child) {
                         return  MarketPlace(isLike:partnerNft[index].is_liked,wallet: partnerNft[index].user?.sId==user?.id,
                           collectionName:
                           "${partnerNft[index].collectionName}"
                           ,name: "${partnerNft[index].name}",
                           available_nft: "${partnerNft[index].available}/${partnerNft[index].noOfCopy} Available",
                           like: "${partnerNft[index].likesCount}",
                           image: "${partnerNft[index].file}",
                           id: "${partnerNft[index].sId}",
                           media_type: "${partnerNft[index].mediaType}",
                           multiple_nft: partnerNft[index].type==2,
                           auction:  partnerNft[index].voucher?.auctionType==2,
                           isPaly: loading==true?false:isInView,
                           onTap: ()async{
                             setState(() {
                               loading=true;
                             });
                             await  Provider.of<Nfts>(context,listen: false).getNftDetails("${partnerNft[index].sId}");

                             loading=await locator<NavigationService>().push(
                                 MaterialPageRoute(builder: (context) =>  const NftDetails(),settings: const RouteSettings(name: NftDetails.route)));
                             setState(() {
                             });    },
                           likeNft: ()async{
                             if(user==null){
                               alert(context);
                             }else {        Provider.of<Nfts>(context,listen: false).likeNft(partnerNft[index].sId,type: 2);}
                           },
                           popupMenuButton:(option) {
    if(user==null){
    alert(context);
    }else {
      locator<NavigationService>().push(CupertinoPageRoute(builder: (context) =>
          Report(NftId: partnerNft[index].sId ?? '',
            userName: partnerNft[index].user?.firstName == null
                ? "Report: ${partnerNft[index].user?.userName}"
                : "Report: ${partnerNft[index].user
                ?.firstName} ${partnerNft[index].user?.lastName}",
            reportType: 2,),
          settings: const RouteSettings(name: Report.route)));
    }   },
                         ); },
                       );
                     }else{
                       return const CupertinoActivityIndicator(color: whiteColor);
                     }
                    }),
                    childCount:partnerNft.length+(pageLoading?1:0) )),
            // if(selectedTab==2||selectedTab==3)  const SearchFeaturedNewsList(),



          ],))
      ),
    );
  }
}


