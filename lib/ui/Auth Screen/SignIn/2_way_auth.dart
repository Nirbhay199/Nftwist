import 'package:flutter/material.dart';
import 'package:nftwist/provider/auth.dart';
import 'package:nftwist/services/locator.dart';
import 'package:nftwist/services/navigation_service.dart';
import 'package:nftwist/widget/loader_screen.dart';
import 'package:provider/provider.dart';

import '../../../constant/style.dart';
import '../../../widget/button.dart';

class TwoWayAuth extends StatefulWidget {
  const TwoWayAuth({Key? key}) : super(key: key);
  static const route = '2_way_auth';

  @override
  State<TwoWayAuth> createState() => _TwoWayAuthState();
}

class _TwoWayAuthState extends State<TwoWayAuth> {
  bool loading=false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async=>false,
      child: LoaderPage(
        loading: loading,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(
                    "assets/images/abstract-oil-shape-2021-08-26-15-42-43-utc 2-3.png"),
                fit: BoxFit.fill,
              )),
              child: Container(
                color: Colors.black.withOpacity(.74),
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).viewPadding.top + 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Text(
                        "We’re Glad You Have \nMade It",
                        style: w_700,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32.0),
                      child: Text(
                          "For added security, please setup your 2-way factor!",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Color(0xff7B7B7B),

                          ),
                          textAlign: TextAlign.center),
                    ),
                    const SizedBox(height: 9,),
                    Button(
                        buttonTxt: "Set Up 2-Way Factor Auth",
                        function: () {
                          setState((){loading=true;});
                          Provider.of<Auth>(context,listen: false).twoWayAuthentication(0);
                        },
                        verticalPadding: 15),
                    Button_2(
                      buttonTxt: "Skip for Now",
                      function: () {
                        Provider.of<Auth>(context,listen: false).twoWayAuthentication(1);
                      },
                      verticalPadding: 0,
                      horizontalPadding: 20,
                    ),
                    // const Padding(
                    //   padding: EdgeInsets.all(15.0),
                    //   child: Text("Skip for Now",style: TextStyle(
                    //     fontSize: 14,
                    //       fontWeight: FontWeight.w600
                    //   ),),
                    // )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
