import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nftwist/constant/style.dart';
import 'package:nftwist/services/locator.dart';
import 'package:nftwist/services/navigation_service.dart';
import 'package:nftwist/ui/Bottom%20Nav%20Bar/profile/followers_screen.dart';
import 'package:nftwist/ui/Bottom%20Nav%20Bar/profile/User%20profile/User%20Settings/user_settings.dart';
import 'package:nftwist/ui/Bottom%20Nav%20Bar/search/qr_code.dart';
import 'package:nftwist/widget/gradient_txt.dart';
import 'package:nftwist/widget/textfiels/textfield.dart';

import '../../../../constant/color.dart';
import '../../../../widget/appBar.dart';
import '../../../../widget/button.dart';
import '../../../../widget/home_widget/market_place.dart';
import '../following.dart';
import '../membership_screen.dart';

class OtherUserProfile extends StatefulWidget {
  const OtherUserProfile({Key? key}) : super(key: key);
static const route ='other_user_profile';
  @override
  State<OtherUserProfile> createState() => _OtherUserProfileState();
}

class _OtherUserProfileState extends State<OtherUserProfile> {
  int tab=0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 300,
              child: Stack(
                children: [
                  Image.network(
                    "https://fiverr-res.cloudinary.com/images/q_auto,f_auto/gigs/222747949/original/541f4419b48cd87e1e32f058ce3ea96ab0c524ea/draw-nft-artworks-and-designs.jpg",
                    height: 240,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                  ),
                  CustomAppBar(
                      appBarColor: Colors.transparent,
                      action: [
                        InkWell(
                            onTap: () {
                            },
                            child: Container(
                                margin: const EdgeInsets.only(right: 20),
                                height: 25,
                                width: 25,
                                padding: const EdgeInsets.all(6),
                                decoration: const BoxDecoration(
                                  color: whiteColor,
                                  shape: BoxShape.circle,
                                ),
                                child: SvgPicture.asset(
                                    "assets/icons/more.svg"))),
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
                          child: Image.network(
                              "https://fiverr-res.cloudinary.com/images/q_auto,f_auto/gigs/222747949/original/541f4419b48cd87e1e32f058ce3ea96ab0c524ea/draw-nft-artworks-and-designs.jpg")),
                    ),
                  ),
                  Positioned(
                    left: 105,
                    top: 260,
                    child: InkWell(
                      onTap: (){
                        locator<NavigationService>().push(MaterialPageRoute(builder: (context) => const QRCode(userQr: true,myQr: false),settings: const RouteSettings(name: QRCode.route)));
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "John Doe",
                                  style: w_700.copyWith(fontSize: 20),
                                ),
                                Text(
                                  "@johndoe",
                                  style: w_600.copyWith(fontSize: 14),
                                ),
                              ],
                            ),
                            const Spacer(),
                            SizedBox(
                                width: 150,
                                child: Button_2(
                                  buttonTxt: "Follow",
                                  function: () {},
                                 )),
                          ],
                        ),
                      ),
                      Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec a semper lacus, in faucibus sapien. Nulla elit est, semper nec feugiat at, convallis id sem. Mauris ullamcorper feugiat nunc nec finibus.",
                        style: w_400.copyWith(fontSize: 14),
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
                                      "1",
                                      style: w_600.copyWith(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child:InkWell(
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
                                      "9",
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
                                    "20",
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
                        padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 15),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Memberships"),const SizedBox(height: 8,),
                            GridView.builder(
                              itemCount: 10,
                              padding: EdgeInsets.zero,physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 5,mainAxisSpacing: 5,
                                  crossAxisCount: 5),
                              itemBuilder: (context, index) => Container(
                                decoration: BoxDecoration(
                                  color: blackColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const CircleAvatar(radius:16.5,),
                                    const SizedBox(height: 2,),
                                    Text("User ${index+1}",style: w_500.copyWith(fontSize: 12),)
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 12,),
                            InkWell(
                              onTap: (){
                                locator<NavigationService>().namedNavigateTo(MemberShipScreen.route);
                              },
                              child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: GradientTxt(txt:"See all", style: w_600.copyWith(fontSize: 12),)),
                            ),const SizedBox(height: 8,),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
                SizedBox(
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
                              tab=tabIndex;
                            });
                          },
                          labelPadding:
                          const EdgeInsets.only(left: 10, right: 10),
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
                           ]),
                    ),
                  ),
                ),
                if(tab==0)       ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: 4,

                  shrinkWrap: true,physics:const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) =>   MarketPlace(multiple_nft:index==0?true:false,owner:index==2?false:true,),),
                if(tab==1) ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
                  separatorBuilder: (context, index) => const Divider(color: blackBorderColor,),
                  itemCount: 4,shrinkWrap: true,physics:
                const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(crossAxisAlignment:CrossAxisAlignment.start,children: [
                          Container(height: 69,width: 69,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: const DecorationImage(
                                    image: NetworkImage('https://fiverr-res.cloudinary.com/images/q_auto,f_auto/gigs/222747949/original/541f4419b48cd87e1e32f058ce3ea96ab0c524ea/draw-nft-artworks-and-designs.jpg')
                                )
                            ),
                          )
                        ]),
                        const SizedBox(width: 12,),
                        Padding(
                          padding: const EdgeInsets.only(top:3.0),
                          child: Column(crossAxisAlignment:CrossAxisAlignment.start,children: [
                            Text("NFT Name",style: w_600.copyWith(fontSize: 16),),
                            const SizedBox(width: 4,),
                            Row(
                              children: [
                                Text("1 edition gifted from",style: w_400.copyWith(
                                    fontSize: 12
                                ),),
                                const SizedBox(width: 10,),
                                const CircleAvatar(radius: 10,),
                                const SizedBox(width: 5,),
                                Text("username",style: w_600.copyWith(fontSize: 12),),
                              ],
                            ),
                            const SizedBox(width: 4,),
                            Row(
                              // crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text("to",style: w_400.copyWith(
                                    fontSize: 12
                                ),),
                                const SizedBox(width: 10,),
                                const CircleAvatar(radius: 10,),
                                const SizedBox(width: 5,),
                                Text("username",style: w_600.copyWith(fontSize: 12),),  ],
                            ),
                          ]),
                        ),
                      ]),),
                if(tab==2) Column(children: [
                  Container(
                    constraints: const BoxConstraints(minHeight: 372,minWidth: 335),
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    decoration: BoxDecoration(
                        border: Border.all(color: blackBorderColor),
                        borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Center(child: Text("Select NFTs from Owned Section you want to gift",style: w_700.copyWith(fontSize: 14),textAlign: TextAlign.center,)),
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text("Enter the user's e-mail address in the field below",style: w_400.copyWith(fontSize: 14),textAlign: TextAlign.center,),
                        ),
                        TextFieldForm(hintText: "Email, Username",postfix:IconButton(
                            onPressed: null,
                            icon:SvgPicture.asset("assets/icons/scanner.svg")),topPadding: 15,bottomPadding: 20,),
                        Button(buttonTxt: "Send", function: (){})
                      ],
                    ),
                  ),

                ],)
              ],
            )
          ],
        ),
      ),
    );
  }
}
