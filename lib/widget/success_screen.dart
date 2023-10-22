import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nftwist/constant/style.dart';
import 'package:nftwist/provider/user.dart';
import 'package:nftwist/services/locator.dart';
import 'package:nftwist/services/navigation_service.dart';
import 'package:nftwist/ui/Bottom%20Nav%20Bar/bottom_nav_bar.dart';
import 'package:provider/provider.dart';
class SuccessFullScreen extends StatefulWidget {
  const SuccessFullScreen({super.key});
  static const route ='success_screen';

  @override
  State<SuccessFullScreen> createState() => _SuccessFullScreenState();
}

class _SuccessFullScreenState extends State<SuccessFullScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then((value) {
      Provider.of<User>(context,listen: false).setGiftNftId(null);
      locator<NavigationService>().popUntil(BottomNavBar.route);
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    String successMessage=ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(successMessage??'',style: w_600,),
            const SizedBox(height: 15,),
            SvgPicture.asset("assets/icons/verified.svg"),
          ],
        ),
      ),
    );
  }
}
