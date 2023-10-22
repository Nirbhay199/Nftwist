
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nftwist/constant/style.dart';

import 'color.dart';

class Toaster {
  final GlobalKey<ScaffoldMessengerState> snackbarKey =
      GlobalKey<ScaffoldMessengerState>();





 showToaster(
      {required String msg,
      double? bottomMargin,
      textAlign,
      double? toasterHeight,
      toasterDurationMilli,
      loadingDuration,color,toasterColor,action}) async {
    var window=WidgetsBinding.instance.window;
    // var screenWidth = window.physicalSize.width / window.devicePixelRatio;
    var screenHeight = window.physicalSize.height / window.devicePixelRatio;
    // print(screenHeight);
    snackbarKey.currentState?.removeCurrentSnackBar();
    if (msg.trim() != '') {
      HapticFeedback.heavyImpact();
       snackbarKey.currentState?.showSnackBar(
        SnackBar(
          dismissDirection: DismissDirection.none,
          // backgroundColor: Colors.blue,
          duration: Duration(milliseconds: toasterDurationMilli ?? 1100),
          elevation: 3,
          margin: EdgeInsets.fromLTRB(
            32,
            0,
            32,
            screenHeight *
                (bottomMargin ?? .84),
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          padding: EdgeInsets.zero,
          content: ToasterContent(
            msg: msg,color:color,
            textAlign: textAlign,
            height: toasterHeight,
            loadingDuration: loadingDuration,toasterLoadingColor: toasterColor,
          ),
          behavior: SnackBarBehavior.floating,
        ),
      ).closed.then((value){
         if(action!=null){
           action();
         }
       });
    }
  }
}

class ToasterContent extends StatefulWidget {
  final String msg;
  final Color? color;
  final Color? toasterLoadingColor;
  final double? height;
  final TextAlign? textAlign;
  final int? loadingDuration;

  const ToasterContent(
      {super.key,
      required this.msg,
      this.textAlign,
      this.height,
      this.loadingDuration, this.color, this.toasterLoadingColor});

  @override
  _ToasterContentState createState() => _ToasterContentState();
}

class _ToasterContentState extends State<ToasterContent> {
  double width = 10;
  double top = 5;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) {
      setState(() {
        top = 0;
      });
    });
    Future.delayed(const Duration(milliseconds: 100)).then((value) {
      setState(() {
        width = 1000;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
          color: widget.color??toasterBg, borderRadius: BorderRadius.circular(5)),
      height: widget.height ?? 60,
      // constraints: BoxConstraints(minHeight: 80, ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width*.7,
                child: Text(
                  widget.msg,
                  style: w_500.copyWith(color: blackColor,fontSize: 13.5),
                  textAlign: widget.textAlign ?? TextAlign.center,
                ),
              ),
            ],
          ),
          const Spacer(),
          AnimatedContainer(
            duration: Duration(seconds: widget.loadingDuration ?? 4),
            height: 5,
            width: width,
            decoration: BoxDecoration(
                color: widget.toasterLoadingColor??toasterLoadingColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: const Radius.circular(5),
                    bottomRight: const Radius.circular(5),
                    topRight: Radius.circular(top))),
          ),
        ],
      ),
    );
  }
}
