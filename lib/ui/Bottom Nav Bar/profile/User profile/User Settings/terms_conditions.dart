import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:nftwist/provider/app_content.dart';
import 'package:nftwist/widget/appBar.dart';
import 'package:provider/provider.dart';
import '../../../../../constant/app_content_modal.dart' ;

import '../../../../../constant/style.dart';
class TermsConditions extends StatelessWidget {
  const TermsConditions({Key? key}) : super(key: key);
  static const route ="terms_conditions";
  @override
  Widget build(BuildContext context) {
     var appData=Provider.of<AppContents>(context,listen: false);
    var privacy=appData.appTERMS;
    var getPrivacy=appData.getAppData(type.TERMS_AND_CONDITIONS.name);  return Scaffold(
      appBar: const CustomAppBar(
        title: "Term & Conditions",
      ),
       body:SingleChildScrollView(
         child: Padding(
           padding: const EdgeInsets.symmetric(horizontal: 18),
           child: Column(children: [
             Container(
               margin: const EdgeInsets.only(bottom: 20),
               decoration:
               BoxDecoration(borderRadius: BorderRadius.circular(20)),
               height: 188,
               width: MediaQuery.of(context).size.width,
               child: ClipRRect(
                 borderRadius: BorderRadius.circular(20),
                 child: const Image(
                   image: AssetImage("assets/images/privacy.jpg"),
                   fit: BoxFit.cover,
                 ),
               ),
             ),
             FutureBuilder(future: getPrivacy, builder: (context, snapshot) {
               if(snapshot.connectionState==ConnectionState.waiting){
                 return const Center(child: Padding(
                   padding: EdgeInsets.all(8.0),
                   child: CircularProgressIndicator(color: Colors.white,),
                 ),);
               }else if (snapshot.hasError){
                 return Center(child: Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Text("Error", style: w_500,),
                 ),);
               }
               else{
                 return HtmlWidget(
                   privacy?.text ?? '',
                   textStyle: w_500,
                   //   customWidgetBuilder: (element) {
                   //   print(element.localName);
                   //   if(element.localName=='ol'){
                   //   return Text("${element.text}");}
                   // },
                 );
               }
             },),

             const SizedBox(height: 40,)
           ]),
         ),
       ) ,
    );
  }
}
