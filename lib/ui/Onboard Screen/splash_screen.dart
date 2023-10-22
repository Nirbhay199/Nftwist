import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nftwist/provider/app_content.dart';
import 'package:nftwist/provider/market_place_nfts.dart';
import 'package:nftwist/provider/user.dart';
import 'package:nftwist/services/storageFunctions.dart';
import 'package:nftwist/ui/Onboard%20Screen/onboard_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import '../../constant/color.dart';
import '../../main.dart';
import '../../provider/homeModule.dart';
import '../../services/api_response_handler.dart';
import '../Auth Screen/Signup/personal_details.dart';
import '../Auth Screen/Signup/verify_email.dart';
import '../Auth Screen/Signup/verify_otp_screen.dart';
import '../Bottom Nav Bar/bottom_nav_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const route = 'splash_screen';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;
  String two_fa_done='0';
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) async {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setInt('initScreen', 1);
      two_fa_done=await StorageFunctions().getValue(twoFADone);
      if(token!='') Provider.of<User>(context,listen: false).fetchUser(await jsonDecode(await StorageFunctions().getValue(profile)) , token);
    });
    _controller = VideoPlayerController.asset(
        'assets/video/Logo_transparent_background_motion_blur.mp4',
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: false),
    )
      ..initialize().then((_) async {
        // Ensure the video is looped.
        _controller.setLooping(true);
        _controller.setVolume(0);
        // Start playing the video.
        _controller.play();
        startTimer();
        try{
          country = await ApiResponse().getCountry();
        }catch(_){}
        setState(() {});
      });
    Provider.of<HomeModuleProvider>(context,listen: false).getHomeScreenDate(context);
    Provider.of<AppContents>(context,listen: false).allCollection();
    Provider.of<Nfts>(context,listen: false).getActivePartner();
  }

  Timer? _timer1;
  int time = 0;
  startTimer() {
    _timer1 = Timer.periodic(const Duration(milliseconds: 1), (timer) {
      setState(() {
        time = timer.tick;
        time++;
        if (time >= 2300) {
          _controller.pause();
          timer.cancel();
          _timer1?.cancel();
         var user=Provider.of<User>(context,listen: false).user;
         Future.delayed(Duration.zero).then((value)  async {
         if(user==null||(two_fa_done!='1'&&user.is_two_way_auth_enabled==true)){
             SharedPreferences prefs= await SharedPreferences.getInstance();
          prefs.remove("token");
          await StorageFunctions().deleteAllValue();
        }
         });
          Navigator.push(
              context,
              PageRouteBuilder(
                settings: RouteSettings(
                  name: token==""||user==null||(two_fa_done!='1'&&user.is_two_way_auth_enabled==true)?OnBoardScreen.route:
                  user.is_email_verified==false&&user.user_type==1? VerifyEmail.route:
                  user.phone_no==null&&user.user_type==1? PersonalDetails.route:
                  user.is_phone_verified==false&&user.user_type==1? OTPVerify.route: BottomNavBar.route
                ),
                  pageBuilder: (context, animation, secondaryAnimation) =>
                   token==""||user==null||(two_fa_done!='1'&&user.is_two_way_auth_enabled==true)?const OnBoardScreen():
                   user.is_email_verified==false&&user.user_type==1?const VerifyEmail(screenType: 1,):
                   user.phone_no==null&&user.user_type==1?const PersonalDetails():
                   user.is_phone_verified==false&&user.user_type==1?const OTPVerify(screenType: 1,):const BottomNavBar(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    const begin = Offset(1.0, 0.0);
                    const end = Offset.zero;
                    const curve = Curves.ease;
                    var tween = Tween(begin: begin, end: end)
                        .chain(CurveTween(curve: curve));
                    return SlideTransition(
                      position: animation.drive(tween),
                      child: child,
                    );
                  }));
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor,
      body: Stack(
        children: <Widget>[
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 200),
                width: _controller.value.size.width,
                height: 600,
                child: VideoPlayer(_controller),
              ),
            ),
          ),
          //FURTHER IMPLEMENTATION
        ],
      ),
    );
  }
}
