import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nftwist/widget/loader_screen.dart';
import 'package:provider/provider.dart';

import '../../../constant/style.dart';
import '../../../provider/auth.dart';
import '../../../provider/user.dart';
import '../../../services/api_response_handler.dart';
import '../../../services/locator.dart';
import '../../../services/navigation_service.dart';
import '../../../widget/button.dart';
import '../../../widget/textfiels/otp_field.dart';
import '../../Bottom Nav Bar/bottom_nav_bar.dart';

class Verify2WayEmail extends StatefulWidget {
  const Verify2WayEmail({Key? key}) : super(key: key);
  static const route = 'verify2way_email';

  @override
  State<Verify2WayEmail> createState() => _Verify2WayEmailState();
}

class _Verify2WayEmailState extends State<Verify2WayEmail> {
  final TextEditingController _controller =TextEditingController();
  int _timer = 30;
  Timer? _timer1;
  var onScreen = true;
  bool loading=false;
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }
  reSend() async{
    startTimer();
    bool isOtpSend = await Provider.of<Auth>(context, listen: false).TwoFA(1);
    if(!isOtpSend){
setState(() {
  _timer1?.cancel();
  _timer=30;
});
    }
  }
  @override
  Widget build(BuildContext context) {
    var user=Provider.of<User>(context,listen: true).user;
    var fun = Provider.of<Auth>(context, listen: false);

    return WillPopScope(
      onWillPop: () async=> false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: LoaderPage(
          loading: loading,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).viewPadding.top + 30,
                    right: 20,
                    left: 20),
                child: Text(
                  "Let’s Set Up Your 2-Way Factor Authentication",
                  style: w_700.copyWith(fontSize: 24),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                "We sent you a 4 digit code to your Email id ",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff7B7B7B),
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${user?.email}",
                    style:  const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(width: 5,),
                  SvgPicture.asset("assets/icons/pencil-fill.svg")

                ],
              ),
              OtpField(controller:_controller),
              Button(
                  buttonTxt: "Verify",
                  function:() async{
                    FocusManager.instance.primaryFocus?.unfocus();
                    setState(() {
                      loading=true;
                    });
                    var result =await ApiResponse().twoFactorAuth(0, _controller.text);
                    print(result.statusCode);
                    if(result.statusCode==200){
                      locator<NavigationService>()
                          .namedNavigateTo(BottomNavBar.route);
                    }else{
                      setState(() {
                        loading=false;
                      });
                    }
                  },
                  verticalPadding: 15),
              Padding(
                padding: const EdgeInsets.fromLTRB(2,18,2,0),
                child: GestureDetector(
                  onTap: _timer1==null||_timer1!.isActive?null:(){
                    reSend();
                  },
                  child: Text(
                    "Resend Code ${_timer==30?'':' in 00:${_timer<10?"0$_timer":_timer}'}",
                    style:  TextStyle(fontSize: 14,decoration: _timer==30?TextDecoration.underline:TextDecoration.none, fontWeight: FontWeight.w600),
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
