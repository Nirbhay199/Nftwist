import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nftwist/widget/textfiels/otp_field.dart';
import 'package:provider/provider.dart';

import '../../../constant/style.dart';
import '../../../provider/auth.dart';
import '../../../widget/button.dart';
import '../../../widget/loader_screen.dart';
class TwoFAAuth extends StatefulWidget {
  const TwoFAAuth({super.key});

static const route="2_fA_otp";
  @override
  State<TwoFAAuth> createState() => _TwoFAAuthState();
}
class _TwoFAAuthState extends State<TwoFAAuth> {
  bool loading=false;
  final TextEditingController _controller=TextEditingController();
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
    bool isOtpSend = await Provider.of<Auth>(context, listen: false).TwoFALoginOtp();
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
    var fun = Provider.of<Auth>(context, listen: false);
    return WillPopScope(
      onWillPop: ()async=>false,
      child: LoaderPage(
        loading: loading,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        "assets/images/abstract-oil-shape-2021-08-26-15-42-43-utc 2-3.png"),
                    fit: BoxFit.fill,
                  )),
              child: Container(
                color: Colors.black.withOpacity(.74),
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).viewPadding.top + 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Text(
                        "Please enter OTP sent to your Mobile and Email",
                        style: w_700,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),

                    OtpField(controller: _controller),
                    Button(
                        buttonTxt: "Verify",
                        function: () async{
                          FocusManager.instance.primaryFocus?.unfocus();
                          setState((){loading=true;});
                          loading=await  fun.verifyTwoAF(context,_controller.text);
                          setState(() {
                          });
                         },
                        verticalPadding: 15),
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
              )),
        ),
      ),
    );
  }
}
