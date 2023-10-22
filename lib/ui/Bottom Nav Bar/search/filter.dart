import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nftwist/constant/color.dart';
import 'package:nftwist/constant/style.dart';
import 'package:nftwist/provider/app_content.dart';
import 'package:nftwist/services/locator.dart';
import 'package:nftwist/services/navigation_service.dart';
import 'package:nftwist/widget/appBar.dart';
import 'package:nftwist/widget/button.dart';
import 'package:nftwist/widget/loader_screen.dart';
import 'package:nftwist/widget/nft_list_tile.dart';
import 'package:provider/provider.dart';

import '../../../constant/apiConstant.dart';
import '../../../provider/market_place_nfts.dart';
import 'nftDetails.dart';

class Filter extends StatefulWidget {
  final int type;
  const Filter({Key? key, required this.type}) : super(key: key);
  static const route = "filter";

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  // final List<String> categories = [
  //   'All',
  //   'Music',
  //   'Metaverses',
  //   'Games',
  //   'Photography',
  //   'Art',
  //   'Other',
  //   'Manual',
  // ];
  // final List<String> projects = [
  //   'Monkey Collection',
  //   'Monkey Collection',
  //   'Monkey Collection',
  //   'Monkey Collection',
  // ];
  // final List<String> Collections = [
  //   'All',
  //   'Music',
  //   'Metaverses',
  //   'Games',
  // ];
  // final List<String> sortType = [
  //   'Recently Added',
  //   'Price: Low - High',
  //   'Price: High - Low',
  //   'Hot Projects',
  // ];
  // bool showCategory = false;
  bool showCollection = false;
  // bool showPrice = false;
  // bool showSort = false;
  bool loading = false;
  List<String> selectedId = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      Future.delayed(Duration.zero).then((value) => selectedId =
          Provider.of<Nfts>(context, listen: false).collection ?? []);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List collections =
        Provider.of<AppContents>(context).collections!.data;
    return LoaderPage(
      loading: loading,
      child: Scaffold(
        appBar: const CustomAppBar(title: "Filter"),
        bottomNavigationBar: Container(
          height: 89 + MediaQuery.of(context).viewPadding.bottom,
          color: blackColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.only(left: 25)),
                  onPressed: () {
                    setState(() {
                      selectedId = [];
                    });
                  },
                  child: Text("Clear All",
                      style: w_600.copyWith(
                          fontSize: 16,
                          color: textColor,
                          decoration: TextDecoration.underline))),
              SizedBox(
                width: 178,
                child: Button(
                    buttonTxt: "Apply",
                    function: () {
                      setState(() {
                        loading = true;

                        Provider.of<Nfts>(context, listen: false)
                            .setFilter(selectedId)
                            .then((_) {
                          Provider.of<Nfts>(context, listen: false)
                              .getPartnerNFTs()
                              .then((_) {
                            locator<NavigationService>().goBack();
                            loading = false;
                          });
                        });
                      });
                    }),
              )
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            children: [
              /*  if (widget.type == 0) ...[
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Category",
                        style: w_600.copyWith(fontSize: 16),
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              showCategory = !showCategory;
                            });
                          },
                          icon: Icon(
                            showCategory
                                ?CupertinoIcons.chevron_up:CupertinoIcons.chevron_down,
                            color: whiteColor2,
                          ))
                    ],
                  ),
                ),
                if (showCategory)
                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: collections.map((category) {
                      return   Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            Checkbox(
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2),),

                              // visualDensity:
                              // VisualDensity(horizontal: -4, vertical: -4),
                              value: false,
                              onChanged: (newValue){
                                //Do Something When Value Changes to True Or False

                              },
                            ),

                            ActivityNFTs(image:category.media,mediaType:category.mediaType,height: 30,width: 30,borderRadius: 60,),
                            const SizedBox(width: 10,),
                            Text(
                              category.name,
                              style: w_400.copyWith(fontSize: 14),
                            ),

                          ]
                      );
                    }).toList(),
                  ),

                const Divider(color: blackBorderColor,),
           ],*/

              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.type == 0 ? "Collection" : "Projects",
                      style: w_600.copyWith(fontSize: 16),
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            showCollection = !showCollection;
                          });
                        },
                        icon: Icon(
                          showCollection
                              ? CupertinoIcons.chevron_up
                              : CupertinoIcons.chevron_down,
                          color: whiteColor2,
                        ))
                  ],
                ),
              ),
              if (showCollection)
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: collections.map((collection) {
                      return Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2),
                              ),

                              // visualDensity:
                              // VisualDensity(horizontal: -4, vertical: -4),
                              value: selectedId.contains(collection.id),
                              checkColor: pinkColor, activeColor: blackColor2,
                              onChanged: (newValue) {
                                setState(() {
                                  if (selectedId.contains(collection.id)) {
                                    selectedId.remove(collection.id);
                                  } else {
                                    selectedId.add(collection.id);
                                  }
                                });
                              },
                            ),
                            ActivityNFTs(
                              image: collection.media,
                              mediaType: collection.mediaType,
                              height: 30,
                              width: 30,
                              borderRadius: 60,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              collection.name,
                              style: w_400.copyWith(fontSize: 14),
                            ),
                          ]);
                    }).toList()),
              /*         const Divider(color: blackBorderColor,),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Price Range",
                      style: w_600.copyWith(fontSize: 16),
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            showPrice = !showPrice;
                          });
                        },
                        icon: Icon(
                          showPrice
                              ? CupertinoIcons.chevron_up:CupertinoIcons.chevron_down,
                          color: whiteColor2,
                        ))
                  ],
                ),
              ),
              if (showPrice) ...[
                const SizedBox(
                  height: 12,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(38),
                      border:
                          Border.all(width: 2, color: const Color(0xffE6E6E6))),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Matic"),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: whiteColor,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(38),
                            border: Border.all(
                                width: 2, color: const Color(0xffE6E6E6))),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 14),
                        child: const Text("From"),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(38),
                            border: Border.all(
                                width: 2, color: const Color(0xffE6E6E6))),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 14),
                        child: const Text("To"),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12,)
              ],
              const Divider(color: blackBorderColor,),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Sort",
                      style: w_600.copyWith(fontSize: 16),
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            showSort = !showSort;
                          });
                        },
                        icon: Icon(
                          showSort
                              ?CupertinoIcons.chevron_up:CupertinoIcons.chevron_down,
                          color: whiteColor2,
                        ))
                  ],
                ),
              ),
              if (showSort)
                Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: sortType.map((sort) {
                    return Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Radio(
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2),),
                            // visualDensity:
                            // VisualDensity(horizontal: -4, vertical: -4),
                            value: false,
                            onChanged: (newValue){
                              //Do Something When Value Changes to True Or False

                            }, groupValue: '1',
                          ),
                          const SizedBox(
                              height: 24, width: 24, child: CircleAvatar()),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            sort,
                            style: w_400.copyWith(fontSize: 14),
                          ) , ]);
                  }).toList(),
                ),*/
            ],
          ),
        ),
      ),
    );
  }
}
