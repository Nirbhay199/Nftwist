import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nftwist/constant/color.dart';
import 'package:nftwist/constant/style.dart';
import 'package:nftwist/main.dart';
import 'package:nftwist/provider/user.dart';
import 'package:nftwist/services/locator.dart';
import 'package:nftwist/services/navigation_service.dart';
import 'package:nftwist/services/storageFunctions.dart';
import 'package:nftwist/ui/Bottom%20Nav%20Bar/home/home_screen.dart';
import 'package:nftwist/ui/Bottom%20Nav%20Bar/notification/notification.dart';
import 'package:nftwist/ui/Bottom%20Nav%20Bar/profile/Partner%20profile/partner_profile.dart';
import 'package:nftwist/ui/Bottom%20Nav%20Bar/profile/User%20profile/profile.dart';
import 'package:nftwist/ui/Bottom%20Nav%20Bar/search/market_place.dart';
import 'package:nftwist/ui/Bottom%20Nav%20Bar/tabBar/tab_indecator.dart';
import 'package:nftwist/widget/alert_dialog.dart';
import 'package:nftwist/widget/button.dart';
import 'package:nftwist/widget/gust_login_alert.dart';
import 'package:provider/provider.dart';

import '../../provider/homeModule.dart';
import '../../provider/market_place_nfts.dart';
import '../../provider/tab_controller.dart';
import '../../widget/textfiels/textfield.dart';
 import 'QR Scanner/qr_scanner.dart';

var future;

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);
  static const route = 'bottom';

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int currentIndex = 0;
  String auth_token = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    future = Provider.of<Nfts>(context, listen: false).getNewsFeeds();
    _tabController = TabController(length: 5, vsync: this);
    _tabController.addListener(() {
      setState(() {
        if (auth_token != '') {
          Provider.of<AppTabController>(context, listen: false)
              .setIndex(_tabController.index);
          currentIndex = _tabController.index;
        } else {
          if (_tabController.index >= 2) {
            _tabController.index = _tabController.previousIndex;
          } else {
            Provider.of<AppTabController>(context, listen: false)
                .setIndex(_tabController.index);
            currentIndex = _tabController.index;
          }
        }
      });
    });
    userInfo();
  }

  userInfo() async {
    auth_token = await StorageFunctions().getValue(authToken);
    setState(() {});
    if (auth_token != '') {
      Provider.of<User>(context, listen: false).getUserProfile();
    }
  }

  @override
  Widget build(BuildContext context) {
    var pages = [
      Home(tabController: _tabController),
      const Marketplace(),
      QRScanner(tabController: _tabController),
      const Notifications(),
      Provider.of<User>(context).user?.user_type == 2
          ? const PartnerProfile()
          : const UserProfile(),
    ];
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        bottomNavigationBar: Material(
          color: blackColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          child: DefaultTabController(
            length: 5,
            child: TabBar(
              controller: _tabController,
              indicator: RoundedTabIndicator(
                  width: 24,
                  height: 3,
                  radius: 10,
                  bottomMargin: MediaQuery.of(context).viewPadding.bottom == 0
                      ? 10
                      : MediaQuery.of(context).viewPadding.bottom - 10),
              onTap: (_) {
                if (auth_token != '') {
                  if (_ == 4) {
                    Provider.of<User>(context, listen: false).getUserProfile();
                  }
                } else {
                  if (_ >= 2) {
                    alert(context);
                  }
                }
              },
              indicatorColor: whiteColor,
              indicatorSize: TabBarIndicatorSize.tab,
              // labelColor: secondaryColor,
              dividerColor: Colors.transparent,
              // unselectedLabelColor: lightColor,
              indicatorPadding: const EdgeInsets.symmetric(horizontal: 10),
              tabs: [
                SizedBox(
                  height: 52 + MediaQuery.of(context).viewPadding.bottom,
                  child: SvgPicture.asset(currentIndex == 0
                      ? "assets/icons/home_select.svg"
                      : "assets/icons/home.svg"),
                ),
                SizedBox(
                  height: 52 + MediaQuery.of(context).viewPadding.bottom,
                  child: SvgPicture.asset(currentIndex == 1
                      ? "assets/icons/search_select.svg"
                      : "assets/icons/search.svg"),
                ),
                SizedBox(
                  height: 52 + MediaQuery.of(context).viewPadding.bottom,
                  child: SvgPicture.asset(currentIndex == 2
                      ? "assets/icons/scanner_select.svg"
                      : "assets/icons/scanner.svg"),
                ),
                SizedBox(
                  height: 52 + MediaQuery.of(context).viewPadding.bottom,
                  child: SvgPicture.asset(currentIndex == 3
                      ? "assets/icons/notification_select.svg"
                      : "assets/icons/notification.svg"),
                ),
                SizedBox(
                  height: 52 + MediaQuery.of(context).viewPadding.bottom,
                  child: SvgPicture.asset(currentIndex == 4
                      ? "assets/icons/profile_select.svg"
                      : "assets/icons/profile.svg"),
                ),
              ],
            ),
          ),
        ),
        body: pages[currentIndex],
      ),
    );
  }
}
