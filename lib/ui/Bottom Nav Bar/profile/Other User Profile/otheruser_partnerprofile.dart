import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:nftwist/constant/style.dart';
import 'package:nftwist/provider/other_profile.dart';
import 'package:nftwist/provider/user.dart';
import 'package:nftwist/services/locator.dart';
import 'package:nftwist/services/navigation_service.dart';
import 'package:nftwist/ui/Bottom%20Nav%20Bar/search/qr_code.dart';
import 'package:nftwist/widget/loader_screen.dart';
import 'package:provider/provider.dart';

import '../../../../constant/apiConstant.dart';
import '../../../../constant/color.dart';
import '../../../../provider/market_place_nfts.dart';
import '../../../../widget/appBar.dart';
import '../../../../widget/button.dart';
import '../../../../widget/gust_login_alert.dart';
import '../../../../widget/home_widget/market_place.dart';
import '../../../../widget/nft_list_tile.dart';
import '../../home/report.dart';
import '../../search/nftDetails.dart';
import '../User profile/profile.dart';

class OtherPartnerProfile extends StatefulWidget {
  const OtherPartnerProfile({Key? key}) : super(key: key);
  static const route = 'other_partner_profile';
  @override
  State<OtherPartnerProfile> createState() => _OtherPartnerProfileState();
}

class _OtherPartnerProfileState extends State<OtherPartnerProfile> {
  int tab = 0;
  final ScrollController _scrollController = ScrollController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    var otherUserProfile = Provider.of<OtherUserProfile>(context).otherUser;
    var user = Provider.of<User>(context).user;
    return LoaderPage(
      loading: loading,
      child: DefaultTabController(
        initialIndex: 0,
        length: 3,
        child: Scaffold(
            body: InViewNotifierCustomScrollView(
          controller: _scrollController,
          isInViewPortCondition:
              (double deltaTop, double deltaBottom, double viewPortDimension) {
            return deltaTop < (0.5 * viewPortDimension) &&
                deltaBottom > (0.5 * viewPortDimension);
          },
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                height: 300,
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: "$imageBaseUrl${otherUserProfile?.cover_image}",
                      height: 240,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                      placeholder: (context, imageProvider) {
                        return const SizedBox(
                            height: 10,
                            width: 10,
                            child: Center(
                                child: CupertinoActivityIndicator(
                              color: whiteColor,
                            )));
                      },
                      errorWidget: (context, url, error) {
                        return Image.asset(
                          "assets/images/john_doe_cover.png",
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                    CustomAppBar(
                        toolbarHeight: 40,
                        appBarColor: Colors.transparent, action: [
                      InkWell(
                          onTap: () {
                              locator<NavigationService>().push(
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                          Report(
                                            UserId: otherUserProfile?.id,
                                            userName: otherUserProfile
                                                ?.first_name ==
                                                null
                                                ? "Report: ${otherUserProfile
                                                ?.user_name}"
                                                : "Report: ${otherUserProfile
                                                ?.first_name} ${otherUserProfile
                                                ?.last_name}",
                                            reportType: 1,
                                          ),
                                      settings: const RouteSettings(
                                          name: Report.route)));
                            },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: SvgPicture.asset("assets/icons/flag.svg",height: 25,width: 25,color: Colors.red,),
                          )),
                    ]),
                    Positioned(
                      bottom: 0,
                      left: 20,
                      child: Container(
                        height: 120,
                        width: 120,
                        decoration: const BoxDecoration(
                          color: appColor,
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(2),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CachedNetworkImage(
                              imageUrl:
                                  "$imageBaseUrl${otherUserProfile?.profile_pic}",
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) {
                                return Image.asset(
                                  "assets/images/banner-image.png",
                                  fit: BoxFit.cover,
                                );
                              },
                              placeholder: (context, imageProvider) {
                                return const SizedBox(
                                    height: 10,
                                    width: 10,
                                    child: Center(
                                        child: CupertinoActivityIndicator(
                                      color: whiteColor,
                                    )));
                              },
                            )),
                      ),
                    ),
                    Positioned(
                      left: 105,
                      top: 260,
                      child: InkWell(
                        onTap: () {
                          locator<NavigationService>().push(MaterialPageRoute(
                              builder: (context) => QRCode(
                                    userQr: false,
                                    myQr: false,
                                    partnerQr: otherUserProfile?.user_type == 2,
                                    image: otherUserProfile?.profile_pic,
                                    name:
                                        "${otherUserProfile?.first_name} ${otherUserProfile?.last_name}",
                                    username: otherUserProfile?.user_name,
                                    qrString:
                                        "profile-${otherUserProfile?.id}/email${otherUserProfile?.email}/email${otherUserProfile?.user_type}",
                                  ),
                              settings:
                                  const RouteSettings(name: QRCode.route)));
                        },
                        child: Container(
                            margin: const EdgeInsets.only(right: 20),
                            height: 35,
                            width: 35,
                            padding: const EdgeInsets.all(10),
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
                            child: SvgPicture.asset(
                              "assets/icons/qr-code.svg",
                              color: whiteColor,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    otherUserProfile?.first_name ?? '${otherUserProfile?.user_name}',
                                    style: w_700.copyWith(fontSize: 20),
                                  ),
                                      const SizedBox(width: 5,),
                                      if(otherUserProfile?.is_user_verified==true) SvgPicture.asset("assets/icons/check_tick.svg",height: 20,),

                                ],
                              ),
                              Text(
                                "@${otherUserProfile?.user_name}",
                                style: w_600.copyWith(fontSize: 14),
                              ),
                            ],
                          ),
                          const Spacer(),
                          if (user?.id != otherUserProfile?.id)
                            SizedBox(
                                width: 150,
                                child: Button_2(
                                  buttonTxt: otherUserProfile?.is_follow == 1
                                      ? "Unfollow"
                                      : "Follow",
                                  function: () async {
                                    if(user==null){
                                    alert(context);
                                    }else
                                    {
                                      setState(() {
                                        loading = true;
                                      });
                                      loading =
                                          await Provider.of<OtherUserProfile>(
                                                  context,
                                                  listen: false)
                                              .followUser(
                                                  otherUserProfile?.is_follow);
                                      setState(() {});
                                    }
                                  },
                                )),
                        ],
                      ),
                    ),
                    Text(
                      otherUserProfile?.bio ?? '',
                      style: w_400.copyWith(fontSize: 14),
                      textAlign: TextAlign.start,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            height: 68,
                            margin: const EdgeInsets.only(
                                top: 16, bottom: 5, right: 8),
                            // padding: const EdgeInsets.symmetric(
                            //     vertical: 4, horizontal: 19),
                            decoration: BoxDecoration(
                              color: blackColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Followers",
                                  style: w_400.copyWith(fontSize: 12),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  "${otherUserProfile?.follower_count}",
                                  style: w_600.copyWith(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 68,
                            margin: const EdgeInsets.only(top: 16, bottom: 5),
                            // padding: const EdgeInsets.symmetric(
                            //     vertical: 4, horizontal: 19),
                            decoration: BoxDecoration(
                              color: blackColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Following",
                                  style: w_400.copyWith(fontSize: 12),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  "${otherUserProfile?.following_count}",
                                  style: w_600.copyWith(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 68,
                            margin: const EdgeInsets.only(
                                top: 16, bottom: 5, left: 8),
                            // padding: const EdgeInsets.symmetric(
                            //     vertical: 4, horizontal: 19),
                            decoration: BoxDecoration(
                              color: blackColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "NFTs",
                                  style: w_400.copyWith(fontSize: 12),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  "${otherUserProfile?.user_nft_count ?? 0}",
                                  style: w_600.copyWith(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
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
                            tab = tabIndex;
                          });
                        },
                        labelPadding:
                            const EdgeInsets.only(left: 20, right: 20),
                        tabs: const [
                          SizedBox(
                            height: 33,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text("NFTs"),
                            ),
                          ),
                          SizedBox(
                            height: 33,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text("Activity"),
                            ),
                          ),
                          SizedBox(
                            height: 33,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text("Community"),
                            ),
                          ),
                          /*         SizedBox(
                              height: 33,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("Rules"),
                              ),
                            ),*/
                        ]),
                  ),
                ),
              ),
            ),
            if (tab == 0 && otherUserProfile?.userOwnedNfts != null)
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (context, index) => LayoutBuilder(builder:
                              (BuildContext context,
                                  BoxConstraints constraints) {
                            return InViewNotifierWidget(
                              id: "${otherUserProfile?.userOwnedNfts[index].id}",
                              builder: (BuildContext context, bool isInView,
                                  Widget? child) {
                                return MarketPlace(
                                  collectionName:
                                      "${otherUserProfile?.userOwnedNfts[index].collectionName}",
                                  name:
                                      "${otherUserProfile?.userOwnedNfts[index].name}",
                                  isLike: otherUserProfile?.userOwnedNfts[index].isLiked??false,
                                  // available_nft: "${partnerNft[index].price}",
                                  available_nft:
                                      "${otherUserProfile?.userOwnedNfts[index].available}/${otherUserProfile?.userOwnedNfts[index].noOfCopy} Available",
                                  like:
                                      "${otherUserProfile?.userOwnedNfts[index].likesCount}",
                                  image:
                                      "${otherUserProfile?.userOwnedNfts[index].file}",
                                  id: "${otherUserProfile?.userOwnedNfts[index].id}",
                                  media_type:
                                      "${otherUserProfile?.userOwnedNfts[index].mediaType}",
                                  multiple_nft: otherUserProfile
                                          ?.userOwnedNfts[index].type ==
                                      2,
                                  auction: otherUserProfile
                                          ?.userOwnedNfts[index]
                                          .voucher?['auction_type'] ==
                                      2,
                                  isPaly: loading == true ? false : isInView,
                                  onTap: () async {
                                    setState(() {
                                      loading = true;
                                    });
                                    await Provider.of<Nfts>(context,
                                            listen: false)
                                        .getNftDetails(
                                            "${otherUserProfile?.userOwnedNfts[index].id}");

                                    loading = await locator<NavigationService>()
                                        .push(MaterialPageRoute(
                                            builder: (context) =>
                                                const NftDetails(),
                                            settings: const RouteSettings(
                                                name: NftDetails.route)));
                                    setState(() {});
                                  },
                                  likeNft: () async {
                                    if(Provider.of<User>(context,listen: false).user==null){
                                      alert(context);
                                    }else
                                    { Provider.of<OtherUserProfile>(context, listen: false)
                                        .likeNft(
                                      otherUserProfile
                                          ?.userOwnedNfts[index].id,);
                                    }

                                  },
                                  popupMenuButton:(option) {
                                    if(user==null){
                                      alert(context);
                                    }else {
                                      locator<NavigationService>().push(CupertinoPageRoute(builder: (context) =>
                                          Report(NftId: otherUserProfile?.userOwnedNfts[index].id ?? '',
                                            userName: otherUserProfile?.first_name == null
                                                ? "Report: ${otherUserProfile?.user_name}"
                                                : "Report: ${otherUserProfile?.first_name} ${otherUserProfile?.last_name}",
                                            reportType: 2,),
                                          settings: const RouteSettings(name: Report.route)));
                                    }   },

                                );
                              },
                            );
                          }),
                      childCount: otherUserProfile?.userOwnedNfts.length)),
            if (tab == 1)
              SliverList(
                  delegate: SliverChildListDelegate([
                ListView.separated(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 17, vertical: 30),
                  separatorBuilder: (context, index) => const Divider(
                    color: blackBorderColor,
                  ),
                  itemCount: otherUserProfile!.userActivity.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) =>   otherUserProfile.userActivity[index].type=="FOLLOW"?
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ActivityFollow(
                          cover:otherUserProfile.userActivity[index].activityByCoverImage,
                          image: otherUserProfile.userActivity[index].activityByProfilePic,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        SizedBox(
                          height: 69,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${otherUserProfile.userActivity[index].activityByFirstName} ${otherUserProfile.userActivity[index].activityByLastName}",
                                  style: w_600.copyWith(fontSize: 16),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  "${otherUserProfile.userActivity[index].activityByUserName} started following you",
                                  style: w_400.copyWith(fontSize: 12),
                                ),

                              ]),
                        ),
                      ])  : otherUserProfile.userActivity[index].type=="NFT_CREATED"? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ActivityNFTs(
                          mediaType:otherUserProfile.userActivity[index].mediaType,
                          image: otherUserProfile.userActivity[index].nftImage,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        SizedBox(
                          height: 69,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  otherUserProfile.userActivity[index].nftName.toString(),
                                  style: w_600.copyWith(fontSize: 16),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  "You created qweqw NFT.",
                                  style: w_400.copyWith(fontSize: 12),
                                ),
                              ]),
                        ),
                      ]): Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ActivityNFTs(
                          mediaType:otherUserProfile.userActivity[index].mediaType,
                          image: otherUserProfile.userActivity[index].nftImage,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 3.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  otherUserProfile.userActivity[index].nftName.toString(),
                                  style: w_600.copyWith(fontSize: 16),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "1 edition gifted from",
                                      style: w_400.copyWith(fontSize: 12),
                                    ),

                                  ],
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  // crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    CircleAvatar(
                                      radius: 10,
                                      foregroundImage: CachedNetworkImageProvider("$imageBaseUrl${otherUserProfile.userActivity[index].activityByProfilePic??otherUserProfile.userActivity[index].activityByCoverImage}"),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      otherUserProfile.userActivity[index].activityByUserName??'',
                                      style: w_600.copyWith(fontSize: 12),overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),   Text(
                                      "to",
                                      style: w_400.copyWith(fontSize: 12),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    CircleAvatar(
                                      radius: 10,
                                      foregroundImage: CachedNetworkImageProvider("$imageBaseUrl${otherUserProfile.userActivity[index].activityOnProfilePic??otherUserProfile.userActivity[index].activityOnCoverImage}"),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      otherUserProfile.userActivity[index].activityOnUserName??'',
                                      style: w_600.copyWith(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ]),
                        ),
                      ]),
                ),
              ])),
            if (tab == 2)
              SliverList(
                  delegate: SliverChildListDelegate([

                   if( otherUserProfile!.userCommunity==null)   Center(child: Padding(
                      padding: const EdgeInsets.only(top: 100.0),
                      child: Text("This partner's community is hidden.",style: w_500,),
                    ))else

                ListView.separated(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 17, vertical: 30),
                  separatorBuilder: (context, index) => const Divider(
                    color: blackBorderColor,
                  ),
                  itemCount:otherUserProfile.userCommunity!.data.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 69,
                          width: 69,
                          decoration:   BoxDecoration(
                            borderRadius:BorderRadius.circular(12),
                          ),
                          child: ClipRRect(
                            borderRadius:BorderRadius.circular(12),
                            child: CachedNetworkImage(imageUrl: "$imageBaseUrl${otherUserProfile.userCommunity!.data[index].profilePic}",
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) {
                                return Image.asset("assets/images/banner-image.png",fit: BoxFit.cover,);
                              },placeholder: (context, imageProvider) {
                                return const SizedBox(height:10,width:10,child: Center(child: CupertinoActivityIndicator(color: whiteColor,)));
                              },),
                          ),
                        ),
                        const SizedBox(width: 10,),
                        Text(otherUserProfile.userCommunity!.data[index].firstName??"N/A",
                          style:  w_500.copyWith(fontSize: 12),
                        ),
                        /*    const SizedBox(
                          width: 12,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 3.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "1 edition gifted from",
                                      style: w_400.copyWith(fontSize: 12),
                                    ),

                                  ],
                                ),
                                const SizedBox(
                                  height: 4,
                                ),

                              ]),
                        ),*/
                      ]),
                ),
              ])),
            /*         if(tab==3)  ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
                    separatorBuilder: (context, index) => const Divider(color: blackBorderColor,),
                    itemCount: 4+1,shrinkWrap: true,physics:
                const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => index<4?
                    ListTile(title: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit",style: w_500.copyWith(fontSize: 14),),):Container()),*/
          ],
        )),
      ),
    );
  }
}
