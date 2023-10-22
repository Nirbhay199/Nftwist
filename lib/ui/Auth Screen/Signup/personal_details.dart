import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:nftwist/constant/get_State.dart';
import 'package:nftwist/constant/style.dart';
import 'package:nftwist/main.dart';
import 'package:nftwist/provider/auth.dart';
import 'package:nftwist/provider/user.dart';
import 'package:nftwist/services/locator.dart';
import 'package:nftwist/services/navigation_service.dart';
import 'package:nftwist/widget/button.dart';
import 'package:nftwist/widget/loader_screen.dart';
import 'package:nftwist/widget/textfiels/textfield.dart';
import 'package:provider/provider.dart';

import '../../../constant/color.dart';
import '../../../constant/get_country.dart';
import '../../../widget/keyboard_done_button.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({Key? key}) : super(key: key);
  static const route = 'personal_details';

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  String countryCode = "971";
  String countryName = "United Arab Emirates";
  String stateName = "";
  int countryLength=8;
  var flag = '🇦🇪';
  String countryShortName="AE";
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _phoneNo = TextEditingController();
  var overlayEntry;
  bool loading=false;
  DateTime? dateOfBirth;

  String? dropDownValue;
  List<String> items = ['Male', 'Female', 'Other'];
  showOverlay(BuildContext context) {
    if (overlayEntry != null) return;
    OverlayState? overlayState = Overlay.of(context);
    overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          right: 0.0,
          left: 0.0,
          child: const InputDoneView());
    });

    overlayState.insert(overlayEntry);
  }
  removeOverlay() {
    if (overlayEntry != null) {
      overlayEntry.remove();
      overlayEntry = null;
    }
  }
  FocusNode phoneNumberFocusNode = FocusNode();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Platform.isIOS) {
      phoneNumberFocusNode.addListener(() {
        bool hasFocus = phoneNumberFocusNode.hasFocus;
        if (hasFocus) {
          showOverlay(context);
        } else {
          removeOverlay();
        }
      });
    }
Future.delayed(Duration.zero).then((value) {
  if(token!=''){
   setState(() {
     final user=Provider.of<User>(context,listen: false).user;
     _firstName.text=user?.first_name??'';
     _lastName.text=user?.last_name??'';
     _userName.text=user?.user_name??'';
     _phoneNo.text=(user?.phone_no??'').toString();
     stateName=user?.state??'';
     countryName=user?.country??'';
     flag=user?.flag??"🇦🇪";
     countryCode=user?.country_code??"971";
   });
  }
});
  }
  /*experiences :- [arts-culture, beach-club-pool-access, city-attraction]
  print:- hotel_type_id :-[boutique, charming, classic]
  print:- room_types :-[balcony, city-view]
  print:- musthave_id :-[adult-pool, bar-lounge]*/
  /*print:- room_types :-[beach-access]
   print:- hotel_type_id :-[business]
   print:- experiences :- [spa-wellness]
   musthave_id :-[baby-sitting, all-inclusive]
   */
  @override
  Widget build(BuildContext context) {
    var fun=Provider.of<Auth>(context,listen: false);
    return WillPopScope(
      onWillPop: ()async{
        locator<NavigationService>().goBack(data: false);
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: LoaderPage(
          loading: loading,
          child: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        "assets/images/abstract-oil-shape-2021-08-26-15-42-43-utc 2-2.png"),
                    fit: BoxFit.fill,
                  )),
              child: Container(
                color: Colors.black.withOpacity(.74),
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).viewPadding.top + 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          // color:Colors.red,
                          margin: const EdgeInsets.only(top: 3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:  [
                              Text(
                                "Personal Details",
                                style: w_700,
                              ),
                            ],
                          ),
                        ),
                       // Padding(
                       //    padding: const EdgeInsets.only(left: 10.0),
                       //    child: IconButton(onPressed: (){
                       //      locator<NavigationService>().goBack(data: false);
                       //    }, icon:const Icon(Icons.arrow_back,color: Colors.white,)),
                       //  )
                      ],
                    ),
                    const SizedBox(height: 14,),
                    const Text("Enter your personal details below.",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14, color: Color(0xff7B7B7B),),),
                    TextFieldForm(hintText: "First name",topPadding: 20,tfController: _firstName),
                    TextFieldForm(hintText: "Last name",topPadding: 16,tfController: _lastName),
                    TextFieldForm(hintText: "Username",topPadding: 16,leading: Text(
                      "@",
                      style:w_400.copyWith(fontWeight: FontWeight.w500),
                    ),isLeading: true,tfController: _userName),
                    TextFieldForm(topPadding: 16,
                      onTap: ()async{
                       var a=await  showModalBottomSheet(context: context, builder: (context) => const GetCountry());
                     if(a!=null){
                       setState(() {
                         countryName=a['name'];
                         countryShortName=a['shortName'];
                         flag=a['emoji'];
                         countryCode=a['phone'];
                       });
                     }
                      },
                      tfController: TextEditingController(text: countryName),
                      readOnly: true,
                      postfix: const IconButton(
                          onPressed: null,
                          icon: Icon(Icons.keyboard_arrow_down,color: whiteColor,)),
                      hintText: 'United Arab Emirates',leading: Text(flag, style: const TextStyle(fontWeight: FontWeight.w500,
                          fontSize: 28,color: textColor)),isCountry: true,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(38),
                          border: Border.all(width: 2, color: const Color(0xffE6E6E6))
                      ),
                      margin: const EdgeInsets.only(top:16,left: 20,right: 20),
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
                                  width: 20,
                                ),
                                Text("+$countryCode",
                                    style: const TextStyle(fontWeight: FontWeight.w500,
                                        fontSize: 16)),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Icon(Icons.keyboard_arrow_down,color: Colors.white,size: 18),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const SizedBox(
                              height: 30,
                              child: VerticalDivider(
                                width: 8,
                                thickness: 2,
                              )),
                          Expanded(
                            child: TextFormField(
                               cursorColor: const Color(0xff5E686B),focusNode: phoneNumberFocusNode,
                              cursorHeight: 20,
                              cursorWidth: 1.5,
                              onTap: (){
                                ScaffoldMessenger.of(context).removeCurrentSnackBar();
                              },
                              controller: _phoneNo,
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(13),
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
                    TextFieldForm(
                      tfController: TextEditingController(text: stateName),
                      hintText: "State",topPadding: 16,bottomPadding: 0,readOnly: true,
                      onTap:() async {
                        try{
                          stateName=await showModalBottomSheet(context: context, builder: (context) => GetState(countryShortName: countryShortName,));
                        }catch(_){}
                       setState(() {
                       });
                         },
                       postfix: const IconButton(
                        onPressed: null,
                        icon: Icon(Icons.keyboard_arrow_down,color: whiteColor,)),),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              FocusManager.instance.primaryFocus?.unfocus();
                              DateTime? data = await showDatePicker(
                                  context: context,
                                  initialDate:
                                  dateOfBirth ?? DateTime(1999, 05, 28),
                                  firstDate: DateTime(1950),
                                  lastDate: DateTime.now());
                              if (data != null) {
                                setState(() {
                                  dateOfBirth = data;
                                });
                              }
                            },
                            child:      Container(

                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(38),
                                  border:
                                  Border.all(width: 2, color: const Color(0xffE6E6E6))),
                              margin: const EdgeInsets.only(top: 16, left: 20, right: 10),
                              padding: EdgeInsets.symmetric(vertical: 14),
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 13,
                                  ),
                                  const Icon(Icons.calendar_month,color: Colors.white, size: 18),
                                  const SizedBox(
                                    width: 14,
                                  ),
                                  Text(
                                    dateOfBirth != null
                                        ? DateFormat("yyyy/MM/dd")
                                        .format(dateOfBirth!)
                                        : "Birth",
                                    style: w_500.copyWith(
                                      color: textFieldColor,
                                      fontSize: 16,
                                      letterSpacing: .5,
                                    ),
                                  )
                                ],
                              ),
                            ),

                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(38),
                              border:
                              Border.all(width: 2, color: const Color(0xffE6E6E6))),
                          margin: const EdgeInsets.only(top: 16, right: 20),
                          // padding: EdgeInsets.symmetric(vertical: 14),
                          child:Row(
                            children: [
                              const SizedBox(
                                width: 13,
                              ),
                              const Icon(Icons.person,color: Colors.white, size: 18),
                              const SizedBox(
                                width: 8,
                              ),
                              DropdownButton<String>(
                                underline: Container(),
                                icon:   const Padding(
                                  padding: EdgeInsets.only(right: 8.0),
                                  child: Icon(Icons.keyboard_arrow_down_rounded,color: whiteColor,),
                                ),
                                value: dropDownValue,
                                hint: Text("Gender",style: w_500.copyWith(
                                  color: textFieldColor,
                                  fontSize: 16,
                                  letterSpacing: .5,
                                )),
                                onChanged: (newValue) {
                                  setState(() {
                                    dropDownValue = newValue;
                                    items.remove(newValue);
                                    items.insert(0, newValue!);
                                  });
                                },
                                dropdownColor: blackColor,
                                items: items.map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value,style: w_500.copyWith(
                                          color: textFieldColor,
                                          fontSize: 16,
                                          letterSpacing: .5,
                                        )),
                                      );
                                    }).toList(),
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32,),
                    Button(buttonTxt: "Complete Sign Up", function: () async {
                      setState(() {
                        loading=true;
                      });
                      loading=await fun.personalInfo(context,
                        firstName: _firstName.text.trim(),
                        lastName: _lastName.text.trim(),
                        userName: _userName.text.trim(),
                        phone_no: _phoneNo.text.trim(),
                        country: countryName,
                        flag: flag,gender: dropDownValue,
                          dob: dateOfBirth.toString(),
                        country_code: countryCode,state: stateName);
                      setState(() {
                      });
                      // locator<NavigationService>().namedNavigateTo(TwoWayAuth.route);
                    }),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}



