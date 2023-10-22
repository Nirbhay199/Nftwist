import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nftwist/services/api_response_handler.dart';
import 'package:nftwist/services/locator.dart';
import 'package:nftwist/services/navigation_service.dart';
import 'package:nftwist/ui/Auth%20Screen/SignIn/rest_password.dart';
import 'package:nftwist/ui/Auth%20Screen/SignIn/sign_in.dart';
import 'package:nftwist/widget/button.dart';
import 'package:nftwist/widget/loader_screen.dart';
import 'package:provider/provider.dart';

import '../../../constant/color.dart';
import '../../../constant/get_country.dart';
import '../../../constant/style.dart';
import '../../../constant/toaster.dart';
import '../../../provider/auth.dart';
import '../../../widget/textfiels/textfield.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);
  static const route = 'forgot_password';

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String countryCode = "91";
 bool loading=false;
  @override
  Widget build(BuildContext context) {
  final  value = ModalRoute.of(context)?.settings.arguments;
  // print(value);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: LoaderPage(
        loading: loading,
        child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/images/abstract-oil.png"),
              fit: BoxFit.fill,
            )),
            child: Container(
              color: Colors.black.withOpacity(.74),
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).viewPadding.top + 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Forgot Password",
                    style: w_700.copyWith(fontSize: 24),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                    Text(
                      "Enter your registered ${value == true?"E-mail Address":"Phone number"} to\n receive the Reset password OTP",
                        style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Color(0xff7B7B7B),
                      ),
                      textAlign: TextAlign.center),
                  value == true
                      ? TextFieldForm(
                          tfController: _emailController,
                          hintText: "E-mail Address",
                          topPadding: 20,
                        )
                      : Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(38),
                              border: Border.all(
                                  width: 2, color: const Color(0xffE6E6E6))),
                          margin:
                              const EdgeInsets.only(top: 20, left: 20, right: 20),
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
                                  });
                                },
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Text("+$countryCode",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16)),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const Icon(Icons.keyboard_arrow_down,
                                        color: Colors.white, size: 18),
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
                                  cursorColor: const Color(0xff5E686B),
                                  // focusNode: phoneNumberFocusNode,
                                  cursorHeight: 20,
                                  cursorWidth: 1.5,
                                  onTap: () {
                                    ScaffoldMessenger.of(context)
                                        .removeCurrentSnackBar();
                                  },
                                  controller: _phoneController,
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
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 28),
                  //   child: Row(
                  //     children: [
                  //       Text(
                  //         "Select Reset Type :-",
                  //         style: w_700.copyWith(fontSize: 17),
                  //       ),
                  //       SizedBox(
                  //         width: 5,
                  //       ),
                  //       Text(value == true ? "By Email" : "By Phone No.",
                  //           style: w_400),
                  //       Spacer(),
                  //       Transform.scale(
                  //           scale: 0.7,
                  //           child: Container(
                  //             height: 50,
                  //             width: 50,
                  //             padding: EdgeInsets.only(right: 20),
                  //             child: CupertinoSwitch(
                  //               value: value,
                  //               onChanged: (val) {
                  //                 setState(() {
                  //                   value = val;
                  //                 });
                  //               },
                  //             ),
                  //           ))
                  //     ],
                  //   ),
                  // ),
                  const SizedBox(
                    height: 20,
                  ),
                  Button(
                      buttonTxt: "Send Reset Link",
                      function: () async {
                        FocusManager.instance.primaryFocus?.unfocus();
                        setState(() {
                          loading=true;
                        });
                        //true ==email
                        Provider.of<Auth>(context, listen: false)
                            .forgetPasswordSendOpt(
                                value: value,
                                email: _emailController.text.trim(),
                                phone: _phoneController.text.trim(),
                                country: countryCode).then((_){
                                  setState(() {
                                    loading=false;
                                  });
                        });
                      }),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewPadding.bottom + 10),
                    child: RichText(
                        text: TextSpan(
                            text: "Back to ",
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12),
                            children: [
                          TextSpan(
                              text: "Sign In",
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  locator<NavigationService>()
                                      .popUntil(SignIn.route);
                                })
                        ])),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
