import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nftwist/constant/color.dart';
import 'package:nftwist/services/storageFunctions.dart';
import 'package:nftwist/ui/Auth%20Screen/Signup/sign_up.dart';
import 'package:nftwist/widget/alert_dialog.dart';
import 'package:nftwist/widget/loader_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constant/style.dart';
import '../../../provider/auth.dart';
import '../../../provider/user.dart';
import '../../../widget/button.dart';
import '../../../widget/textfiels/otp_field.dart';

class VerifyEmail extends StatefulWidget {
  final int screenType;
  const VerifyEmail({Key? key,this.screenType=0}) : super(key: key);
  static const route = 'verify_email';

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  TextEditingController _controller=TextEditingController();

  int _timer = 30;
  Timer? _timer1;
  var onScreen = true;
  bool isLoading=false;
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     if(widget.screenType==0){startTimer();}else{
      reSend();
    }
  }
  reSend() async{
    startTimer();
    var userInfo=Provider.of<User>(context,listen: false).user;
    bool isOtpSend=await Provider.of<Auth>(context,listen: false).resendEmailOtp(email: userInfo?.email,userType: userInfo?.user_type);
    if(!isOtpSend){
      _timer1?.cancel();
      _timer=30;
    setState(() {
      isLoading=false;
    });}
  }
  @override
  Widget build(BuildContext context) {
    var user=Provider.of<User>(context,listen: true).user;
    var fun = Provider.of<Auth>(context, listen: false);

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
            isLoading=true;
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
          resizeToAvoidBottomInset: false,
          body: LoaderPage(
             loading: isLoading,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    "Verify your Email",
                    style: w_700.copyWith(fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
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
                    // const SizedBox(width: 5,),
                    // SvgPicture.asset("assets/icons/pencil-fill.svg")

                  ],
                ),
                OtpField(controller:_controller ),

                Button(
                    buttonTxt: "Verify",
                    function:_controller.text==''? null:() async {
                      FocusManager.instance.primaryFocus?.unfocus();
                      setState(() {
                        isLoading=true;
                      });
                     isLoading=await fun.verifyEmailDevice(context,otps:_controller.text );

                      setState(() {
                      });
                      // locator<NavigationService>().namedNavigateTo(BottomNavBar.route);
                    },
                    verticalPadding: 15),
                 Padding(
                  padding: const EdgeInsets.all(2.0),
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
      ),
    );
  }
}
