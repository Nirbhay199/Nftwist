import 'package:flutter/material.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:nftwist/services/locator.dart';
import 'package:nftwist/services/navigation_service.dart';
import 'package:nftwist/ui/Bottom%20Nav%20Bar/home/featured_news.dart';
import 'package:nftwist/widget/appBar.dart';
import 'package:nftwist/widget/home_widget/news_feed.dart';
import 'package:nftwist/widget/loader_screen.dart';
import 'package:provider/provider.dart';

import '../../../provider/homeModule.dart';
import '../../../provider/market_place_nfts.dart';
import '../search/nftDetails.dart';
class NewsFeeds extends StatefulWidget {
  const NewsFeeds({Key? key}) : super(key: key);
static const route='news_feed';

  @override
  State<NewsFeeds> createState() => _NewsFeedsState();
}

class _NewsFeedsState extends State<NewsFeeds> {
  bool loading=false;
  @override
  Widget build(BuildContext context) {
    var newFeeds = Provider.of<Nfts>(context, listen: true);
    return Scaffold(
      appBar: const CustomAppBar(title: "Newsfeed"),
      body:LoaderPage(
        loading: loading,
        child: InViewNotifierList(
          itemCount:newFeeds.newsFeeds.length ,
          builder: (BuildContext context, int index) {
          return LayoutBuilder(builder:  (BuildContext context, BoxConstraints constraints) {
            return InViewNotifierWidget(id: "77${newFeeds.newsFeeds[index].id}", builder: (context, isInView, child) {
              return NewsFeed(
                name: newFeeds.newsFeeds[index].name,createAt:  newFeeds.newsFeeds[index].created_at,
                collection_name: newFeeds.newsFeeds[index].collection_name,
                collection_symbol: newFeeds.newsFeeds[index].collection_symbol,
                comment_count: newFeeds.newsFeeds[index].comment_count,
                description: newFeeds.newsFeeds[index].description,
                first_name: newFeeds.newsFeeds[index].first_name,
                is_private: newFeeds.newsFeeds[index].is_private,
                last_name: newFeeds.newsFeeds[index].last_name,
                likes_count: newFeeds.newsFeeds[index].likes_count,
                profile_pic: newFeeds.newsFeeds[index].profile_pic,
                user_name: newFeeds.newsFeeds[index].user_name,
                media_type: newFeeds.newsFeeds[index].media_type,
                file: newFeeds.newsFeeds[index].file,
                isPaly: loading==true?false:isInView,
                onTap: ()async{
                  setState(() {
                    loading=true;
                  });
                  await Provider.of<Nfts>(context,listen: false).getNftDetails(newFeeds.newsFeeds[index].id);
                  loading=await locator<NavigationService>().push(
                      MaterialPageRoute(builder: (context) =>  const NftDetails(),settings: const RouteSettings(name: NftDetails.route)));
                  setState(() {
                  });      },
              );
            },);
          },);
        }, isInViewPortCondition:
            (double deltaTop, double deltaBottom, double viewPortDimension) {
          return deltaTop < (0.5 * viewPortDimension) &&
              deltaBottom > (0.5 * viewPortDimension);
        },),
      ),
    );
  }
}
