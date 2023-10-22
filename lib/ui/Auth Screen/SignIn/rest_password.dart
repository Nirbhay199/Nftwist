import 'package:flutter/material.dart';
import 'package:nftwist/provider/auth.dart';
import 'package:nftwist/widget/button.dart';
import 'package:nftwist/widget/loader_screen.dart';
import 'package:provider/provider.dart';

import '../../../constant/style.dart';
import '../../../widget/textfiels/textfield.dart';

class RestPassword extends StatefulWidget {
  const RestPassword({Key? key}) : super(key: key);
  static const route = 'rest_password';

  @override
  State<RestPassword> createState() => _RestPasswordState();
}

class _RestPasswordState extends State<RestPassword> {
  final TextEditingController _newPassController = TextEditingController();
  final TextEditingController _retypePassController = TextEditingController();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    var fun = Provider.of<Auth>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: LoaderPage(
        loading: loading,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
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
                      "Reset Password",
                      style: w_700.copyWith(fontSize: 24),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text("Enter new and secure password",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Color(0xff7B7B7B),
                        ),
                        textAlign: TextAlign.center),
                    TextFieldForm(
                      tfController: _newPassController,
                      hintText: "New password",
                      isPass: true,
                      topPadding: 24,
                    ),
                    TextFieldForm(
                      tfController: _retypePassController,
                      hintText: "Re-type new password",
                      isPass: true,
                      topPadding: 16,
                      bottomPadding: 48,
                    ),
                    Button(
                        buttonTxt: "Save New Password",
                        function: () async {
                          setState(() {
                            loading = true;
                          });
                          loading = await fun.setForgetPassword(
                              _newPassController.text,
                              _retypePassController.text);
                          // Provider.of<Auth>(context,listen: false).verifyOtp(emails: email.toString(),confirmPass: _retypePassController.text,newPass: _newPassController.text,otps: _otpController.text);// locator<NavigationService>().namedNavigateTo(PersonalDetails.route);
                        }),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
