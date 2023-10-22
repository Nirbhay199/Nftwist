import 'package:flutter/material.dart';
import 'package:nftwist/provider/user.dart';
import 'package:nftwist/widget/appBar.dart';
import 'package:nftwist/widget/loader_screen.dart';
import 'package:provider/provider.dart';

import '../../../constant/color.dart';
import '../../../constant/style.dart';
import '../../../widget/button.dart';
import '../../../widget/gust_login_alert.dart';
import '../../../widget/textfiels/textfield.dart';
class Report extends StatefulWidget {
  final String? NftId;
  final String? UserId;
  final String userName;
  final int reportType;
  const Report({super.key,this.NftId, required this.userName, required this.reportType, this.UserId});
static const route='report';

  @override
  State<Report> createState() => _ReportState();

}

class _ReportState extends State<Report> {
  final TextEditingController _report=TextEditingController();
  bool loading=false;
  String selected='';
  List <String> reason=[
  "I Own This Account",
  "Adult Content",
  "Promotes Violence",
  "Hate Speech and Discrimination",
  "Promotes Extremism and Terrorism"
  ];
  @override
  Widget build(BuildContext context) {
     return LoaderPage(
      loading: loading,
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: ListView(
           children: [
            Padding(
              padding: const EdgeInsets.only( bottom: 20),
              child: Text(
                widget.userName,
                textAlign: TextAlign.center,
                style: w_600,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                "If you think this account violates our community guidelines, please do not hesitate to let us know.",
                textAlign: TextAlign.start,
                style: w_500,
              ),
            ),

            ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: reason.length,
              itemBuilder: (context, index) => Row(children: [
                Radio(groupValue: selected,activeColor: whiteColor,
                  materialTapTargetSize:
                  MaterialTapTargetSize.shrinkWrap,
                  visualDensity: const VisualDensity(
                      horizontal: -2, vertical: 1),   value: reason[index],
                  onChanged: (_){
                  setState(() {
                  selected= _ as String;
                  });
                    },

                ),
                Text(reason[index],style: w_600.copyWith(fontSize: 13)),
              ],),),

            TextFieldForm(
                maxLines: 5,minLines: 5,tfController: _report,
                hintText: "Report This User",borderRadius: 16,topPadding: 10),

            Button(buttonTxt: "Report",
                verticalPadding: 20,active: selected!='',
                function: (){
                  if(Provider.of<User>(context,listen: false).user==null){
                    alert(context);
                  }else
                  {      FocusManager.instance.primaryFocus?.unfocus();
                  setState(() {
                    loading=true;
                  });
                  Provider.of<User>(context,listen: false).reportUser(widget.NftId,selected,_report.text,reason.indexWhere((element) => element==selected),widget.reportType,widget.UserId).then((_){
                    setState(() {
                      loading=false;
                    });
                  });
                  }
                })
          ],
        ),
      ),
    );
  }
}
