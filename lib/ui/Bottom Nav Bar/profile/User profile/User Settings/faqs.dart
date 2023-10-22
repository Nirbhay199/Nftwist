import 'package:flutter/material.dart';
import 'package:nftwist/constant/color.dart';
import 'package:nftwist/constant/style.dart';
import 'package:nftwist/provider/app_content.dart';
import 'package:nftwist/widget/appBar.dart';
import 'package:provider/provider.dart';
import '../../../../../constant/app_content_modal.dart'as modal;
class FAQsScreen extends StatefulWidget {
  const FAQsScreen({Key? key}) : super(key: key);
 static const route="faqs";

  @override
  State<FAQsScreen> createState() => _FAQsScreenState();
}

class _FAQsScreenState extends State<FAQsScreen> {
   List openTabs=[];
   var future;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    future=Provider.of<AppContents>(context,listen: false).getFaq();
  }
  @override
  Widget build(BuildContext context) {
    List<modal.Faq>? faqs=Provider.of<AppContents>(context).faqs;
    return Scaffold(
      appBar: const CustomAppBar(title: "FAQs",),
       body: Padding(
         padding: const EdgeInsets.symmetric(horizontal: 18),
         child: FutureBuilder(future: future, builder: (context, snapshot) {
           if(snapshot.connectionState==ConnectionState.waiting){
             return const Center(child: CircularProgressIndicator(color: whiteColor,),);
           }else if(faqs.isEmpty){
             return const Center(child:  Text("No Faqs "),);
           }else{
             return ListView.builder(
               itemCount: faqs.length,
               itemBuilder: (context, index) {
                 return Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                   GestureDetector(
                     onTap: () {
                       setState(() {
                         if (openTabs.contains(faqs[index].id)) {
                           openTabs.remove(faqs[index].id);
                         } else {
                           openTabs.add(faqs[index].id);
                         }
                       });
                     },
                     child: Container(
                       alignment: Alignment.topLeft,
                       padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                       margin:   EdgeInsets.only(top: 8,bottom: openTabs.contains(faqs[index].id)?0:4),
                       decoration: BoxDecoration(gradient: const LinearGradient(
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
                       child:Row(children: [
                         Expanded(
                           child: Text(
                             faqs[index].question??'',
                             style: w_500,
                             textAlign: TextAlign.start,
                           ),
                         ),
                         Icon(openTabs.contains(faqs[index].id) == false
                             ? Icons.keyboard_arrow_down
                             : Icons.keyboard_arrow_up,color:whiteColor2),
                       ]),
                     ),
                   ),
                   openTabs.contains(faqs[index].id) == true
                       ? Padding(
                       padding: const EdgeInsets.only(right: 20, top: 4,bottom: 8),
                       child: Text(
                           faqs[index].answer??'',
                           style: w_400.copyWith(fontSize: 12),
                       ))
                       : const SizedBox(),
                 ],);
               },);
           }
         },)
       )
    );
  }
}
