import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constant/color.dart';
import '../constant/style.dart';
import '../services/locator.dart';
import '../services/navigation_service.dart';
import '../ui/Auth Screen/Signup/sign_up.dart';

Future alert(context){
  return    showCupertinoDialog(barrierDismissible: true,
    context: context,
    builder: (context) {
      return Material(color: blackColor2.withOpacity(.5),
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 48),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), color: appColor),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 28,
                ),
                // Padding(
                //   padding: EdgeInsets.only(  bottom: 8),
                //   child: Text(
                //     "SignIn/SignUp !",
                //     textAlign: TextAlign.center,
                //     style: w_500,
                //   ),
                // ),
                SizedBox(
                    width: 246,
                    child: Text(
                      "You need to Signup or Login to continue.",
                      textAlign: TextAlign.center,
                      style: w_500,
                    )),
                const SizedBox(
                  height: 23,
                ),
                const Divider(color: blackColor2),

                InkWell(
                  onTap: (){
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) => const SignUp()),
                      ModalRoute.withName('sign_up'),
                    );
                  },
                  child: SizedBox(
                    height: 40 ,
                    width: MediaQuery.of(context).size.width,
                    child: const Center(
                      child: Text("Ok",
                          style: TextStyle(
                            fontFamily: "Helvetica Now Display",
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          )),
                    ),
                  ),
                ),
                const Divider(color: blackColor2),
                InkWell(
                  onTap: (){
                    locator<NavigationService>().goBack();
                  },
                  child: SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: const Center(
                      child: Text(
                        "May be later",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: "Helvetica Now Display",
                          fontWeight: FontWeight.w700,
                          color: Color(0xff99A3A5),
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}