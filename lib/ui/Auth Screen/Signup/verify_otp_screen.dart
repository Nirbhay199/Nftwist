import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nftwist/provider/auth.dart';
import 'package:nftwist/provider/user.dart';
import 'package:nftwist/ui/Auth%20Screen/Signup/personal_details.dart';
import 'package:nftwist/ui/Auth%20Screen/Signup/sign_up.dart';
import 'package:nftwist/widget/alert_dialog.dart';
import 'package:nftwist/widget/loader_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constant/color.dart';
import '../../../constant/style.dart';
import '../../../services/locator.dart';
import '../../../services/navigation_service.dart';
import '../../../services/storageFunctions.dart';
import '../../../widget/button.dart';
import '../../../widget/textfiels/otp_field.dart';

class OTPVerify extends StatefulWidget {
  final int screenType;
  const OTPVerify({Key? key,this.screenType=0}) : super(key: key);
static const route='otp_verify';
  @override
  State<OTPVerify> createState() => _OTPVerifyState();
}

class _OTPVerifyState extends State<OTPVerify> {
  TextEditingController _controller=TextEditingController();

  int _timer = 30;
  Timer? _timer1;
  var onScreen = true;
 bool loader= false;
  bool popUp=false;
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

  reSend() async{
    startTimer();
    var userInfo=Provider.of<User>(context,listen: false).user;
    bool isOtpSend=await Provider.of<Auth>(context,listen: false).resendOtp(countryCode: userInfo!.country_code,phoneNo:userInfo.phone_no,userType: userInfo.user_type);
    if(!isOtpSend){
      _timer1?.cancel();
      _timer=30;
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.screenType==0){startTimer();}else{
      reSend();
    }

  }
  @override
  Widget build(BuildContext context) {
   var  user=Provider.of<User>(context,listen: true).user;
   var  fun=Provider.of<Auth>(context,listen: false);
    return WillPopScope(
      onWillPop: () async {
        return  false;
      },
      child: CustomAlertDialog(
        loading: popUp,
        title:'Confirmation !',
        subtitle:  'Are you sure you want to Logout ?',
        button1Txt: "Yes",
        button2Txt:  "No",
        button1fun: ()async{
          setState(() {
            popUp=false;
            loader=true;
          });
          SharedPreferences prefs= await SharedPreferences.getInstance();
          prefs.remove("token");
          await StorageFunctions().deleteAllValue();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (BuildContext context) =>
            const SignUp()),
            ModalRoute.withName('sign_up'),
          );        },
        button2fun: (){
          setState(() {
            popUp=false;
          });
        },
        child: Scaffold(
          body: LoaderPage(
            loading:loader,
            child: Column(
              children: [

                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(onPressed: (){
                    setState(() {
                      popUp=true;
                    });
                  },
                      style: TextButton.styleFrom(padding: EdgeInsets.only(top:  MediaQuery.of(context).viewPadding.top+10),alignment: Alignment.bottomCenter),
                      child: const Text("LogOut",style: TextStyle(color: whiteColor,fontSize: 10),)),
                      // child: const Text("Skip",style: TextStyle(color: whiteColor,fontSize: 10),)),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    "Verify your Phone No.",
                    style: w_700.copyWith(fontSize: 24),
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
                const SizedBox(height: 5,),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "+${user?.country_code}-${user?.phone_no}",
                      style:  const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(width: 5,),
                    InkWell(
                        onTap: (){
                          if(widget.screenType==1){locator<NavigationService>().namedNavigateTo(PersonalDetails.route);}else{locator<NavigationService>().goBack();}
                        },
                        child: SvgPicture.asset("assets/icons/pencil-fill.svg"))

                  ],
                ),
                OtpField(controller: _controller),

                Button(buttonTxt: "Verify", function:_controller.text.trim()==''?null: () async {
                  print(_controller.text);
                  FocusManager.instance.primaryFocus?.unfocus();
                  setState(() {
                    loader=true;
                  });
              fun.verifyPhoneOtp(context,otp:_controller.text,cc: user?.country_code,ph: user?.phone_no,type:  user?.user_type ).then((_){
                setState(() {
                  loader=false;
                });
              });
                },verticalPadding: 15),
                 Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: InkWell(
                    onTap: _timer1==null||_timer1!.isActive?null:(){
                      reSend();
                    },
                    child: Text("Resend Code ${_timer==30?'':' in 00:${_timer<10?"0$_timer":_timer}'}",style:  TextStyle(
                        fontSize: 14,decoration: _timer==30?TextDecoration.underline:TextDecoration.none,
                        fontWeight: FontWeight.w600
                    ),),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
