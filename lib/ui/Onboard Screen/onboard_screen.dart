import 'package:flutter/material.dart';
import 'package:nftwist/constant/color.dart';
import 'package:nftwist/constant/style.dart';
import 'package:nftwist/services/locator.dart';
import 'package:nftwist/services/navigation_service.dart';
 import 'package:nftwist/widget/button.dart';

import '../Auth Screen/Signup/sign_up.dart';
import '../Bottom Nav Bar/bottom_nav_bar.dart';

class OnBoardScreen extends StatelessWidget {
  const OnBoardScreen({Key? key}) : super(key: key);
  static const route = 'on_board';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /*   Container(
            height: 200 ,
            decoration:   const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.transparent,
                    offset: Offset(0, 20.0),
                    blurRadius: 18,
                    spreadRadius: 2,
                  ),
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 10.0),
                    blurRadius: 20,
                    spreadRadius: 9,
                  ),
                ]                ),
          ),*/
          Container(
            width: 440,
            height: MediaQuery.of(context).size.height * .55,
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * .1),
            child: Image.asset(
                "assets/images/bitcoin-illustration-neon-splash.png",
                fit: BoxFit.fitHeight),
          ),
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top+20,right:20),
            child:  Row(mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                    onTap:(){
                      locator<NavigationService>().namedNavigateTo(BottomNavBar.route);
                    },
                    child: const Text("Skip",)),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .43 -
                    MediaQuery.of(context).viewPadding.top,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        offset: Offset(0, -30),
                        blurRadius: 40,
                        spreadRadius: 2,
                      ),
                    ]),
              ),
            ],
          ),
          Positioned(
            width: MediaQuery.of(context).size.width,
            bottom: MediaQuery.of(context).viewPadding.bottom + 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: RichText(
                    text: TextSpan(text: "NFTs ", style: w_400, children: [
                      TextSpan(
                        text: 'with a ',
                        style: w_400.copyWith(fontWeight: FontWeight.w400),
                      ),
                      TextSpan(
                        text: 'Twist!',
                        style: w_400,
                      ),
                    ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 32),
                  child: Text("Discover, collect, and sell Extraordinary\nNFTs",
                      style: w_700, textAlign: TextAlign.center),
                ),
                Button(
                    buttonTxt: "Get Started",
                    function: () {
                      locator<NavigationService>()
                          .namedNavigateTo(SignUp.route);
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
