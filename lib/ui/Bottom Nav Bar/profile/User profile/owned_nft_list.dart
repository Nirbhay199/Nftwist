import 'package:flutter/material.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:nftwist/provider/user.dart';
import 'package:nftwist/widget/appBar.dart';
import 'package:nftwist/widget/loader_screen.dart';
import 'package:provider/provider.dart';
import '../../../../services/locator.dart';
import '../../../../services/navigation_service.dart';
import '../../../../widget/home_widget/market_place.dart';
import '../../../../widget/success_screen.dart';
class OwnedNfts extends StatefulWidget {
  final int type;
  final String? email ;
  const OwnedNfts({super.key,this.email, this.type=0});
static const route="owned_nft";

  @override
  State<OwnedNfts> createState() => _OwnedNftsState();
}

class _OwnedNftsState extends State<OwnedNfts> {
  bool loading=false;
  @override
  Widget build(BuildContext context) {
    var user=Provider.of<User>(context).user;
    return Scaffold(
      appBar: const CustomAppBar(),
      body:LoaderPage(
        loading: loading,
        child: InViewNotifierList(builder: (context, index) {
          return  LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return InViewNotifierWidget(
                  id: "${user!.userOwnedNfts[index].id}",
                  builder: (BuildContext context, bool isInView, Widget? child) {
                    return MarketPlace(owner: true,giftFeature: true,
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
                      isPaly:isInView,
                      onTap: () async {
                        setState(() {
                          loading=true;
                        });
                        if(widget.type==0) {
                          Provider.of<User>(context, listen: false).sendNft(
                              user.user_type == 2 ? [widget.email] : widget
                                  .email, user.userOwnedNfts[index].id).then((
                              _) {
                            setState(() {
                              loading = _;
                            });
                          });
                        }else{
                          Provider.of<User>(context,listen: false).addNftToRule("${user.userOwnedNfts[index].id}");
                        }
                        },
                    );
                  },);
              });
        }, isInViewPortCondition: (deltaTop, deltaBottom, viewPortDimension) {
          return deltaTop < (0.5 * viewPortDimension) &&
              deltaBottom > (0.5 * viewPortDimension);
        },
            itemCount: user?.userOwnedNfts.length),
      )

    );
  }
}
