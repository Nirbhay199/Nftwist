import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nftwist/constant/color.dart';
import 'package:nftwist/services/api_response_handler.dart';
import 'package:nftwist/services/locator.dart';
import 'package:nftwist/services/navigation_service.dart';
import 'package:nftwist/ui/Auth%20Screen/SignIn/verify_email_2way.dart';
import 'package:nftwist/widget/loader_screen.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:provider/provider.dart';

import '../../../constant/style.dart';
import '../../../constant/toaster.dart';
import '../../../provider/auth.dart';
import '../../../provider/user.dart';
import '../../../widget/button.dart';
import '../../../widget/textfiels/otp_field.dart';

class Verify2wayPhone extends StatefulWidget {
  final int screenType;
  const Verify2wayPhone({Key? key,this.screenType=0}) : super(key: key);
  static const route = 'verify_no';

  @override
  State<Verify2wayPhone> createState() => _Verify2wayPhoneState();
}

class _Verify2wayPhoneState extends State<Verify2wayPhone> {
  final TextEditingController _controller=TextEditingController();
  bool loading=false;
  int _timer = 30;
  Timer? _timer1;
  var onScreen = true;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    onScreen = false;
    _timer1?.cancel();
  }

  startTimer() {
    if (_timer == 0 || _timer == 30) {
      _timer1 = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (onScreen) {
          setState(() {
            // _timer = timer.tick;
            _timer--;
          });
          if (_timer == 0) {
            timer.cancel();
            _timer1!.cancel();
            _timer = 30;
          }
        } else {
          _timer = 30;
        }
      });
    }
  }

  reSend() async {
    startTimer();
    bool isOtpSend = await Provider.of<Auth>(context, listen: false).TwoFA(0);
    if (!isOtpSend) {
      setState(() {
        _timer=30;
        _timer1?.cancel();
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context, listen: true).user;
    return WillPopScope(
      onWillPop: () async=> false,
      child: LoaderPage(loading: loading,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding:   EdgeInsets.only(                    top: MediaQuery.of(context).viewPadding.top + 10,
                ),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(onPressed: (){
                      locator<NavigationService>().goBack(data: true);
                    }, icon: Icon(Icons.arrow_back,color: whiteColor,))),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: 10,
                    right: 20,
                    left: 20),
                child: Text(
                  "Let’s Set Up Your 2-Way Factor Authentication",
                  style: w_700,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                "We sent you a 4 digit code to your Phone no.",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff7B7B7B),
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "+${user?.country_code} ${user?.phone_no}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  // SvgPicture.asset("assets/icons/pencil-fill.svg")
                ],
              ),
              OtpField(controller: _controller),
              Button(
                  buttonTxt: "Verify",
                  function:_controller.text!=''? () async{
                    FocusManager.instance.primaryFocus?.unfocus();
                    setState(() {
                      loading=true;
                    });
                    var result =await ApiResponse().twoFactorAuth(1, _controller.text);
                    print(result.statusCode);
                    if(result.statusCode==200){
                      locator<NavigationService>()
                          .namedNavigateTo(Verify2WayEmail.route);
                    }else{
                      var data=await jsonDecode(result.body);
                      locator<Toaster>().showToaster(msg: data["error_description"]);
                      setState(() {
                        loading=false;
                      });
                    }
                  }:null,
                  verticalPadding: 0),
              Padding(
                padding: const EdgeInsets.fromLTRB(2,18,2,0),
                child: InkWell(
                  onTap: _timer1 == null || _timer1!.isActive
                      ? null
                      : () {
                          // locator<NavigationService>().namedNavigateTo(Verify2WayEmail.route);
                          reSend();
                        },
                  child: Text(
                    "Resend Code ${_timer == 30 ? '' : ' in 00:${_timer < 10 ? "0$_timer" : _timer}'}",
                    style: TextStyle(
                        fontSize: 14,
                        decoration: _timer == 30
                            ? TextDecoration.underline
                            : TextDecoration.none,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
