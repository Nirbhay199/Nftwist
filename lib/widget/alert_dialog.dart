import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nftwist/constant/style.dart';

import '../constant/color.dart';

class CustomAlertDialog extends StatelessWidget {
  final Widget child;
  final String? image;
  final String title;
  final String subtitle;
  final String? button1Txt;
  final String? button2Txt;
  final button1fun;
  final button2fun;
  final bool loading;
  const CustomAlertDialog(
      {Key? key,
      required this.child,
      required this.loading,
      this.button1Txt,
      this.button2Txt,
      this.button1fun,
      this.button2fun,
      this.image,
      required this.title,
      required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: appColor,
      body: WillPopScope(
        onWillPop: () async => !loading,
        child: Stack(
          children: [
            child,
            if (loading)
              ModalBarrier(
                dismissible: false,
                color: blackColor2.withOpacity(.7),
              ),
            if (loading)
              Center(
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
                    if (image != null) SvgPicture.asset(image!),
                    Padding(
                      padding: EdgeInsets.only(
                          top: image != null ? 12 : 0, bottom: 8),
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: w_500,
                      ),
                    ),
                    SizedBox(
                        width: 246,
                        child: Text(
                          subtitle,
                          textAlign: TextAlign.center,
                          style: w_500,
                        )),
                    const SizedBox(
                      height: 23,
                    ),
                    if (button1Txt != null) const Divider(color: blackColor2),
                    if (button1Txt != null)
                      InkWell(
                        onTap: button1fun,
                        child: SizedBox(
                          height: button2Txt != null ? 40 : 50,
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: Text(button1Txt.toString(),
                                style: const TextStyle(
                                  fontFamily: "Helvetica Now Display",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.5,
                                )),
                          ),
                        ),
                      ),
                    if (button2Txt != null) const Divider(color: blackColor2),
                    if (button2Txt != null)
                      InkWell(
                        onTap: button2fun,
                        child: SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: Text(
                              button2Txt.toString(),
                              style: const TextStyle(
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
              )),
          ],
        ),
      ),
    );
  }
}
