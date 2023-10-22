import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nftwist/constant/color.dart';
import 'package:nftwist/constant/get_city.dart';
import 'package:nftwist/constant/style.dart';
import 'package:nftwist/widget/appBar.dart';
import 'package:nftwist/widget/button.dart';
import 'package:nftwist/widget/loader_screen.dart';
import 'package:provider/provider.dart';

import '../../../constant/get_State.dart';
import '../../../constant/get_business.dart';
import '../../../constant/get_country.dart';
import '../../../constant/toaster.dart';
import '../../../provider/auth.dart';
import '../../../services/api_response_handler.dart';
import '../../../services/locator.dart';
import '../../../widget/textfiels/textfield.dart';

class BecomePartner extends StatefulWidget {
  const BecomePartner({Key? key}) : super(key: key);
  static const route = 'become_partner';

  @override
  State<BecomePartner> createState() => _BecomePartnerState();
}

class _BecomePartnerState extends State<BecomePartner> {
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phoneNo = TextEditingController();
  final TextEditingController _companyName = TextEditingController();
  final TextEditingController _expectedNumber = TextEditingController();
  String countryCode = "971";
  String countryShortName = "AE";
  String stateName = "";
  String countryName = "";
  String cityName = "";
  String? business='';
  bool isLoading= false;


  List? businessList=[];
  var flag = '🇦🇪';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero).then((value) async{
      var res=await  ApiResponse().getBusiness();
      businessList=res;
      business=businessList?[0];
      setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Become a Partner"),
      body: LoaderPage(
        loading: isLoading,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Forging a partnership with us is one of the best decisions you can ever make for your business!",
                style:
                    w_400.copyWith(color: const Color(0xff7B7B7B), fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Text(
                "Get empowered by NFTwist! We help your business enhance its brand, as well drive sales and marketing further. The next big thing is here and we believe you are on track to make history!",
                style: w_600.copyWith(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                  border: Border.all(color: blackBorderColor),
                  borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(vertical: 28),
              child: Column(children: [
                Text(
                  "Enter Your Contact Information",
                  style: w_600.copyWith(fontSize: 16, color: whiteColor),
                ),
                TextFieldForm(
                  tfController: _firstName,
                  hintText: "First name",filterPattern: [LengthLimitingTextInputFormatter(10),FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]"))],
                  topPadding: 24,
                ),
                TextFieldForm(
                  tfController: _lastName,
                  hintText: "Last name",
                  topPadding: 16,
                  filterPattern: [ LengthLimitingTextInputFormatter(10),FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),],
                ),
                TextFieldForm(
                  keyboardType: TextInputType.emailAddress,
                  tfController: _email,
                  hintText: "E-mail address",
                  topPadding: 16,
                  filterPattern: [ LengthLimitingTextInputFormatter(30),],
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(38),
                      border:
                          Border.all(width: 2, color: const Color(0xffE6E6E6))),
                  margin: const EdgeInsets.only(top: 16, left: 20, right: 20),
                  // padding: EdgeInsets.only(left: 0,),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          var a = await showModalBottomSheet(
                              context: context,
                              builder: (context) => const GetCountry());
                          setState(() {
                            countryCode = a['phone'];
                            countryName = a['name'];
                            countryShortName = a['shortName'];
                            flag = a['emoji'];
                          });
                        },
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 13,
                            ),
                            Text("+$countryCode",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16)),
                            const SizedBox(
                              width: 7,
                            ),
                            const Icon(Icons.keyboard_arrow_down,
                                color: Colors.white, size: 18),
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
                          onTap: () {
                            ScaffoldMessenger.of(context).removeCurrentSnackBar();
                          },
                          controller: _phoneNo,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(12),
                            FilteringTextInputFormatter.digitsOnly,

                          ],
                          style: w_500.copyWith(
                            color: textFieldColor,
                            fontSize: 16,
                            letterSpacing: .5,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                const EdgeInsets.fromLTRB(14, 16, 14, 12),
                            hintText: "Phone no.",
                            hintStyle: w_500.copyWith(
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
                  tfController: _companyName,
                  hintText: "Company name",
                  topPadding: 16,
                  filterPattern: [ LengthLimitingTextInputFormatter(25),],
                ),
                // TextFieldForm(
                //   tfController: TextEditingController(text: business),
                //   hintText: "Line of business",
                //   topPadding: 16,
                //   onTap: () async {
                //
                //   },
                //   readOnly: true,
                //   postfix: const IconButton(
                //       onPressed: null,
                //       icon: Icon(
                //         Icons.keyboard_arrow_down,
                //         color: whiteColor,
                //       )),
                // ),
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
                value: business,icon: Container(),dropdownColor: blackColor2,
                items: businessList!.map((value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
               /*     businessList?.remove(newValue);
                    businessList?.insert(0,newValue);*/
                    business = newValue!;
                  });
                },
                decoration: const InputDecoration(
                  hintText: "Line of business",
                  contentPadding: EdgeInsets.all(16),
                  border: InputBorder.none,
                  suffixIcon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white,
                  ),
                ),
              ),
              ),
                TextFieldForm(
                  topPadding: 16,
                  onTap: () async {
                    var a = await showModalBottomSheet(
                        context: context,
                        builder: (context) => const GetCountry());
                    if (a != null) {
                      setState(() {
                        countryName = a['name'];
                        countryShortName = a['shortName'];
                        flag = a['emoji'];
                        // countryCode = a['phone'];
                      });
                    }
                  },
                  tfController: TextEditingController(text: countryName),
                  readOnly: true,
                  postfix: const IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: whiteColor,
                      )),
                  hintText: 'Country',
                ),
                TextFieldForm(
                  tfController: TextEditingController(text: stateName),
                  hintText: "State",
                  onTap: () async {
                    try {
                      stateName = await showModalBottomSheet(
                          context: context,
                          builder: (context) => GetState(
                                countryShortName: countryShortName,
                              ));
                    } catch (_) {}
                    setState(() {});
                  },
                  topPadding: 16,
                  readOnly: true,
                  postfix: const IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: whiteColor,
                      )),
                ),
                TextFieldForm(
                  hintText: "City",
                  tfController: TextEditingController(text: cityName),
                  onTap: () async {
                    try {
                      cityName = await showModalBottomSheet(
                          context: context,
                          builder: (context) => GetCity(
                                countryShortName: countryShortName,
                              ));
                    } catch (_) {}
                    setState(() {});
                  },
                  topPadding: 16,
                  readOnly: true,
                  postfix: const IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: whiteColor,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 24.0, bottom: 8, left: 20, right: 20),
                  child: Text(
                    "Number of Customers you expect to give NFTs?",
                    style: w_400.copyWith(
                        color: const Color(0xff7B7B7B), fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ),
                TextFieldForm(
                  tfController: _expectedNumber,
                  keyboardType: TextInputType.number,
                  hintText: "expected limit",
                  bottomPadding: 32,
                  filterPattern: [ LengthLimitingTextInputFormatter(2),],
                  // postfix: IconButton(
                  //     onPressed: null,
                  //     icon: Icon(
                  //       Icons.keyboard_arrow_down,
                  //       color: whiteColor,
                  //     )),
                ),
                Button(
                    buttonTxt: "Send Request",
                    function: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      if (validation()) {
                        setState(() {
                          isLoading=true;
                        });
                       Provider.of<Auth>(context,listen: false).becomePartnerRequest(
                            state: stateName,
                            phoneNumber: int.parse(_phoneNo.text),
                            lastName: _lastName.text,
                            firstName: _firstName.text,
                            countryCode: countryCode,
                            expLimit: int.parse(_expectedNumber.text),
                            companyName: _companyName.text,
                            city: cityName,
                            business: business,
                            email: _email.text,
                            country: countryName);
                      }
                    }),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
                  child: RichText(
                    text: TextSpan(
                        text: "You can also send us a request to:\n",
                        style: w_700.copyWith(
                            color: const Color(0xff7B7B7B), fontSize: 14),
                        children: [
                          TextSpan(
                              text: "partners@nftwist.io",
                              style:
                                  w_400.copyWith(fontSize: 14, color: pinkColor)),
                        ]),
                    textAlign: TextAlign.center,
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  bool validation() {
    // int number=int.parse(_expectedNumber.text);
    var toast = locator<Toaster>();
    bool validate = true;
    if (_firstName.text.isEmpty) {
      toast.showToaster(
          msg: "Please enter your First Name.",
          toasterDurationMilli: 1200,
          loadingDuration: 4);
      validate = false;
    } else if (_lastName.text.isEmpty) {
      toast.showToaster(
          msg: "Please enter your Last Name.",
          toasterDurationMilli: 1200,
          loadingDuration: 4);
      validate = false;
    } else if (_email.text.isEmpty) {
      toast.showToaster(
          msg: "Please enter your Email Address.",
          toasterDurationMilli: 1200,
          loadingDuration: 4);
      validate = false;
    } else if (!RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(_email.text)) {
      validate = false;
      toast.showToaster(msg: "Please provide valid e-mail Address");
    } else if (_phoneNo.text.isEmpty) {
      toast.showToaster(
          msg: "Please enter your mobile number.",
          toasterDurationMilli: 1200,
          loadingDuration: 4);
      validate = false;
    } else if (_companyName.text.isEmpty) {
      toast.showToaster(
          msg: "Please enter your Company name.",
          toasterDurationMilli: 1200,
          loadingDuration: 4);
      validate = false;
    } else if (business == "" || business==null) {
      toast.showToaster(
          msg: "Please select Line of Business.",
          toasterDurationMilli: 1200,
          loadingDuration: 4);
      validate = false;
    } else if (countryName == "" || countryName.isEmpty) {
      toast.showToaster(
          msg: "Please select Country.",
          toasterDurationMilli: 1200,
          loadingDuration: 4);
      validate = false;
    } else if (stateName == "" || stateName.isEmpty) {
      toast.showToaster(
          msg: "Please select State.",
          toasterDurationMilli: 1200,
          loadingDuration: 4);
      validate = false;
    } else if (cityName == "" || cityName.isEmpty) {
      toast.showToaster(
          msg: "Please select City.",
          toasterDurationMilli: 1200,
          loadingDuration: 4);
      validate = false;
    } else if (_expectedNumber.text == "" || cityName.isEmpty) {
      toast.showToaster(
          msg: "Please enter the number of customers you want to gift NFTs",
          toasterDurationMilli: 1200,
          loadingDuration: 4);
      validate = false;
    }
    return validate;
  }
}
