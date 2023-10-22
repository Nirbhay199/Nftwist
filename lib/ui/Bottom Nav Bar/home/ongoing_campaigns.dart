import 'package:flutter/material.dart';
import 'package:nftwist/constant/color.dart';
import 'package:nftwist/provider/on_going.dart';
import 'package:nftwist/widget/appBar.dart';
import 'package:nftwist/widget/home_widget/ongoing_campaign.dart';
import 'package:nftwist/widget/loader_screen.dart';
import 'package:provider/provider.dart';

import '../../../provider/market_place_nfts.dart';
import '../../../services/locator.dart';
import '../../../services/navigation_service.dart';
import '../search/collection_details.dart';
import '../search/nftDetails.dart';

class OngoingCampaigns extends StatefulWidget {
  const OngoingCampaigns({Key? key}) : super(key: key);
  static const route = 'ongoing_campaign';

  @override
  State<OngoingCampaigns> createState() => _OngoingCampaignsState();
}

class _OngoingCampaignsState extends State<OngoingCampaigns> {
  Future<Object?>? _future;
  bool loading=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future=Provider.of<OnGoingCampaigns>(context, listen: false).getOnGoingCampaign();
  }

  @override
  Widget build(BuildContext context) {
    var onGoingCampaign =
        Provider.of<OnGoingCampaigns>(context).onGoingCampaign;
    return Scaffold(
      appBar: const CustomAppBar(title: "Ongoing Campaigns"),
      body: LoaderPage(
        loading: loading,
        child: FutureBuilder(
          future: _future,
          builder: (context, snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(color: whiteColor2,),);
          }else{
            if(onGoingCampaign.isEmpty){
              return const Center(child: Text("NO DATA"),);
            }else{
              return ListView.builder(
              padding: EdgeInsets.zero,
            itemCount: onGoingCampaign.length,
            itemBuilder: (context, index) => OngoingCampaign(
            title: onGoingCampaign[index].name.toString(),
            mediaType:onGoingCampaign[index].media_type??'',
            image: onGoingCampaign[index].media.toString(),
              onTap:onGoingCampaign[index].nft==null?null:()async{
                locator<NavigationService>().push(
                    MaterialPageRoute(builder: (context) =>  UserCollection(collection:onGoingCampaign[index]),settings: const RouteSettings(name: UserCollection.route)));
           },
            description: onGoingCampaign[index].description.toString(),
            totalAvailableNfts: onGoingCampaign[index].total_available_nfts,
            totalNfts: onGoingCampaign[index].total_nfts,
            ),
            );
            }
          }
        },),
      )
    );
  }
}
