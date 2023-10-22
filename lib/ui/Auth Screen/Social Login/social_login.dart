import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nftwist/constant/color.dart';

import '../../../widget/auth_page.dart';

class SocialWidget extends StatelessWidget {
  const SocialWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
          Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 32,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Divider(
                  color: Color(0xffE7E8E8),
                  thickness: 1,
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Center(child: Text("or")),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: Divider(
                  color: Color(0xffE7E8E8),
                  thickness: 1,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32,),
        Row(mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            GestureDetector(
              onTap: (){
                print("Goggle------------");
                google(context);
              },
              child: Container(height: 40,width: 40,margin: const EdgeInsets.only(right: 16,left: 16),
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: googleColor,
                  shape: BoxShape.circle
                ),
                child: SvgPicture.asset("assets/icons/google.svg"),),
            ),
            GestureDetector(
              onTap: (){
                print("FaceBook----------");
                faceBook(context);
              },
              child: Container(height: 40,width: 40,margin: const EdgeInsets.only(right: 16,left: 16),
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                    color: faceBookColor,
                    shape: BoxShape.circle
                ),
                child: SvgPicture.asset("assets/icons/facebook.svg"),),
            ),
            if(Platform.isIOS)GestureDetector(
              onTap: (){},
              child: Container(height: 40,width: 40,margin: const EdgeInsets.only(right: 16,left: 16),
                padding: const EdgeInsets.all(9),
                decoration: const BoxDecoration(
                    color: whiteColor,
                    shape: BoxShape.circle
                ),
                child: SvgPicture.asset("assets/icons/apple.svg"),),
            ),
          ],
        )
      ],
    );
  }

}
