import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nftwist/constant/style.dart';
import 'package:nftwist/provider/auth.dart';
import 'package:nftwist/services/locator.dart';
import 'package:nftwist/services/navigation_service.dart';
import 'package:nftwist/ui/Auth%20Screen/SignIn/sign_in.dart';
import 'package:nftwist/ui/Auth%20Screen/Social%20Login/social_login.dart';
import 'package:nftwist/widget/button.dart';
import 'package:nftwist/widget/loader_screen.dart';
import 'package:nftwist/widget/textfiels/textfield.dart';
import 'package:provider/provider.dart';

import '../../../constant/color.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  static const route = 'sign_up';

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool loading=false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var fun = Provider.of<Auth>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        return  false;
      },
      child: LoaderPage(
        loading: loading ,
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(
                    "assets/images/abstract-oil-shape-2021-08-26-15-42-43-utc 2.png"),
                fit: BoxFit.fill,
              )),
            ),
            Scaffold(
                backgroundColor: Colors.transparent,
                body: Container(
                  color: Colors.black.withOpacity(.74),
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).viewPadding.top + 30, bottom: 32),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Sign Up",
                        style: w_700.copyWith(fontSize: 24),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 20),
                        child: RichText(
                          text: const TextSpan(
                              text:
                                  "Welcome to the fastest growing NFT platform. NFTwist is the easiest way to get started and dive freely into the world of NFTs.\n\n",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              children: [
                                TextSpan(
                                  text:
                                      "We create for you a secure and unique wallet upon sign up, where you will receive and store your NFTs.\n\n",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: whiteColor2,
                                  ),
                                ),
                                TextSpan(
                                    text:
                                        "We do not own your private keys and cannot access your funds without your confirmation.",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ))
                              ]),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      TextFieldForm(
                        hintText: "E-mail Address",
                        tfController: _emailController,
                      ),
                      TextFieldForm(
                        hintText: "Password",
                        isPass: true,
                        tfController: _passwordController,
                        topPadding: 16,
                      ),
                      TextFieldForm(
                        hintText: "Re-type password",
                        tfController: _confPasswordController,
                        isPass: true,
                        topPadding: 16,
                      ),

                      Button(
                          buttonTxt: "Sign Up",
                          function: () async{
                            FocusScope.of(context).requestFocus(FocusNode());
                            setState(() {
                              loading=true;});
                             loading =await fun.signUp(context,
                                email: _emailController.text.trim(),
                                confirmPassword:
                                    _confPasswordController.text.trim(),
                                password: _passwordController.text.trim());
                             setState(() {
                             });
                          },
                          verticalPadding: 32),
                      const SocialWidget(),
                      const SizedBox(height: 10,),
                    ],
                  ),
                )),
            Positioned(
              bottom: 0,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewPadding.bottom + 10),
                child: RichText(
                    text: TextSpan(
                        text: "Already have an account? ",
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
                                      .namedNavigateTo(SignIn.route);
                                })
                        ]),
                    textAlign: TextAlign.center),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
