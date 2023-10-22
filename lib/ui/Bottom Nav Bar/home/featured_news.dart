import 'package:flutter/material.dart';
import 'package:nftwist/constant/color.dart';
import 'package:nftwist/constant/style.dart';
import 'package:nftwist/widget/appBar.dart';

import '../../../widget/gradient_txt.dart';

class FeaturedNews extends StatelessWidget {
  const FeaturedNews({Key? key}) : super(key: key);
  static const route = "featured_news";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Image.network(
          "https://fiverr-res.cloudinary.com/images/q_auto,f_auto/gigs/222747949/original/541f4419b48cd87e1e32f058ce3ea96ab0c524ea/draw-nft-artworks-and-designs.jpg",
          height: 350,
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width,
        ),
        const CustomAppBar(isBackButton: true, appBarColor: Colors.transparent),
        //   ListView(
        // children: [
        Container(
          margin: const EdgeInsets.only(top: 350),
          color: appColor,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 20, 20, 8),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "Featured News 1",
                style: w_700.copyWith(fontSize: 20, color: whiteColor),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 20, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Embeded Link:",
                      style: w_400.copyWith(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                    GradientTxt(
                      txt: " N/A",
                      style: w_600.copyWith(fontSize: 14),
                    )
                  ],
                ),
              ),
              Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam porta ac enim quis pellentesque. Praesent rhoncus nisl id eros porttitor, ut vulputate metus gravida. Aliquam ex quam, eleifend sed bibendum a, vulputate vel orci. Duis non viverra dolor. Fusce lacinia, ligula a finibus venenatis, risus sapien dignissim enim, quis mattis arcu augue nec tellus. Donec eget quam laoreet, blandit tellus at, faucibus dui. Etiam non odio eu metus varius sodales.",
                style: w_400.copyWith(fontSize: 14),
              ),
              //     Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam porta ac enim quis pellentesque. Praesent rhoncus nisl id eros porttitor, ut vulputate metus gravida. Aliquam ex quam, eleifend sed bibendum a, vulputate vel orci. Duis non viverra dolor. Fusce lacinia, ligula a finibus venenatis, risus sapien dignissim enim, quis mattis arcu augue nec tellus. Donec eget quam laoreet, blandit tellus at, faucibus dui. Etiam non odio eu metus varius sodales.",
              // style:mediumTxt.copyWith(fontSize: 14),),
              //     Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam porta ac enim quis pellentesque. Praesent rhoncus nisl id eros porttitor, ut vulputate metus gravida. Aliquam ex quam, eleifend sed bibendum a, vulputate vel orci. Duis non viverra dolor. Fusce lacinia, ligula a finibus venenatis, risus sapien dignissim enim, quis mattis arcu augue nec tellus. Donec eget quam laoreet, blandit tellus at, faucibus dui. Etiam non odio eu metus varius sodales.",
              // style:mediumTxt.copyWith(fontSize: 14),),
            ]),
          ),
        ),
        //   ],
        // ),
      ]),
    );
  }
}
