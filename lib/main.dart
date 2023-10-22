
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nftwist/constant/toaster.dart';
import 'package:nftwist/provider/app_content.dart';
import 'package:nftwist/provider/auth.dart';
import 'package:nftwist/provider/homeModule.dart';
import 'package:nftwist/provider/market_place_nfts.dart';
import 'package:nftwist/provider/on_going.dart';
import 'package:nftwist/provider/other_profile.dart';
import 'package:nftwist/provider/search_data.dart';
import 'package:nftwist/provider/tab_controller.dart';
import 'package:nftwist/provider/user.dart';
import 'package:nftwist/services/locator.dart';
import 'package:nftwist/services/navigation_service.dart';
import 'package:nftwist/services/route.dart';
import 'package:nftwist/services/storageFunctions.dart';
import 'package:nftwist/ui/Onboard%20Screen/splash_screen.dart';
import 'package:provider/provider.dart';
import 'constant/color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'notification/notification_service.dart';
 var token='';
List? country;
int? initScreen;
extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform
  // );
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  initScreen = sharedPreferences.getInt('initScreen');
  // print("----------------------$initScreen");
  if (initScreen != 1) {
    await StorageFunctions().deleteAllValue(reInstall: true);
  }
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent, // Color for Android
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarColor:appColor,
      systemNavigationBarContrastEnforced: true,
      systemNavigationBarDividerColor: Colors.transparent,
      statusBarBrightness: Brightness.dark // Dark == white status bar -- for IOS.
  ));

  setupLocator();
  token = await StorageFunctions().getValue(authToken);
  // print("Token0001------$token");
  // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  // NotificationServices().getFCM();
  // NotificationServices().initInfo();
runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Auth()),
        ChangeNotifierProvider(create: (_) => User()),
        ChangeNotifierProvider(create: (_) => AppContents()),
        ChangeNotifierProvider(create: (_) => OtherUserProfile()),
        ChangeNotifierProvider(create: (_) => HomeModuleProvider()),
        ChangeNotifierProvider(create: (_) => Nfts()),
        ChangeNotifierProvider(create: (_) => Search()),
        ChangeNotifierProvider(create: (_) => AppTabController()),
        ChangeNotifierProvider(create: (_) => OnGoingCampaigns(),),
      ],
      child: const NFTwist(),
    );
  }
}
class NFTwist extends StatelessWidget {
  const NFTwist({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      scrollBehavior: const CupertinoScrollBehavior(),
      debugShowCheckedModeBanner: false,
      navigatorKey: locator<NavigationService>().navigatorKey,
      scaffoldMessengerKey: locator<Toaster>().snackbarKey,
      routes: route,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: appColor,
        textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(textStyle:const TextStyle(fontWeight: FontWeight.w400,fontSize: 14,color:textColor),),),
        textTheme:   Theme.of(context).textTheme.apply(
          bodyColor: textColor,
          fontFamily: GoogleFonts.montserrat().fontFamily,
          displayColor: whiteColor2,
        ),
        checkboxTheme: CheckboxThemeData(
          checkColor: MaterialStateProperty.all(blackColor),
          fillColor: MaterialStateProperty.all(whiteColor),
        ),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        colorScheme: ColorScheme.fromSeed(
          seedColor: whiteColor,
          primary: appColor,
        ),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

