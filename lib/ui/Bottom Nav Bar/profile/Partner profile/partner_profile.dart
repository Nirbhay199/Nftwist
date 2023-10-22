import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:nftwist/constant/style.dart';
import 'package:nftwist/services/locator.dart';
import 'package:nftwist/services/navigation_service.dart';
import 'package:nftwist/ui/Bottom%20Nav%20Bar/QR%20Scanner/qr_scanner.dart';
import 'package:nftwist/ui/Bottom%20Nav%20Bar/profile/followers_screen.dart';
import 'package:nftwist/ui/Bottom%20Nav%20Bar/profile/Partner%20profile/Partner%20Settings/partner_setting_screen.dart';
import 'package:nftwist/ui/Bottom%20Nav%20Bar/profile/Partner%20profile/select_project.dart';
import 'package:nftwist/ui/Bottom%20Nav%20Bar/search/collection_details.dart';
import 'package:nftwist/ui/Bottom%20Nav%20Bar/search/qr_code.dart';
import 'package:nftwist/widget/loader_screen.dart';
import 'package:nftwist/widget/textfiels/textfield.dart';
import 'package:provider/provider.dart';

import '../../../../constant/apiConstant.dart';
import '../../../../constant/color.dart';
import '../../../../provider/market_place_nfts.dart';
import '../../../../provider/user.dart';
import '../../../../widget/appBar.dart';
import '../../../../widget/button.dart';
import '../../../../widget/dotted_container.dart';
import '../../../../widget/home_widget/market_place.dart';
import '../../../../widget/nft_list_tile.dart';
import '../../search/nftDetails.dart';
import '../edit_profile.dart';
import '../following.dart';

class PartnerProfile extends StatefulWidget {
  const PartnerProfile({Key? key}) : super(key: key);

  @override
  State<PartnerProfile> createState() => _PartnerProfileState();
}

class _PartnerProfileState extends State<PartnerProfile> with TickerProviderStateMixin {
  int tab=0;
  int? chooseType=0;
  final ScrollController _scrollController = ScrollController();

  List<TextEditingController> _controller=List.generate(5, (index) => TextEditingController());
   bool loading=false;
  late TabController _tabController ;
  var owned;
  var community;
  var activity;
  var project;
  List Emails=[];
  String? FileName;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController=TabController(length: 5, vsync: this);
    owned=Provider.of<User>(context, listen: false).getUserOwnedNfts();
    community=Provider.of<User>(context, listen: false).getUsergetCommunity();
    activity=Provider.of<User>(context, listen: false).getUserActivity();
    project=Provider.of<User>(context, listen: false).getProjects();

  }
  @override
  Widget build(BuildContext context) {
    var user=Provider.of<User>(context).user;
    var userFun=Provider.of<User>(context, listen: false);
    return DefaultTabController(
      initialIndex: 0,
      length: 5,
      child: RefreshIndicator(
        onRefresh: () async=>
        { userFun.getUserProfile(),
          userFun.getUserOwnedNfts(),
          userFun.getUsergetCommunity(),
          userFun.getUserActivity(),
          userFun.getProjects(),
        },
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
                  child:  SizedBox(
                    height: 300,
                    child: Stack(
                      children: [
                        CachedNetworkImage(
                          imageUrl:"$imageBaseUrl${user?.cover_image}",
                          height: 240,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          errorWidget: (context, url, error) {
                            return Image.asset("assets/images/john_doe_cover.png",fit: BoxFit.cover,);
                          },   placeholder: (context, imageProvider) {
                          return const SizedBox(height:10,width:10,child: Center(child: CupertinoActivityIndicator(color: whiteColor,)));
                        },
                        ),
                        CustomAppBar(
                            isBackButton: false,toolbarHeight: 40,
                            appBarColor: Colors.transparent,
                            action: [
                              InkWell(
                                  onTap: () {},
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 4),
                                    height: 25,
                                    width: 25,
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
                                  )),
                              InkWell(
                                  onTap: () {
                                    locator<NavigationService>().namedNavigateTo(PartnerSettingScreen.route);
                                  },
                                  child: Container(
                                      margin: const EdgeInsets.only(right: 20),
                                      height: 25,
                                      width: 25,
                                      padding: const EdgeInsets.all(4.23),
                                      decoration: const BoxDecoration(
                                        color: whiteColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: SvgPicture.asset(
                                          "assets/icons/setting.svg"))),
                            ]),
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
                                child: CachedNetworkImage(imageUrl: "$imageBaseUrl${user?.profile_pic}",                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) {
                                    return Image.asset("assets/images/banner-image.png",fit: BoxFit.cover,);
                                  },placeholder: (context, imageProvider) {
                                    return const SizedBox(height:10,width:10,child: Center(child: CupertinoActivityIndicator(color: whiteColor,)));
                                  },)),
                          ),
                        ),
                        Positioned(
                          left: 105,
                          top: 260,
                          child: InkWell(
                            onTap: (){
                              locator<NavigationService>().push(MaterialPageRoute(
                                  builder: (context) =>  QRCode(myQr: true,image: user?.profile_pic,name: user?.first_name,username: user?.user_name,qrString: "profile-${user?.id}/email${user?.email}/email2"),
                                  settings: const RouteSettings(name: QRCode.route)));                        },
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
                  child:   Padding(
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
                                        "${user?.first_name}",
                                        style: w_700.copyWith(fontSize: 20),
                                      ),
                                      const SizedBox(width: 5,),
                                      if(user?.is_user_verified==true) SvgPicture.asset("assets/icons/check_tick.svg",height: 20,),
                                    ],
                                  ),
                                  Text(
                                    "@${user?.user_name??user?.first_name}",
                                    style: w_600.copyWith(fontSize: 14),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              SizedBox(
                                  width: 160,
                                  child: Button_2(
                                    buttonTxt: "Edit Profile",
                                    function: () {
                                      locator<NavigationService>().namedNavigateTo(EditProfile.route);
                                    },
                                    icon: SvgPicture.asset("assets/icons/edit.svg"),
                                  )),
                            ],
                          ),
                        ),
                        Text(
                          user?.bio??'',
                          style: w_400.copyWith(fontSize: 14),textAlign: TextAlign.start,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: (){
                                  locator<NavigationService>().namedNavigateTo(FollowerScreen.route);
                                },
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
                                        "${user?.follower_count??0}",
                                        style: w_600.copyWith(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: (){
                                  locator<NavigationService>().namedNavigateTo(FollowingScreen.route);
                                },
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
                                        "${user?.following_count??0}",
                                        style: w_600.copyWith(fontSize: 16),
                                      ),
                                    ],
                                  ),
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
                                      "${user?.user_nft_count ?? 0}",
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
                  child:        SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Material(
                        color: blackColor,
                        child: TabBar(
                            controller: _tabController,
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
                              Provider.of<User>(context,listen: false).setGiftNftId(null);
                              setState(() {
                                tab=tabIndex;
                              });
                            },

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
                                  child: Text("Projects"),
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
                              SizedBox(
                                height: 33,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text("Gift your Customers"),
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ),
                ),
                if (tab == 0)
                  FutureBuilder(future: owned, builder:
                      (context, snapshot) {
                    if(snapshot.connectionState==ConnectionState.waiting&&user!.userOwnedNfts.isEmpty){
                      return const SliverToBoxAdapter(child:  Center(child: Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: CupertinoActivityIndicator(color: whiteColor,),
                      ),),);
                    }else {
                      return SliverList(delegate: SliverChildBuilderDelegate((context, index) =>
                          LayoutBuilder(
                              builder: (BuildContext context, BoxConstraints constraints) {
                                return InViewNotifierWidget(
                                  id: "${user?.userOwnedNfts[index].id}",
                                  builder: (BuildContext context, bool isInView, Widget? child) {
                                    return MarketPlace(owner: true,
                                      collectionName:
                                      "${user?.userOwnedNfts[index].collectionName}",
                                      name: "${user?.userOwnedNfts[index].name}",isLike: user?.userOwnedNfts[index].isLiked??false,
                                      // available_nft: "${partnerNft[index].price}",
                                      available_nft:
                                      "${user?.userOwnedNfts[index].available}/${user?.userOwnedNfts[index].noOfCopy} Available",
                                      like:
                                      "${user?.userOwnedNfts[index].likesCount}",
                                      image: "${user?.userOwnedNfts[index].file}",
                                      id: "${user?.userOwnedNfts[index].id}",
                                      media_type:
                                      "${user?.userOwnedNfts[index].mediaType}",
                                      multiple_nft:
                                      user?.userOwnedNfts[index].type == 2,
                                      auction: user?.userOwnedNfts[index]
                                          .voucher?['auction_type'] ==
                                          2,
                                      isPaly: loading==true?false:isInView,
                                      popupMenuButton: (string) {
                                        if(string=="1"){
                                          Provider.of<User>(context,listen: false).setGiftNftId("${user?.userOwnedNfts[index].id}");
                                          _tabController.animateTo(4);
                                          setState(() {
                                            tab=4;
                                          });
                                        }
                                      },
                                      onTap: ()async{
                                        setState(() {
                                          loading=true;
                                        });
                                        await  Provider.of<Nfts>(context,listen: false).getNftDetails("${user?.userOwnedNfts[index].id}");

                                        loading=await locator<NavigationService>().push(
                                            MaterialPageRoute(builder: (context) =>  const NftDetails(),settings: const RouteSettings(name: NftDetails.route)));
                                        setState(() {
                                        });
                                      },
                                      likeNft: ()async{
                                        Provider.of<User>(context,listen: false).likeNft(user?.userOwnedNfts[index].id,nftType: 2);
                                      },
                                    );
                                  },);
                              }),childCount:user?.userOwnedNfts.length));
                    }
                  },
                  ),
                if(tab==1) FutureBuilder(future: project, builder:
                    (context, snapshot) {
                  if(snapshot.connectionState==ConnectionState.waiting&&user!=null&&user.userCollection.isEmpty){
                    return const SliverToBoxAdapter(child:  Center(child: Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: CupertinoActivityIndicator(color: whiteColor,),
                    ),),);
                  }else {
                    return  SliverList(delegate: SliverChildBuilderDelegate((context, index) =>InkWell(
                      onTap: () {
                        locator<NavigationService>().push(
                            MaterialPageRoute(builder: (context) =>  UserCollection(collection:user.userCollection[index]),settings: const RouteSettings(name: UserCollection.route)));
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
                              //     image:  DecorationImage(
                              //         image: NetworkImage("${user!.userCollection[index].media}"),
                              //         fit: BoxFit.cover
                              //     ),
                              //     borderRadius: BorderRadius.circular(12)
                              // ),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: CachedNetworkImage(imageUrl: "${user!.userCollection[index].media_type=="IMAGE"?imageBaseUrl:gifBaseUrl}${user!.userCollection[index].media}",
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
                            Text(user.userCollection[index].name.toString(),style: w_700.copyWith(fontSize: 14),),
                          ],
                        ),
                      ),
                    ),childCount: user?.userCollection.length));
                  }
                },
                ),
                if(tab==2) FutureBuilder(future: activity, builder:
                    (context, snapshot) {
                  if(snapshot.connectionState==ConnectionState.waiting&&user!=null&&user.userActivity.isEmpty){
                    return const SliverToBoxAdapter(child:  Center(child: CupertinoActivityIndicator(color: whiteColor,),),);
                  }else {
                    return  SliverList(delegate: SliverChildListDelegate([
                      ListView.separated(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 17, vertical: 30),
                        separatorBuilder: (context, index) => const Divider(
                          color: blackBorderColor,
                        ),
                        itemCount: user!.userActivity.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) =>  Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children:[user.userActivity[index].type=="FOLLOW"?Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ActivityFollow(
                                    cover:user.userActivity[index].activityByCoverImage,
                                    image: user.userActivity[index].activityByProfilePic,
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
                                            "${user.userActivity[index].activityByFirstName} ${user.userActivity[index].activityByLastName}",
                                            style: w_600.copyWith(fontSize: 16),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            "${user.userActivity[index].activityByUserName} started following you",
                                            style: w_400.copyWith(fontSize: 12),
                                          ),

                                        ]),
                                  ),
                                  const Spacer(),

                                ]): user.userActivity[index].type=="NFT_CREATED"?
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ActivityNFTs(
                                    mediaType:user.userActivity[index].mediaType,
                                    image: user.userActivity[index].nftImage,
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
                                            user.userActivity[index].nftName.toString(),
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
                                  const Spacer(),
                                ]):
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ActivityNFTs(
                                    mediaType:user.userActivity[index].mediaType,
                                    image: user.userActivity[index].nftImage,
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
                                            user.userActivity[index].nftName.toString(),
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
                                                foregroundImage: CachedNetworkImageProvider("$imageBaseUrl${user.userActivity[index].activityByProfilePic??user.userActivity[index].activityByCoverImage}"),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                user.userActivity[index].activityByUserName??'',
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
                                                foregroundImage: CachedNetworkImageProvider("$imageBaseUrl${user.userActivity[index].activityOnProfilePic??user.userActivity[index].activityOnCoverImage}"),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                user.userActivity[index].activityOnUserName??'',
                                                style: w_600.copyWith(fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ]),
                                  ),
                                  const Spacer(),
                                ]),
                              Text(
                                "${DateTime.now().difference(DateTime.parse(user.userActivity[index].createdAt.toString())).inSeconds<60?
                                "${DateTime.now().difference(DateTime.parse(user.userActivity[index].createdAt.toString())).inSeconds.abs()} ${DateTime.now().difference(DateTime.parse(user.userActivity[index].createdAt.toString())).inSeconds.abs()==1?"sec":"secs"}":
                                DateTime.now().difference(DateTime.parse(user.userActivity[index].createdAt.toString())).inMinutes<60?
                                "${DateTime.now().difference(DateTime.parse(user.userActivity[index].createdAt.toString())).inMinutes.abs()} ${DateTime.now().difference(DateTime.parse(user.userActivity[index].createdAt.toString())).inMinutes.abs()==1?"mint":"mints"}":
                                DateTime.now().difference(DateTime.parse(user.userActivity[index].createdAt.toString())).inHours<24?
                                "${DateTime.now().difference(DateTime.parse(user.userActivity[index].createdAt.toString())).inHours.abs()} ${DateTime.now().difference(DateTime.parse(user.userActivity[index].createdAt.toString())).inHours.abs()==1?"hour":"hours"}":
                                "${DateTime.now().difference(DateTime.parse(user.userActivity[index].createdAt.toString())).inDays.abs()} ${DateTime.now().difference(DateTime.parse(user.userActivity[index].createdAt.toString())).inDays.abs()==1?"day":"days"}"
                                } ago",
                                style: w_400.copyWith(fontSize: 12),
                              ),
                            ])
                      ),
                    ]));
                  }
                },
                ),
                if(tab==3) FutureBuilder(future: community, builder:
                    (context, snapshot) {
                  if(snapshot.connectionState==ConnectionState.waiting&&user!=null&&user.userCommunity!.data.isEmpty){
                    return const SliverToBoxAdapter(child:  Center(child: CupertinoActivityIndicator(color: whiteColor,),),);
                  }else {
                    return SliverList(delegate: SliverChildListDelegate([
                      // Text("Community",style: w_700,),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text("Total community members : ${user?.userCommunity?.count}",style: w_500.copyWith(fontSize: 17),),
                      ),
             Padding(
               padding: const EdgeInsets.only(right: 8.0),
               child: Row(
                      mainAxisAlignment:MainAxisAlignment.end,
                 children: [
                   const Text("Hide community :"),
                   Switch(
                     activeColor:  Colors.green,
                     value:user?.is_community_hide??false, onChanged: (value) {
                    userFun.changeSwitch();
                   },),
                 ],
               ),
             ),
                      ListView.separated(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 17, vertical: 30),
                        separatorBuilder: (context, index) => const Divider(
                          color: blackBorderColor,
                        ),
                        itemCount: user!.userCommunity!.data.length,
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
                                  child: CachedNetworkImage(imageUrl: "$imageBaseUrl${user.userCommunity!.data[index].profilePic}",
                                    fit: BoxFit.cover,
                                    errorWidget: (context, url, error) {
                                      return Image.asset("assets/images/banner-image.png",fit: BoxFit.cover,);
                                    },placeholder: (context, imageProvider) {
                                      return const SizedBox(height:10,width:10,child: Center(child: CupertinoActivityIndicator(color: whiteColor,)));
                                    },),
                                ),
                              ),
                              const SizedBox(width: 10,),
                              Text(user.userCommunity!.data[index].firstName??"N/A",
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
                    ]));
                  }
                },
                ),
                if(tab==4)  SliverList(delegate: SliverChildListDelegate([
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      decoration: BoxDecoration(
                          border: Border.all(color: blackBorderColor),
                          borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Download the User’s List you have Gifted the NFTs to...",style: w_400.copyWith(fontSize: 14),textAlign: TextAlign.center,),
                          const SizedBox(height: 20,),
                          Button_2(buttonTxt: "Download", function: ()async{
                            setState(() {
                              loading=true;
                            });
                            loading=await  userFun.downloadHistory();
                            setState(() {});
                          })
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          border: Border.all(color: blackBorderColor),
                          borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Total no. of copies you can Gift",style: w_400.copyWith(fontSize: 14),textAlign: TextAlign.center,),
                          const SizedBox(height: 5,),
                          Text("${user!.nft_limit!-user.gifted_nft_count!}/${user.nft_limit}",style: w_700.copyWith(fontSize: 18),textAlign: TextAlign.center,),

                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      decoration: BoxDecoration(
                          border: Border.all(color: blackBorderColor),
                          borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Select From Existing Projects:",style: w_700.copyWith(fontSize: 14,color: whiteColor),textAlign: TextAlign.center,),
                          const SizedBox(height: 20,),
                         if( Provider.of<User>(context).giftNFtId!=null)
                          MarketPlace(owner: false,
                            giftFeature: true,
                            collectionName: user.userOwnedNfts[user.userOwnedNfts.indexWhere((element) => element.id==Provider.of<User>(context).giftNFtId)].collectionName,
                            image: user.userOwnedNfts[user.userOwnedNfts.indexWhere((element) => element.id==Provider.of<User>(context).giftNFtId)].file,
                            media_type: user.userOwnedNfts[user.userOwnedNfts.indexWhere((element) => element.id==Provider.of<User>(context).giftNFtId)].mediaType,
                            available_nft:
                            "${user.userOwnedNfts[user.userOwnedNfts.indexWhere((element) => element.id==Provider.of<User>(context).giftNFtId)].available}/${user.userOwnedNfts[user.userOwnedNfts.indexWhere((element) => element.id==Provider.of<User>(context).giftNFtId)].noOfCopy} Available",
name: user.userOwnedNfts[user.userOwnedNfts.indexWhere((element) => element.id==Provider.of<User>(context).giftNFtId)].name,
                          ),
                          Button_2(buttonTxt: "Select Project", function: (){
                            locator<NavigationService>().namedNavigateTo(MyProjects.route);
                          })
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text("Please Choose Upload Type:",style: w_400.copyWith(fontSize: 14,),),
                    ),

                    Container(height: 63,
                      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      decoration: BoxDecoration(
                          border: Border.all(color: blackBorderColor),
                          borderRadius: BorderRadius.circular(50)),
                      child: Stack(
                        children: [
                          AnimatedPositioned(
                            right: chooseType==0?MediaQuery.of(context).size.width*.45:0,
                            left:  chooseType==0?0:MediaQuery.of(context).size.width*.45,
                            duration: const Duration(milliseconds: 400),
                            child: Container(
                              height: 57,margin: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(56),
                                gradient: const LinearGradient(
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

                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 34.0,vertical: 20),
                            child: InkWell(
                              onTap: (){
                                setState(() {
                                  if(chooseType==0){
                                    chooseType=null;
                                  }else{chooseType=0;}
                                });
                              },
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Single Upload",style: w_500.copyWith(fontSize: 14),),
                                  Text("Bulk Upload",style: w_500.copyWith(fontSize: 14),),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      constraints: const BoxConstraints(minHeight: 210,minWidth: 335),
                      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      decoration: BoxDecoration(
                          border: Border.all(color: blackBorderColor),
                          borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric( vertical: 20),
                      child: Column(
                        children: [
                          if(chooseType==0    )...[         Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text("Enter the user's e-mail address in the field below",style: w_400.copyWith(fontSize: 14),textAlign: TextAlign.center,),
                          ),

                           ... _controller.map((e) => TextFieldForm(hintText: "Email, Username",
                                tfController: e,
                                postfix:IconButton(
                                    onPressed: () async{
                                      e.text= await  locator<NavigationService>().push(MaterialPageRoute(builder: (context) => QRScanner(back: true),));
                                    },
                                    icon:SvgPicture.asset("assets/icons/scanner.svg")),topPadding: 15),).toList()

                          ]else
                            Container(
                              height: 170,
                              width: 300,
                              color: Colors.black12,
                              padding: const EdgeInsets.only(bottom: 20),
                              child: DashedRect(color:blackBorderColor, strokeWidth: 1.5, gap: 10.0,borderRadius: 10,child:Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 24),
                                    child: Text("Drag and drop your file in this box to Bulk Upload CSV and TXT files are accepted",style: w_400.copyWith(fontSize: 12),textAlign: TextAlign.center,),
                                  ),
                                  Button_2(buttonTxt: FileName??"Choose File", function: ()async{
                                    Map? result= await userFun.pickFile();
                                    setState(() {
                                      Emails=(result?['email_list'])??[];
                                      FileName=result?['file_name'];
                                    });
                                  },horizontalPadding: 10,)

                                ],
                              )),
                            ),
                          Button(buttonTxt: "Gift",
                            active: _controller.any((element) => element.text!='')||FileName!=null,
                            function: ()async{
                            List emails=[];
                           if(chooseType==0){
                             for (var element in _controller) {
                               if(element.text!=''){
                                 loading=true;
                                 emails.add(element.text);
                               }
                             }
                           }else{
                             loading=true;
                             emails=  Emails;
                           }
                            setState(() {
                            });
                           if(emails.isNotEmpty){
                             Provider.of<User>(context,listen: false).sendNft(emails,null).then((_){
                              if(_)_controller.forEach((element)=>element.clear());
                               setState(() {
                                 loading=false;
                                 Emails=[];
                                 FileName=null;
                               });
                             });
                           }

                          },verticalPadding: 20,)
                        ],
                      ),
                    ),

                  ]))
              ],
            ),

          ),
        ),
      ),
    );
  }
}


