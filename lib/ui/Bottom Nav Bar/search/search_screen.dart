import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nftwist/provider/search_data.dart';
import 'package:nftwist/provider/user.dart';
import 'package:nftwist/widget/appBar.dart';
import 'package:nftwist/widget/loader_screen.dart';
import 'package:nftwist/widget/textfiels/textfield.dart';
import 'package:provider/provider.dart';

import '../../../constant/apiConstant.dart';
import '../../../constant/color.dart';
import '../../../constant/style.dart';
import '../../../provider/market_place_nfts.dart';
import '../../../provider/other_profile.dart';
import '../../../services/locator.dart';
import '../../../services/navigation_service.dart';
import '../../../widget/gust_login_alert.dart';
import '../../../widget/nft_list_tile.dart';
import 'nftDetails.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  static const route = 'search_screen';
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool loading = false;
  bool screenLoading = false;
  var listdata;
  Timer? _debounce;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchController.addListener(() async {
      setState(() {
        if (_searchController.text.trim() != '') {
          loading = true;
          if (_debounce?.isActive ?? false) _debounce?.cancel();
          _debounce = Timer(const Duration(seconds: 1), () {
            listdata = Provider.of<Search>(context, listen: false)
                .getHomeScreenDate(string: _searchController.text.trim());
            loading = false;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var partnerNft = Provider.of<Search>(context).partnerNFTs;
    var partner = Provider.of<Search>(context).partners;
    var user=Provider.of<User>(context).user;
    return DefaultTabController(
      length: 2,
      child: LoaderPage(
        loading: screenLoading,
        child: Scaffold(
          appBar: CustomAppBar(
            toolbarHeight: 100,
            // data: Provider.of<Search>(context, listen: false).clearData(),
            action: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 36.0),
                  child: TextFieldForm(
                    hintText: "Search",
                    tfController: _searchController,
                  ),
                ),
              ),
            ],
            bottom: TabBar(
              dividerColor: Colors.transparent,
              indicatorColor: whiteColor,
              indicatorWeight: 1,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorPadding: const EdgeInsets.symmetric(horizontal: 10),
              labelStyle: w_500.copyWith(
                fontSize: 14,
              ),
              labelColor: whiteColor2,
              unselectedLabelColor: whiteColor2,
              splashFactory: NoSplash.splashFactory,
              tabs: const [
                SizedBox(
                  height: 33,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text("User/Partner"),
                  ),
                ),
                SizedBox(
                  height: 33,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text("Nfts"),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              FutureBuilder(
                future: listdata,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      loading == true) {
                    return const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: whiteColor,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text(
                        "Error please try again after some time",
                      ),
                    );
                  } else {
                    if (partner.isEmpty) {
                      return const Center(
                        child: Text(
                          "No Partner Found.",
                        ),
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      itemCount: partner.length,
                      itemBuilder: (context, index) => ListTile(
                        onTap: () async {

    if(user==null){
    alert(context);
    }else {
      setState(() {
        screenLoading = true;
      });
      Provider.of<OtherUserProfile>(context, listen: false).getOtherUserProfile(
          id: partner[index].sId, user_id: user?.id).then((value) {
        setState(() {
          screenLoading = false;
        });
      });
    }
                        },
                          leading: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                width: 55,
                                height: 90,
                                imageUrl:
                                    '$imageBaseUrl${partner[index].profilePic}',
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
                          title: Text(
                            "${partner[index].firstName} ${partner[index].lastName}",
                            style: w_600.copyWith(fontSize: 14),
                          ),
                          subtitle: Row(
                            children: [
                              Text(
                                "${partner[index].following_count} Following  ${partner[index].follower_count} Followers",
                                style: w_400.copyWith(fontSize: 12),
                              )
                            ],
                          )),
                    );
                  }
                },
              ),
              FutureBuilder(
                  future: listdata,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting ||
                        loading == true) {
                      return const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: whiteColor,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text(
                          "Error please try again after some time",
                        ),
                      );
                    } else {
                      if (partnerNft.isEmpty) {
                        return  const Center(
                          child: Text(
                            "No Partner Nft's Found.}",
                          ),
                        );
                      } else {
                        return ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 32,vertical: 20),
                            itemCount: partnerNft.length,
                            itemBuilder:  (context, index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () async {
                                  setState(() {
                                    screenLoading=true;
                                  });
                                  await  Provider.of<Nfts>(context,listen: false).getNftDetails("${partnerNft[index].sId}");

                                  screenLoading=await locator<NavigationService>().push(
                                      MaterialPageRoute(builder: (context) =>  const NftDetails(),settings: const RouteSettings(name: NftDetails.route)));
                                  setState(() {
                                  });
                                },
                                child: Row(
                          children: [
                                SizedBox(
                                  height:70,
                                  width: 70,
                                  child: ActivityNFTs(
                                    mediaType: partnerNft[index].mediaType,
                                    image: partnerNft[index].file,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          partnerNft[index].name.toString(),
                                          style: w_600.copyWith(fontSize: 16),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Text(partnerNft[index].description??'${partnerNft[index].firstName} ${partnerNft[index].lastName}',  style: w_400.copyWith(fontSize: 12),
                                        ),
                                      ]),
                                ),
                          ],
                        ),
                              ),
                            ));
                      }
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
