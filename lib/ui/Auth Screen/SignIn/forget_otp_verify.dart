import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nftwist/services/navigation_service.dart';
import 'package:nftwist/widget/loader_screen.dart';
import 'package:provider/provider.dart';

import '../../../constant/style.dart';
import '../../../constant/toaster.dart';
import '../../../provider/auth.dart';
import '../../../services/locator.dart';
import '../../../widget/button.dart';
import '../../../widget/textfiels/otp_field.dart';

class ForgetVerifyPassword extends StatefulWidget {
  const ForgetVerifyPassword({Key? key}) : super(key: key);
  static const route = 'forget_verify_email';

  @override
  State<ForgetVerifyPassword> createState() => _ForgetVerifyPasswordState();
}

class _ForgetVerifyPasswordState extends State<ForgetVerifyPassword> {
 TextEditingController _controller=TextEditingController();
  int _timer = 30;
  Timer? _timer1;
  var onScreen = true;

  bool loader = false;

  @override
  void dispose() {
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

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  var data;
  reSend() async {
    startTimer();
    bool isOtpSend = await Provider.of<Auth>(context, listen: false)
        .forgetPasswordSendOpt(email: data["email"],value: data["value"],phone: data["phone"],country: data["countryCode"],resend: true);
    if (!isOtpSend) {
    setState(() {
      _timer1?.cancel();
      _timer=30;
    });
    }
  }

  @override
  Widget build(BuildContext context) {
    var fun = Provider.of<Auth>(context, listen: false);
    data = ModalRoute.of(context)?.settings.arguments;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: LoaderPage(
          loading: loader,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).viewPadding.top + 30,
                    right: 20,
                    left: 20),
                child: Text(
                  "OTP Verification",
                  style: w_700.copyWith(fontSize: 24),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "We sent you a 4 digit code to your ${data["value"] == true ? "Email id" : "Phone no."} ",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff7B7B7B),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data["value"] == true
                        ? "${data["email"]}"
                        : "+${data["countryCode"]}-${data["phone"]}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                      onTap: (){
                        locator<NavigationService>().goBack(data: false);
                      },
                      child: SvgPicture.asset("assets/icons/pencil-fill.svg"))
                ],
              ),
              OtpField(controller: _controller),
              Button(
                  buttonTxt: "Verify",
                  function: () async {

                    if (_controller.text.toString().length == 4 &&
                        _controller.text.toString().isNotEmpty) {
                      setState(() {
                        loader = true;
                      });
                      loader =await fun.forgetPasswordVerifyOtp(context,
                          phone: data["phone"],
                          value: data["value"],
                          otp: _controller.text,
                          email: data["email"],
                          country: data["countryCode"]);
                      // locator<NavigationService>().namedNavigateTo(BottomNavBar.route);
                      setState(() {});
                    } else {
                      locator<Toaster>().showToaster(msg: "Please Enter OTP");
                    }
                  },
                  verticalPadding: 15),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: GestureDetector(
                  onTap: _timer1 == null || _timer1!.isActive
                      ? null
                      : () {
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
