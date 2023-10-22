import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:nftwist/constant/style.dart';
import 'package:nftwist/services/locator.dart';
import 'package:nftwist/services/navigation_service.dart';
import 'package:nftwist/ui/Bottom%20Nav%20Bar/profile/followers_screen.dart';
import 'package:nftwist/ui/Bottom%20Nav%20Bar/profile/User%20profile/User%20Settings/user_settings.dart';
import 'package:nftwist/ui/Bottom%20Nav%20Bar/profile/edit_profile.dart';
import 'package:nftwist/ui/Bottom%20Nav%20Bar/search/qr_code.dart';
import 'package:nftwist/widget/gradient_txt.dart';
import 'package:nftwist/widget/loader_screen.dart';
import 'package:nftwist/widget/textfiels/textfield.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../../../constant/apiConstant.dart';
import '../../../../constant/color.dart';
import '../../../../provider/market_place_nfts.dart';
import '../../../../provider/other_profile.dart';
import '../../../../provider/user.dart';
import '../../../../widget/appBar.dart';
import '../../../../widget/button.dart';
import '../../../../widget/home_widget/market_place.dart';
import '../../../../widget/nft_list_tile.dart';
import '../../../../widget/success_screen.dart';
import '../../QR Scanner/qr_scanner.dart';
import '../../search/nftDetails.dart';
import '../Partner profile/select_project.dart';
import '../following.dart';
import '../membership_screen.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> with TickerProviderStateMixin {
  int tab = 0;
  final ScrollController _scrollController = ScrollController();
  late TabController _tabController ;
  TextEditingController _controller=TextEditingController();
  var owned;
  var activity;
  bool loading=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  _tabController=TabController(length: 3, vsync: this); 
  owned=Provider.of<User>(context, listen: false).getUserOwnedNfts();
  activity=Provider.of<User>(context, listen: false).getUserActivity();
 }




  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context).user;
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: RefreshIndicator(
        onRefresh: () async=>
        {
          Provider.of<User>(context, listen: false).getUserProfile(),
          Provider.of<User>(context, listen: false).getUserOwnedNfts(),
          Provider.of<User>(context, listen: false).getUserActivity(),
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
                  child: SizedBox(
                    height: 300,
                    child: Stack(
                      children: [
                        CachedNetworkImage(
                          imageUrl:"$imageBaseUrl${user?.cover_image}",
                          height: 240,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          placeholder: (context, imageProvider) {
                            return const SizedBox(height:10,width:10,child: Center(child: CupertinoActivityIndicator(color: whiteColor,)));
                          },
                          errorWidget: (context, url, error) {
                            return Image.asset("assets/images/john_doe_cover.png",fit: BoxFit.cover,);
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
                                    locator<NavigationService>()
                                        .namedNavigateTo(UserSettingScreen.route);
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
                                child: CachedNetworkImage(imageUrl: "$imageBaseUrl${user?.profile_pic}",
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) {
                                    return Image.asset("assets/images/banner-image.png",fit: BoxFit.cover,);
                                  },     placeholder: (context, imageProvider) {
                                  return const SizedBox(height:10,width:10,child: Center(child: CupertinoActivityIndicator(color: whiteColor,)));
                                },)),
                          ),
                        ),
                        Positioned(
                          left: 105,
                          top: 260,
                          child: InkWell(
                            onTap: () {
                              locator<NavigationService>().push(MaterialPageRoute(
                                  builder: (context) =>  QRCode(myQr: true,image: user?.profile_pic,name: user?.first_name,username: user?.user_name,qrString: "profile-${user?.id}/email${user?.email}/email1"),
                                  settings: const RouteSettings(name: QRCode.route)));
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
                  child:    Padding(
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
                                  Text(
                                    "${user?.first_name}",
                                    style: w_700.copyWith(fontSize: 20),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    width: 100,
                                    child: Text("@${user?.user_name}",
                                        style: w_600.copyWith(fontSize: 14),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              SizedBox(
                                  width: 160,
                                  child: Button_2(
                                    buttonTxt: "Edit Profile",
                                    function: () {
                                      locator<NavigationService>()
                                          .namedNavigateTo(EditProfile.route);
                                    },
                                    icon:
                                    SvgPicture.asset("assets/icons/edit.svg"),
                                  )),
                            ],
                          ),
                        ),
                          Text(
                            user!.bio??"",
                            style: w_400.copyWith(fontSize: 14),textAlign: TextAlign.start,
                          ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  locator<NavigationService>()
                                      .namedNavigateTo(FollowerScreen.route);
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
                                        "${user?.follower_count ?? 0}",
                                        style: w_600.copyWith(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  locator<NavigationService>()
                                      .namedNavigateTo(FollowingScreen.route);
                                },
                                child: Container(
                                  height: 68,
                                  margin:
                                  const EdgeInsets.only(top: 16, bottom: 5),
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
                                        "${user?.following_count ?? 0}",
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
                                      "${user.user_nft_count ?? 0}",
                                      style: w_600.copyWith(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 20, top: 8),
                          decoration: BoxDecoration(
                              border: Border.all(color: blackBorderColor),
                              borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Memberships"),
                              const SizedBox(
                                height: 8,
                              ),
                              GridView.builder(
                                itemCount: user?.memership_count,
                                padding: EdgeInsets.zero,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisSpacing: 5,
                                    mainAxisSpacing: 5,
                                    crossAxisCount: 4),
                                itemBuilder: (context, index) => InkWell(
                                  onTap: () async {
                                    setState(() {
                                      loading=true;
                                    });
                                    loading=await  Provider.of<OtherUserProfile>(context,listen: false).getOtherUserProfile(id: user.memberships[index]['_id'],user_id:user.id);
                                    setState(() {
                                      print("After---$loading");
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: blackColor,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 40,
                                          width: 40,
                                          child: ClipOval(
                                            child: Image(
                                                image: NetworkImage(
                                                    "$imageBaseUrl${user.memberships[index]["profile_pic"]}"),
                                                fit: BoxFit.cover,errorBuilder: (context, error, stackTrace) => Image.asset("assets/images/banner-image.png",fit:BoxFit.cover,),),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          user?.memberships[index]['first_name']??user?.memberships[index]['user_name'],
                                          style: w_500.copyWith(fontSize: 12),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              InkWell(
                                onTap: () {
                                  locator<NavigationService>()
                                      .namedNavigateTo(MemberShipScreen.route);
                                },
                                child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: GradientTxt(
                                      txt: "See all",
                                      style: w_600.copyWith(fontSize: 12),
                                    )),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                 SliverToBoxAdapter(
                  child:    SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Material(
                      color: blackColor,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: TabBar(
                            dividerColor: Colors.transparent,
                            controller: _tabController,
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
                                tab = tabIndex;
                              });
                            },
                            labelPadding:
                            const EdgeInsets.only(left: 10, right: 10),
                            tabs: const [
                              SizedBox(
                                height: 33,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text("Owned"),
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
                                  child: Text("Gift your NFTs"),
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
        if(snapshot.connectionState==ConnectionState.waiting&&user.userOwnedNfts.isEmpty){
          return const SliverToBoxAdapter(child:  Center(child: Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: CupertinoActivityIndicator(color: whiteColor,),
          ),),);
        }else {
          return SliverList(delegate: SliverChildBuilderDelegate((context, index) =>
              LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return InViewNotifierWidget(
                      id: "${user.userOwnedNfts[index].id}",
                      builder: (BuildContext context, bool isInView, Widget? child) {
                        return MarketPlace(owner: true,
                          collectionName:
                          "${user.userOwnedNfts[index].collectionName}",isLike: user.userOwnedNfts[index].isLiked??false,
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
                          popupMenuButton: (string) {
                            if(string=="1"){
                              Provider.of<User>(context,listen: false).setGiftNftId("${user.userOwnedNfts[index].id}");
                              _tabController.animateTo(2);
                              setState(() {
                                tab=2;
                              });
                            }
                          },
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
                            Provider.of<User>(context,listen: false).likeNft(user.userOwnedNfts[index].id,nftType: 2);
                          },
                        );
                      },);
                  }),childCount:user.userOwnedNfts.length));
        }
    },
    ),

                if (tab == 1)

                  FutureBuilder(future: activity, builder:
                      (context, snapshot) {
                    if(snapshot.connectionState==ConnectionState.waiting&&user.userActivity.isEmpty){
                      return const SliverToBoxAdapter(child:  Center(child: Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: CupertinoActivityIndicator(color: whiteColor,),
                      ),),);
                    }else {
                      return SliverList(delegate: SliverChildListDelegate([
                        ListView.separated(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 17, vertical: 30),
                          separatorBuilder: (context, index) => const Divider(
                            color: blackBorderColor,
                          ),
                          itemCount: user.userActivity.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                           itemBuilder: (context, index) =>
                      Column(
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
                if (tab == 2)
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Provider.of<User>(context).giftNFtId!=null?MarketPlace(owner: false,
                          giftFeature: true,
                          collectionName: user.userOwnedNfts[user.userOwnedNfts.indexWhere((element) => element.id==Provider.of<User>(context).giftNFtId)].collectionName,
                          image: user.userOwnedNfts[user.userOwnedNfts.indexWhere((element) => element.id==Provider.of<User>(context).giftNFtId)].file,
                          media_type: user.userOwnedNfts[user.userOwnedNfts.indexWhere((element) => element.id==Provider.of<User>(context).giftNFtId)].mediaType,
                          available_nft:
                          "${user.userOwnedNfts[user.userOwnedNfts.indexWhere((element) => element.id==Provider.of<User>(context).giftNFtId)].available}/${user.userOwnedNfts[user.userOwnedNfts.indexWhere((element) => element.id==Provider.of<User>(context).giftNFtId)].noOfCopy} Available",
// name: userCollection[index].nft[ind]['description'],
                        ):InkWell(
                          onTap: () async {
                            final id=await showCupertinoModalPopup(
                              context: context, builder: (context) {
                              return Scaffold(
                                appBar: const CustomAppBar(title: "Select NFT"),
                                body: ListView.builder(
                                  itemCount:user.userOwnedNfts==null?0: user.userOwnedNfts.length,
                                  itemBuilder: (context, ind) {
                                    return MarketPlace(owner: false,
                                      giftFeature: true,
                                      collectionName: user.userOwnedNfts[ind].collectionName,
                                      image: user.userOwnedNfts[ind].file,
                                      media_type: user.userOwnedNfts[ind].mediaType,
                                      available_nft:
                                      "${user.userOwnedNfts[ind].available}/${user.userOwnedNfts[ind].noOfCopy} Available",
                                      onTap: () {
                                        locator<NavigationService>().goBack(data:user.userOwnedNfts[ind].id );
                                      },
// name: userCollection[index].nft[ind]['description'],
                                    );
                                  },),
                              );
                            },);
                            Provider.of<User>(context,listen: false).setGiftNftId(id);
                            // locator<NavigationService>().goBack();
                          },
                          child: Container(
                            constraints:
                            const BoxConstraints(minHeight: 372, minWidth: 335),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 16),
                            decoration: BoxDecoration(
                                border: Border.all(color: blackBorderColor),
                                borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Center(
                                child: Text(
                                  "Select NFTs from Owned Section you want to gift",
                                  style: w_700.copyWith(fontSize: 14),
                                  textAlign: TextAlign.center,
                                )),
                          ),
                        ),
                        Container(
                          constraints:
                          const BoxConstraints(minHeight: 210, minWidth: 335),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 16),
                          decoration: BoxDecoration(
                              border: Border.all(color: blackBorderColor),
                              borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Text(
                                  "Enter the user's e-mail address in the field below",
                                  style: w_400.copyWith(fontSize: 14),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              TextFieldForm(tfController: _controller,
                                hintText: "Email, Username",
                                postfix: IconButton(
                                    onPressed: ()async{
                                      _controller.text= await  locator<NavigationService>().push(MaterialPageRoute(builder: (context) => const QRScanner(back: true),));
                                    },
                                    icon: SvgPicture.asset(
                                        "assets/icons/scanner.svg")),
                                topPadding: 15,
                                bottomPadding: 20,
                              ),
                              Button(buttonTxt: "Send", function: () {
                                setState(() {
                                  loading=true;
                                });
                                if(_controller.text!=''){
                                  Provider.of<User>(context,listen: false).sendNft(_controller.text,null).then((_){
                                    _controller.clear();
                                    setState(() {
                                      loading=false;
                                    });
                                  });
                                }


                              })
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}




