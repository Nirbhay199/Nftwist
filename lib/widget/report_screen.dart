import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nftwist/constant/style.dart';
import 'package:nftwist/widget/button.dart';

import '../constant/color.dart';
import '../services/locator.dart';
import '../services/navigation_service.dart';
import '../ui/Bottom Nav Bar/bottom_nav_bar.dart';

class ReportSuccess extends StatelessWidget {
  const ReportSuccess({super.key});
static const route="report";
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async=> false,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(height: 120,),
              Center(child: SvgPicture.asset("assets/icons/verified _grd.svg")),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                child: Center(
                    child: Text(
                  "Thanks for letting us know",
                  style: w_700.copyWith(fontSize: 24),
                )),
              ),
              Text(
                "We use these reports to:",
                style: w_600.copyWith(fontSize: 18),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                alignment: Alignment.topLeft,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
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
                  borderRadius: BorderRadius.circular(10),
                  // border: Border.all(color: borderColor)
                ),
                child: Row(children: [
                  const Icon(Icons.info_outline_rounded, color: whiteColor2),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Text(
                          "Understand problem that people are having with different types of content",
                          style: w_500)),
                ]),
              ),
              Container(
                alignment: Alignment.topLeft,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
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
                  borderRadius: BorderRadius.circular(10),
                  // border: Border.all(color: borderColor)
                ),
                child: Row(children: [
                  const Icon(Icons.warning_outlined, color: whiteColor2),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                        "Show you less of this kind of content in th future",
                        style: w_500),
                  ),
                ]),
              ),
              const Spacer(),
              Button(
                buttonTxt: "Next",
                function: () {
                  locator<NavigationService>().popUntil(BottomNavBar.route);
                },
                verticalPadding: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
