import 'package:flutter/material.dart';
import 'package:nftwist/provider/user.dart';
import 'package:nftwist/widget/appBar.dart';
import 'package:nftwist/widget/loader_screen.dart';
import 'package:nftwist/widget/textfiels/textfield.dart';
import 'package:provider/provider.dart';

import '../../../../../constant/color.dart';
import '../../../../../constant/style.dart';
import '../../../../../widget/button.dart';


class AddRulesScreen extends StatefulWidget {
  final String? rule;
  final String rule_id;
  final String? type;
  final String? count;
  const AddRulesScreen({Key? key, this.rule, this.rule_id='', this.count, this.type}) : super(key: key);
  static const route = "add_rules";
  @override
  State<AddRulesScreen> createState() => _AddRulesScreenState();
}

class _AddRulesScreenState extends State<AddRulesScreen> {
  String? type;
  bool loading=false;
  final TextEditingController _rule=TextEditingController();
  final TextEditingController _noOfScan=TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
setState(() {
  _noOfScan.text=widget.count??'';
  _rule.text=widget.rule??'';
  type=widget.type??"GIFT_NFT";
});
  }
  @override
  Widget build(BuildContext context) {
    var setUserRules=Provider.of<User>(context,listen: false);
    return LoaderPage(
      loading: loading,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const CustomAppBar(title: "Add Rule"),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text("After how many scans you want to automatically gift the NFT?",style: w_500.copyWith(fontSize: 16),),
            ),
            TextFieldForm(
                tfController: _noOfScan,keyboardType: TextInputType.phone,
                hintText: "Enter number",borderRadius: 40,bottomPadding: 15,topPadding: 10,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text("Enter rules for your NFT!",style: w_500.copyWith(fontSize: 16),),
            ),
            TextFieldForm(
              tfController: _rule,maxLines: 5,minLines: 5,
              hintText: "Enter rule",borderRadius: 16,topPadding: 10),

            Container(height: 55,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(38),
                  border: Border.all(width: 2, color: const Color(0xffE6E6E6))
              ),
              margin: const EdgeInsets.only(
                  top:  16,
                  bottom:  0,
                  left:  20,
                  right: 20),
              child:                 DropdownButtonFormField<String>(
                value: type,
                icon: Container(),dropdownColor: blackColor,
                items: ["GIFT_COUPON","GIFT_NFT"].map((value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value.replaceAll("_"," ")),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    type = newValue;
                  });
                },
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(16),
                  border: InputBorder.none,
                  suffixIcon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              color: blackColor,
              child: Button(buttonTxt: "Add Rule", function: () {
                setState(() {
                  loading=true;
                });
                setUserRules.setPartnerRules(_noOfScan.text, _rule.text,widget.rule_id, type).then((_){
                  setState(() {
                    loading=false;
                  });
                });
              }),
            ),

          ],
        ),

      ),
    );
  }
}
