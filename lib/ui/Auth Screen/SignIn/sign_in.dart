import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nftwist/constant/color.dart';
import 'package:nftwist/services/locator.dart';
import 'package:nftwist/services/navigation_service.dart';
import 'package:nftwist/ui/Auth%20Screen/SignIn/forgot_password.dart';
import 'package:nftwist/ui/Auth%20Screen/Social%20Login/social_login.dart';
import 'package:nftwist/ui/Bottom%20Nav%20Bar/bottom_nav_bar.dart';
import 'package:nftwist/widget/loader_screen.dart';
import 'package:provider/provider.dart';

import '../../../constant/style.dart';
import '../../../provider/auth.dart';
import '../../../widget/button.dart';
import '../../../widget/textfiels/textfield.dart';
class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);
static const route='sign_in';

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool loading=false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var fun = Provider.of<Auth>(context, listen: false);
    return WillPopScope(
      onWillPop: () async{
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
                        "assets/images/abstract-oil.png"),
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
                      "Sign In",
                      style: w_700.copyWith(fontSize: 24),
                    ),
                    const SizedBox(height: 16,),
                    const Text("For added security, please setup your 2-way\n factor!",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14, color: Color(0xff7B7B7B),),textAlign: TextAlign.center),
                    TextFieldForm(hintText: "E-mail Address",topPadding: 24,tfController: _emailController,),
                    TextFieldForm(hintText: "Password",isPass: true,topPadding: 16,bottomPadding: 32,tfController: _passwordController,),
                    Button(buttonTxt: "Sign In", function: () async {
                        FocusScope.of(context).requestFocus(FocusNode());
                            setState(() {
                              loading=true;});
                             loading =await fun.signIn(context,
                           email: _emailController.text.trim(),
                           password: _passwordController.text.trim());
                       setState(() {
                             });
                    }),
                    TextButton(onPressed: (){
                      showCupertinoDialog(
                        context: context,
                        builder: (context) {
                          return const CustomDialogSignupLogin();
                        },
                      );
                      // locator<NavigationService>().namedNavigateTo(ForgotPassword.route);
                    },
                        child: const Text("Forgot Password?",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14,color: textColor,decoration: TextDecoration.underline),)),
                    const SizedBox(height: 40,),
                    const SocialWidget( ),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewPadding.bottom+10),
                      child: RichText(text:  TextSpan(text: "Don’t have an account? ",style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 12),children: [
                        TextSpan(text:"Sign Up",style:  const TextStyle(fontWeight: FontWeight.w600,fontSize: 14,decoration: TextDecoration.underline,),recognizer: TapGestureRecognizer()..onTap=(){
                          locator<NavigationService>().goBack();
                        })
                      ])),
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}



class CustomDialogSignupLogin extends StatefulWidget {
  const CustomDialogSignupLogin({Key? key}) : super(key: key);

  @override
  State<CustomDialogSignupLogin> createState() => _CustomDialogSignupLoginState();
}

class _CustomDialogSignupLoginState extends State<CustomDialogSignupLogin> {

  dialogContent(BuildContext context) {
    return SingleChildScrollView(child:Container(
      decoration: BoxDecoration(
        color: Color(0xff111111),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children:  [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 35,horizontal: 10),
              child: Row(
                children: [
                  const Spacer(),
                  Text("Forgot Password",style: w_700.copyWith(color: Colors.white),),
                  const Spacer(),
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                      child: const Icon(Icons.close,color: Colors.white,)),
                ],
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Button(
                  buttonTxt: "Recover via Email",
                  txtColor: Colors.white,
                  function: () async {
                    locator<NavigationService>().namedNavigateTo(ForgotPassword.route,arguments: true);
                  },
                ),
              ),

            ],
          ),
          const SizedBox(height: 12,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Button(
                  buttonTxt: "Recover via Phone No.",
                  txtColor: Colors.white,
                  function: () async {
                    locator<NavigationService>().namedNavigateTo(ForgotPassword.route,arguments: false);
                  },
                ),
              ),

            ],
          ),
          const SizedBox(height: 55,),
        ],),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 20),
      child: dialogContent(context),
    );
  }
}