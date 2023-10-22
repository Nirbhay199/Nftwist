import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nftwist/constant/style.dart';
import 'package:nftwist/provider/auth.dart';
import 'package:nftwist/widget/appBar.dart';
import 'package:nftwist/widget/loader_screen.dart';
import 'package:provider/provider.dart';

import '../../../constant/color.dart';
import '../../../constant/get_country.dart';
import '../../../widget/button.dart';
import '../../../widget/textfiels/textfield.dart';

class HelpCenter extends StatefulWidget {
  const HelpCenter({Key? key}) : super(key: key);
  static const route = "helpCenter";

  @override
  State<HelpCenter> createState() => _HelpCenterState();
}

class _HelpCenterState extends State<HelpCenter> {
  String countryCode = "971";
  bool loading=false;
String countryName = "";
var flag = '🇦🇪';
int length = 9;
final TextEditingController _name = TextEditingController();
final TextEditingController _lastName = TextEditingController();
final TextEditingController _email = TextEditingController();
final TextEditingController _phoneNo = TextEditingController();
final TextEditingController _desc = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var user=Provider.of<Auth>(context,listen: false);
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Help Center",
      ),
      body: LoaderPage(
        loading: loading,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(top: 24),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: blackBorderColor, width: 1.5)),
            child: Column(
              children: [
                Text(
                  "Enter Your Contact Information",
                  style: w_600.copyWith(fontSize: 16),
                ),
                  TextFieldForm(
                  hintText: "First name",
                  topPadding: 24,tfController: _name,
                ),
                  TextFieldForm(
                  hintText: "Last name",
                  topPadding: 16,tfController: _lastName,
                ),
                  TextFieldForm(
                  hintText: "E-mail address",
                  topPadding: 16,tfController: _email,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(38),
                      border: Border.all(width: 2, color: const Color(0xffE6E6E6))
                  ),
                  margin: const EdgeInsets.only(top:16,left: 20,right: 20,bottom: 16),
                  // padding: EdgeInsets.only(left: 0,),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          var a=await  showModalBottomSheet(context: context, builder: (context) => const GetCountry());
                          setState(() {
                            countryCode=a['phone'];
                          });
                        },
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 13,
                            ),
                            Text("+$countryCode",
                                style: const TextStyle(fontWeight: FontWeight.w500,
                                    fontSize: 16)),
                            const SizedBox(
                              width: 7,
                            ),
                            const Icon(Icons.keyboard_arrow_down,color: Colors.white,size: 18),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const SizedBox(
                          height: 30,
                          child: VerticalDivider(
                            width: 8,
                            thickness: 2,
                          )),
                      Expanded(
                        child: TextFormField(
                          cursorColor: const Color(0xff5E686B),
                          cursorHeight: 20,
                          cursorWidth: 1.5,
                          onTap: (){
                            ScaffoldMessenger.of(context).removeCurrentSnackBar();

                          },
                          controller: _phoneNo,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(length),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          style: w_500.copyWith(
                            color: textFieldColor,
                            fontSize: 16,
                            letterSpacing: .5,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.fromLTRB(14,16,14,12),
                            hintText: "Phone no.",
                            hintStyle:  w_500.copyWith(
                              color: textFieldColor,
                              fontSize: 16,
                              letterSpacing: .5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Text(
                  "Describe Your Problem",
                  style: w_400.copyWith(fontSize: 14),
                ),
                  TextFieldForm(
                  hintText: "Please describe here...",tfController: _desc,
                  minLines: 5,
                  maxLines: 5,
                  borderRadius: 16,
                  topPadding: 8,
                ),
                Button(verticalPadding: 32,
                    buttonTxt: "Submit Ticket", function: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    setState(() {
                      loading=true;
                    });
                    user.coutactUs(_name.text, _lastName.text, _email.text, _phoneNo.text, _desc.text,countryCode).then((_){
                      setState(() {
                        loading=false;
                      });
                    });
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
