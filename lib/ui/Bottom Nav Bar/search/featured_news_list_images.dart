import 'package:flutter/material.dart';
import 'package:nftwist/constant/style.dart';

class SearchFeaturedNewsList extends StatefulWidget {
  const SearchFeaturedNewsList({Key? key}) : super(key: key);

  @override
  State<SearchFeaturedNewsList> createState() => _SearchFeaturedNewsListState();
}

class _SearchFeaturedNewsListState extends State<SearchFeaturedNewsList> {
  @override
  Widget build(BuildContext context) {
    final List data = [
      {"image":'assets/images/partner_one.png', "text":"Featured News 1",},
      {"image":'assets/images/abstract-oil-shape-2021-08-26-15-42-43-utc 2-3.png', "text":"Featured News 2",},
      {"image":'assets/images/abstract-oil-shape-2021-08-26-15-42-43-utc 2-3.png', "text":"Featured News 3",},
      {"image":'assets/images/bitcoin-illustration-neon-splash.png', "text":"Featured News 4",},
      {"image":'assets/images/abstract-oil-shape-2021-08-26-15-42-43-utc 2-3.png', "text":"Featured News 5",},
      {"image":'assets/images/abstract-oil-shape-2021-08-26-15-42-43-utc 2-3.png', "text":"Featured News 6",},
      {"image":'assets/images/abstract-oil-shape-2021-08-26-15-42-43-utc 2-3.png', "text":"Featured News 7",},
      {"image":'assets/images/bitcoin-illustration-neon-splash.png', "text":"Featured News 8",},
      {"image":'assets/images/abstract-oil-shape-2021-08-26-15-42-43-utc 2-3.png', "text":"Featured News 9",},
      {"image":'assets/images/abstract-oil-shape-2021-08-26-15-42-43-utc 2-3.png', "text":"Featured News 10",},
    ];

    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
         if (index % 4 == 1) {
          return Stack(
            children: [
              Container(
                height: 200,width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    data[index]["image"],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 12,left: 32,
                  child: Text(data[index]["text"],style: w_500,))
            ],
          );
        } else if (index % 4 == 3) {
          // Every fourth index, two images
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 12),
                        height: 157,width: MediaQuery.of(context).size.width,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            data[index]["image"],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: 24,left: 32,
                          child: Text(data[index]["text"],style: w_500,))
                    ],
                  )
                ),
                const SizedBox(width: 20,),
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 12),
                        height: 157,width: MediaQuery.of(context).size.width,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            data[index]["image"],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: 24,left: 32,
                          child: Text(data[index]["text"],style: w_500,))
                    ],
                  )
                ),
              ],
            ),
          );
        } else {
          // Other indices, not displayed
          return Container();
        }
      },
    );
  }
}
