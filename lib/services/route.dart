
import 'package:flutter/cupertino.dart';
import 'package:nftwist/ui/Auth%20Screen/SignIn/forgot_password.dart';
import 'package:nftwist/ui/Auth%20Screen/SignIn/rest_password.dart';
import 'package:nftwist/ui/Auth%20Screen/SignIn/sign_in.dart';
import 'package:nftwist/ui/Auth%20Screen/SignIn/2_way_auth.dart';
import 'package:nftwist/ui/Bottom%20Nav%20Bar/bottom_nav_bar.dart';
import 'package:nftwist/ui/Bottom%20Nav%20Bar/home/become_partner.dart';
import 'package:nftwist/ui/Bottom%20Nav%20Bar/home/featured_news.dart';
import 'package:nftwist/ui/Bottom%20Nav%20Bar/home/news_feed.dart';
import 'package:nftwist/ui/Bottom%20Nav%20Bar/home/ongoing_campaigns.dart';
import 'package:nftwist/ui/Bottom%20Nav%20Bar/profile/Other%20User%20Profile/otheruser_partnerprofile.dart';
import 'package:nftwist/ui/Bottom%20Nav%20Bar/profile/Other%20User%20Profile/otheruser_profile.dart';
import 'package:nftwist/ui/Bottom%20Nav%20Bar/profile/Partner%20profile/Partner%20Settings/add_rule_page.dart';
import 'package:nftwist/ui/Bottom%20Nav%20Bar/profile/followers_screen.dart';
import 'package:nftwist/ui/Bottom%20Nav%20Bar/profile/Partner%20profile/Partner%20Settings/scanning_rules.dart';
import 'package:nftwist/ui/Bottom%20Nav%20Bar/profile/Partner%20profile/select_project.dart';
import 'package:nftwist/ui/Bottom%20Nav%20Bar/profile/User%20profile/User%20Settings/change_password.dart';
import 'package:nftwist/ui/Bottom%20Nav%20Bar/profile/User%20profile/User%20Settings/user_settings.dart';
import 'package:nftwist/ui/Bottom%20Nav%20Bar/search/search_screen.dart';
import '../ui/Auth Screen/SignIn/2_way_auth_otp.dart';
import '../ui/Auth Screen/SignIn/forget_otp_verify.dart';
import '../ui/Auth Screen/SignIn/verify_email_2way.dart';
import '../ui/Auth Screen/SignIn/verify_phone_no2way.dart';
import '../ui/Auth Screen/Signup/personal_details.dart';
import '../ui/Auth Screen/Signup/sign_up.dart';
import '../ui/Auth Screen/Signup/verify_email.dart';
import '../ui/Auth Screen/Signup/verify_otp_screen.dart';
import '../ui/Bottom Nav Bar/QR Scanner/select_type_profile.dart';
import '../ui/Bottom Nav Bar/home/wallet.dart';
import '../ui/Bottom Nav Bar/profile/Partner profile/Partner Settings/partner_setting_screen.dart';

import '../ui/Bottom Nav Bar/profile/User profile/owned_nft_list.dart';
import '../ui/Bottom Nav Bar/profile/following.dart';
import '../ui/Bottom Nav Bar/profile/membership_screen.dart';
import '../ui/Bottom Nav Bar/profile/User profile/User Settings/Privacy_policy.dart';
import '../ui/Bottom Nav Bar/profile/User profile/User Settings/faqs.dart';
import '../ui/Bottom Nav Bar/profile/help_center.dart';
import '../ui/Bottom Nav Bar/profile/User profile/User Settings/terms_conditions.dart';
import '../ui/Bottom Nav Bar/profile/User profile/User Settings/verify.dart';
import '../ui/Bottom Nav Bar/profile/about_us.dart';
import '../ui/Bottom Nav Bar/profile/edit_profile.dart';
import '../ui/Bottom Nav Bar/search/collection_details.dart';
import '../ui/Bottom Nav Bar/search/qr_code.dart';
import '../widget/report_screen.dart';
import '../widget/success_screen.dart';
Map<String, Widget Function(BuildContext)> route = {
  SignUp.route: (context) => const SignUp(),
  SignIn.route: (context) => const SignIn(),
  PersonalDetails.route: (context) => const PersonalDetails(),
  TwoWayAuth.route: (context) => const TwoWayAuth(),
  TwoFAAuth.route: (context) => const TwoFAAuth(),
  Verify2wayPhone.route: (context) => const Verify2wayPhone(),
  Verify2WayEmail.route: (context) => const Verify2WayEmail(),
  VerifyEmail.route: (context) => const VerifyEmail(),
  ForgetVerifyPassword.route: (context) => const ForgetVerifyPassword(),
  ForgotPassword.route: (context) => const ForgotPassword(),
  RestPassword.route: (context) => const RestPassword(),
  BottomNavBar.route: (context) => const BottomNavBar(),
  OngoingCampaigns.route: (context) => const OngoingCampaigns(),
  NewsFeeds.route: (context) => const NewsFeeds(),
  BecomePartner.route: (context) => const BecomePartner(),
  FeaturedNews.route: (context) => const FeaturedNews(),
  Wallet.route: (context) => const Wallet(),
  QRCode.route: (context) => const QRCode(),
  OTPVerify.route: (context) => const OTPVerify(),
  SuccessFullScreen.route: (context) => const SuccessFullScreen(),
  SearchScreen.route: (context) => const SearchScreen(),

  SelectOption.route: (context) => const SelectOption(),
  OwnedNfts.route: (context) => const OwnedNfts(),
  OtherUserProfile.route: (context) => const OtherUserProfile(),
  PartnerSettingScreen.route: (context) => const PartnerSettingScreen(),
  UserSettingScreen.route: (context) => const UserSettingScreen(),
  OtherPartnerProfile.route: (context) => const OtherPartnerProfile(),

  ScanningRules.route: (context) => const ScanningRules(),
  AddRulesScreen.route: (context) => const AddRulesScreen(),
  FollowerScreen.route: (context) => const FollowerScreen(),
  FollowingScreen.route: (context) => const FollowingScreen(),
  MemberShipScreen.route: (context) => const MemberShipScreen(),
  ChangePassword.route: (context) => const ChangePassword(),

  MyProjects.route: (context) => const MyProjects(),

  VerifyScreen.route: (context) => const VerifyScreen(),
  PrivacyPolicyScreen.route: (context) => const PrivacyPolicyScreen(),
  TermsConditions.route: (context) => const TermsConditions(),
  FAQsScreen.route: (context) => const FAQsScreen(),
  HelpCenter.route: (context) => const HelpCenter(),
  EditProfile.route: (context) => const EditProfile(),
  AboutUsScreen.route: (context) => const AboutUsScreen(),
  ReportSuccess.route: (context) => const ReportSuccess(),

 };