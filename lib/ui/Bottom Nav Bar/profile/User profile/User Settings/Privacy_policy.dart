import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:nftwist/constant/style.dart';
import 'package:nftwist/widget/appBar.dart';
import 'package:provider/provider.dart';

import '../../../../../provider/app_content.dart';
import '../../../../../constant/app_content_modal.dart' ;

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);
  static const route = "privacy-policy";
  @override
  Widget build(BuildContext context) {
    var appData=Provider.of<AppContents>(context,listen: false);
    var privacy=appData.appPrivacy;
    var getPrivacy=appData.getAppData(type.PRIVACY_POLICY.name);
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Privacy Policy",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
              children: [
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              height: 188,
              width: MediaQuery.of(context).size.width,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: const Image(
                  image: AssetImage("assets/images/about_1.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            FutureBuilder(future: getPrivacy, builder: (context, snapshot) {
              if(snapshot.connectionState==ConnectionState.waiting){
                return const Center(child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(color: Colors.white,),
                ),);
              }else if (snapshot.hasError){
                return Center(child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Error", style: w_500,),
                ),);
              }
              else{
                  return HtmlWidget(
                    privacy?.text ?? '',
                    textStyle: w_500,
                    //   customWidgetBuilder: (element) {
                    //   print(element.localName);
                    //   if(element.localName=='ol'){
                    //   return Text("${element.text}");}
                    // },
                  );
                }
              },),
            // Text(
            //   "Polygon Networks, Inc. d/b/a Nftwist (\"Nftwist,\" \"we\", \"us\", or \"our\") is committed to protecting your privacy. We have prepared this Privacy Policy to describe to you our practices regarding the Personal Data (as defined below) we collect, use, and share in connection with the Nftwist website, mobile app, and other software provided on or in connection with our services, as described in our Terms of Service (collectively, the \"Service\"). \"NFT\" in this Privacy Policy means a non-fungible token or similar digital item implemented on a blockchain (such as the Ethereum blockchain), which uses smart contracts to link to or otherwise be associated with certain content or data.Types of Data We Collect. \"Personal Data\" means data that allows someone to identify you individually, including, for example, your name, email address, as well as any other non-public information about you that is associated with or linked to any of the foregoing. \"Anonymous Data\" means data, including aggregated and de-identified data, that is not associated with or linked to your Personal Data; Anonymous Data does not, by itself, permit the identification of individual persons. We collect Personal Data and Anonymous Data as described below.Information You Provide Us.When you use our Service, update your account profile, or contact us, we may collect Personal Data from you, such as email address, first and last name, user name, and other information you provide. We also collect your blockchain address, which may become associated with Personal Data when you use our Service.Our Service lets you store preferences like how your content is displayed, notification settings, and favorites. We may associate these choices with your ID, browser, or mobile device.If you provide us with feedback or contact us, we will collect your name and contact information, as well as any other content included in the message.We may also collect Personal Data at other points in our Service where you voluntarily provide it or where we state that Personal Data is being collected.Information Collected via Technology. As you navigate through and interact with our Service, we may use automatic data collection technologies to collect certain information about your equipment, browsing actions, and patterns, including:Information Collected by Our Servers. To provide our Service and make it more useful to you, we (or a third party service provider) collect information from you, including, but not limited to, your browser type, operating system, Internet Protocol (\"IP\") address, mobile device ID, blockchain address, wallet type, and date/time stamps.Log Files. As is true of most websites and applications, we gather certain information automatically and store it in log files. This information includes IP addresses, browser type, Internet service provider (\"ISP\"), referring/exit pages, operating system, date/time stamps, and clickstream data. We use this information to analyze trends, administer the Service, track users' movements around the Service, and better tailor our Services to our users' needs. For example, some of the information may be collected so that when you visit the Service, it will recognize you and the information can be used to personalize your experience.Cookies. Like many online services, we use cookies to collect information. We may use both session Cookies (which expire once you close your web browser) and persistent Cookies (which stay on your computer until you delete them) to analyze how users interact with our Service, make improvements to our product quality, and provide users with a more personalized experience.Pixel Tag. In addition, we use \"Pixel Tags\" (also referred to as clear Gifs, Web beacons, or Web bugs). Pixel Tags allow us to analyze how users find our Service, make the Service more useful to you, and tailor your experience with us to meet your particular interests and needs.How We Respond to Do Not Track Signals. Our systems do not currently recognize \"do not track\" signals or other mechanisms that might enable Users to opt out of tracking on our site.Analytics Services. In addition to the tracking technologies we place like Cookies and Pixel Tags, other companies may set their own cookies or similar tools when you visit our Service. This includes third-party analytics services (\"Analytics Services\") that we engage to help analyze how users use the Service. The information generated by the Cookies or other technologies about your use of our Service (the \"Analytics Information\") is transmitted to the Analytics Services. The Analytics Services use Analytics Information to compile reports on user activity, which we may receive on an individual or aggregate basis. We use the information we get from Analytics Services to improve our Service. The Analytics Services may also transfer information to third parties where required to do so by law, or where such third parties process Analytics Information on their behalf. Each Analytics Services' ability to use and share Analytics Information is restricted by such Analytics Services' terms of use and privacy policy. By using our Service, you consent to the processing of data about you by Analytics Services in the manner and for the purposes set out above.Information Collected from Third-Party Companies. We may receive Personal and/or Anonymous Data about you from companies that offer their products and/or services for use in conjunction with our Service or whose products and/or services may be linked from our Service. For example, third-party wallet providers provide us with your blockchain address and certain other information you choose to share with those wallets providers. We may add this to the data we have already collected from or about you through our Service.Public Information Observed from Blockchains. We collect data from activity that is publicly visible and/or accessible on blockchains. This may include blockchain addresses and information regarding purchases, sales, or transfers of NFTs, which may then be associated with other data you have provided to us.Use of Your Personal Data.We process your Personal Data to run our business, provide the Service, personalize your experience on the Service, and improve the Service. Specifically, we use your Personal Data to:facilitate the creation of and secure your account;identify you as a user in our system;provide you with our Service, including, but not limited to, helping you view, explore, and create NFTs using our tools and, at your own discretion, connect directly with others to purchase, sell, or transfer NFTs on public blockchains;nges. ",
            //   style: w_500,
            //   textAlign: TextAlign.center,
            // ),
            const SizedBox(height: 40,)
          ]),
        ),
      ),
    );
  }
}
