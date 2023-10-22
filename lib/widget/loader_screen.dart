import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nftwist/constant/color.dart';

class LoaderPage extends StatelessWidget {
  final Widget child;
  final bool loading;
  const LoaderPage({Key? key, required this.child, this.loading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Stack(
            children: [
              child,
              if (loading == true)
                const  ModalBarrier(dismissible: false,color: Colors.black45,),
              if (loading == true)
               Center(child: Container(
                height: 90,width: 100,decoration: BoxDecoration(
                 color: blackColor2,
                 borderRadius: BorderRadius.circular(8),
               ),
                 child:  Column(mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Text("Loading..."),
                     SizedBox(height: 20,),
                     CupertinoActivityIndicator(color: whiteColor,),
                   ],
                 ),
              ),),
            ],
          )
        ],
      ),
    );
  }
}
