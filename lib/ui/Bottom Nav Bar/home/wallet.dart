import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:nftwist/constant/style.dart';
import 'package:nftwist/provider/user.dart';
import 'package:nftwist/widget/appBar.dart';
import 'package:nftwist/widget/loader_screen.dart';
import 'package:provider/provider.dart';

import '../../../constant/color.dart';
import '../../../provider/market_place_nfts.dart';
import '../../../services/locator.dart';
import '../../../services/navigation_service.dart';
import '../../../widget/home_widget/market_place.dart';
import '../search/nftDetails.dart';

class Wallet extends StatefulWidget {
  const Wallet({Key? key}) : super(key: key);
  static const route = "wallet";

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  bool loading=false;
  bool pageLoading=false;
  var getownerNft;
  var getCreatedNft;
  int tab=0;
  int page=1;
  int limit=10;
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(_onScroll);
    getownerNft=Provider.of<User>(context, listen: false).getUserOwnedNfts();
    getCreatedNft=Provider.of<User>(context, listen: false).getCreatedNfts();
  }


  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _loadMoreData(tab);
    }
  }

  void _loadMoreData(tab) {
    setState(() {
      pageLoading = true;
    });
   if(tab==0){
     Provider.of<User>(context,listen: false).getUserOwnedNfts(limit: limit,page: page).then((_){
       setState(() {
         pageLoading = false;
       });
     });
   }else{
     Provider.of<User>(context,listen: false).getCreatedNfts().then((_){
       setState(() {
         pageLoading = false;
       });
     });
   }
    // Set loading to false after loading data
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context).user;
    return DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: LoaderPage(
          loading: loading,
          child: Scaffold(
              appBar: const CustomAppBar(
                title: "Wallet",
              ),
              body: InViewNotifierCustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: blackBorderColor),
                          borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: Column(children: [
                        Text(
                          "Wallet"/*"Wallet Balance"*/,
                          style: w_400.copyWith(fontSize: 12),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset("assets/icons/Ellipse.png"),
                            const SizedBox(
                              width: 8,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text(
                                //   "${user?.balance} MATIC",
                                //   style: w_700.copyWith(fontSize: 20),
                                // ),
                                // const SizedBox(
                                //   height: 8,
                                // ),
                              /*  Text(
                                  "${user?.balance??0*user?.dollar_value} USD",
                                  style: w_500.copyWith(fontSize: 16),
                                ),*/
                                Text(
                                  "We are on the Polygon\nblockchain",
                                  style: w_700.copyWith(fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        InkWell(
                          onTap: (){
                            Clipboard.setData(ClipboardData(text: user!.wallet_address!));
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
                                Text("${user?.wallet_address!.substring(0,5)}....${user?.wallet_address!.substring(user.wallet_address!.length-5)}"),
                                const SizedBox(
                                  width: 8.13,
                                ),
                                SvgPicture.asset("assets/icons/copy.svg")
                              ],
                            ),
                          ),
                        )
                      ]),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      color: blackColor,
                      margin: const EdgeInsets.only(top: 20),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 0),
                        child: TabBar(
                            dividerColor: Colors.transparent,
                            indicatorColor: whiteColor,
                            indicatorWeight: 1,
                            indicatorSize: TabBarIndicatorSize.label,
                            indicatorPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            labelStyle: w_500.copyWith(
                              fontSize: 14,
                            ),
                            labelColor: whiteColor2,
                            unselectedLabelColor: whiteColor2,
                            splashFactory: NoSplash.splashFactory,
                            tabs: [
                              SizedBox(
                                height: 33,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                      "Owned(${user?.userOwnedNfts.length ?? 0})"),
                                ),
                              ),
                              const SizedBox(
                                height: 33,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text("Created"),
                                ),
                              ),
                           /*   const SizedBox(
                                height: 33,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text("On Sale"),
                                ),
                              ),*/
                            ],
                           onTap: (value) {
                             setState(() {
                               tab=value;
                             });
                           },
                        ),
                      ),
                    ),
                  ),

                  if (tab == 0)
                    FutureBuilder(future: getownerNft, builder: (context, snapshot) {
                      if(snapshot.connectionState==ConnectionState.waiting){
                         return  const SliverToBoxAdapter(child: Center(child: Padding(
                           padding: EdgeInsets.only(top: 150.0),
                           child: CircularProgressIndicator(color: whiteColor,),
                         ),),);
                      }else if(user?.userOwnedNfts==null||user!.userOwnedNfts.isEmpty){
                         return  const SliverToBoxAdapter(child: Center(child: Padding(
                           padding: EdgeInsets.only(top: 150.0),
                           child: Text("No owned NFTs."),
                         ),),);
                      }else{
                        return SliverList(delegate: SliverChildBuilderDelegate((context, index) =>
                            LayoutBuilder(
                                builder: (BuildContext context, BoxConstraints constraints) {
                                  return InViewNotifierWidget(
                                    id: "${user.userOwnedNfts[index].id}",
                                    builder: (BuildContext context, bool isInView, Widget? child) {
                                      return MarketPlace(owner: true,wallet: true,isLike:user.userOwnedNfts[index].isLiked??false,
                                        collectionName:
                                        "${user.userOwnedNfts[index].collectionName}",
                                        name: "${user.userOwnedNfts[index].name}",
                                        // available_nft: "${partnerNft[index].price}",
                                        available_nft:
                                        "${user.userOwnedNfts[index].available}/${user.userOwnedNfts[index].noOfCopy} Available",
                                        like:
                                        "${user.userOwnedNfts[index].likesCount}",
                                        image: "${user.userOwnedNfts[index].file}",
                                        id: "${user.userOwnedNfts[index].id}",
                                        media_type:
                                        "${user.userOwnedNfts[index].mediaType}",
                                        multiple_nft:
                                        user.userOwnedNfts[index].type == 2,
                                        auction: user.userOwnedNfts[index]
                                            .voucher?['auction_type'] ==
                                            2,
                                        isPaly: loading==true?false:isInView,
                                        onTap: ()async{
                                          setState(() {
                                            loading=true;
                                          });
                                          await  Provider.of<Nfts>(context,listen: false).getNftDetails("${user.userOwnedNfts[index].id}");

                                          loading=await locator<NavigationService>().push(
                                              MaterialPageRoute(builder: (context) =>  const NftDetails(),settings: const RouteSettings(name: NftDetails.route)));
                                          setState(() {
                                          });
                                        },
                                        likeNft: ()async{
                                          Provider.of<User>(context,listen: false).likeNft(user.userOwnedNfts[index].id,nftType:2);
                                        },
                                      );
                                    },);
                                }),childCount:user.userOwnedNfts.length));
                      }
                    },),
                  if (tab == 1)
                    FutureBuilder(future: getCreatedNft, builder: (context, snapshot) {
                      if(snapshot.connectionState==ConnectionState.waiting){
                        return  const SliverToBoxAdapter(child: Center(child: Padding(
                          padding: EdgeInsets.only(top: 150.0),
                          child: CircularProgressIndicator(color: whiteColor,),
                        ),),);
                      }else if(user?.userCreatedNFts==null||user==null||user.userCreatedNFts!.isEmpty){
                        return  const SliverToBoxAdapter(child: Center(child: Padding(
                          padding: EdgeInsets.only(top: 150.0),
                          child: Text("No NFTs created."),
                        ),),);
                      }else{
                        return SliverList(delegate: SliverChildBuilderDelegate((context, index) =>
                            LayoutBuilder(
                                builder: (BuildContext context, BoxConstraints constraints) {
                                  return InViewNotifierWidget(
                                    id: "${user.userCreatedNFts?[index].id}",
                                    builder: (BuildContext context, bool isInView, Widget? child) {
                                      return MarketPlace(owner: user.userCreatedNFts?[index].userId==user.id,wallet: true,
                                        collectionName:
                                        "${user.userCreatedNFts?[index].collectionName}",isLike:user.userCreatedNFts?[index].isLiked??false ,
                                        name: "${user.userCreatedNFts?[index].name}",
                                        // available_nft: "${user.userCreatedNFts?[index].price}",
                                        // available_nft:
                                        // "${user.userCreatedNFts?[index].description}",
                                        available_nft:"",
                                        like:
                                        "${user.userCreatedNFts?[index].likesCount}",
                                        image: "${user.userCreatedNFts?[index].file}",
                                        id: "${user.userCreatedNFts?[index].id}",
                                        media_type:
                                        "${user.userCreatedNFts?[index].mediaType}",
                                        multiple_nft:
                                        user.userCreatedNFts?[index].type == 2,
                                        auction: user.userCreatedNFts?[index]
                                            .voucher?['auction_type'] ==
                                            2,
                                        isPaly: loading==true?false:isInView,
                                        onTap: ()async{
                                          setState(() {
                                            loading=true;
                                          });
                                          await  Provider.of<Nfts>(context,listen: false).getNftDetails("${user.userCreatedNFts?[index].id}");

                                          loading=await locator<NavigationService>().push(
                                              MaterialPageRoute(builder: (context) =>  const NftDetails(),settings: const RouteSettings(name: NftDetails.route)));
                                          setState(() {
                                          });
                                        },
                                        likeNft: ()async{
                                          Provider.of<User>(context,listen: false).likeNft(user.userCreatedNFts?[index].id,nftType: 1);
                                        },
                                      );
                                    },);
                                }),childCount:user.userCreatedNFts?.length));
                      }
                    },),
                ],
                isInViewPortCondition: (double deltaTop, double deltaBottom,
                    double viewPortDimension) {
                  return deltaTop < (0.5 * viewPortDimension) &&
                      deltaBottom > (0.5 * viewPortDimension);
                },
              )),
        ));
  }
}
