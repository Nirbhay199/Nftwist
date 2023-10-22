import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nftwist/constant/style.dart';
import 'package:nftwist/widget/appBar.dart';
import 'package:nftwist/widget/gradient_txt.dart';

import '../../../constant/color.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({Key? key}) : super(key: key);
  static const route = "about_us";
  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: CustomAppBar(title:"About Us"),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 402,
            child: Stack(children: [
              Image.asset(
                "assets/about_us_images/about-partner-banner 1.png",
                height: 308,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
              ),
              const CustomAppBar(
                  title: "About Us", appBarColor: Colors.transparent),
              Positioned(
                top: 130,
                left: 0,
                right: 0,
                child: Text(
                  textAlign: TextAlign.center,
                  "Welcome to NFTwist! Here \nis what we are about.",
                  style: w_600.copyWith(fontSize: 20),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: 188,
                  width: MediaQuery.of(context).size.width - 40,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      "assets/about_us_images/about 1.png",
                      height: 308,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                ),
              )
            ]),
          ),
          Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              GradientTxt(
                txt: "NFTwist is a UAE-Based \nTech Company",
                style: w_600.copyWith(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Our Story",
                style: w_700.copyWith(fontSize: 16),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Text(
                  "We are enthusiasts about blockchain technology and its assets. Who are firm believers that as our digital world gets bigger, our physical world gets more connected.",
                  style: w_500,
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Text(
                  "The NFTwist team is determined to reshape the world that we know today, in new amazing different ways.",
                  style: w_500,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12)),
                child: Image.asset(
                  "assets/about_us_images/our-mission 1.png",
                  height: 220,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              const SizedBox(
                height: 21,
              ),
              Text(
                "Our Mission",
                style: w_700.copyWith(fontSize: 16),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Text(
                  "Our mission is to enable and empower artists and partners, by helping them drive their sales through unconventional digital marketing and enhance their brand further, through blockchain solutions and modern day digital offerings.",
                  style: w_500,
                  textAlign: TextAlign.center,
                ),
              ),
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12)),
                child: Image.asset(
                  "assets/about_us_images/our-vision 1.png",
                  height: 220,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              const SizedBox(
                height: 21,
              ),
              Text(
                "Our Vision",
                style: w_700.copyWith(fontSize: 16),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Text(
                  "We aspire to be the global NFT platform of choice!At NFTwist the future of endless possibilities is envisioned and engraved in our mission to change the world.",
                  style: w_500,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 28,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Image.asset(
                  "assets/about_us_images/nf-about 1.png",
                  height: 200,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GradientTxt(
                txt: "Why NFTwist?",
                style: w_600.copyWith(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Text(
                  "We aspire to be the global NFT platform of choice! At NFTwist the future of endless possibilities is envisioned and engraved in our mission to change the world.",
                  style: w_500,
                  textAlign: TextAlign.center,
                ),
              ),
              Text(
                "Why NFTwist?",
                style: w_500,
                textAlign: TextAlign.center,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Text(
                  "We are starting a revolution in the world of NFTs by allowing creation, buying, selling and transfers to be extremely easy and cheap!",
                  style: w_500,
                  textAlign: TextAlign.center,
                ),
              ),
              Text(
                "Our Impact on the Environment?",
                style: w_500,
                textAlign: TextAlign.center,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Text(
                  "We made sure to use an environmentally friendly blockchain (Binance Smart Chain and Polygon) thus ensuring a low carbon footprint.",
                  style: w_500,
                  textAlign: TextAlign.center,
                ),
              ),
              Text(
                "Our Impact on People and Businesses?",
                style: w_500,
                textAlign: TextAlign.center,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Text(
                  "We help businesses and their customers forge unique relations, which creates long lasting pleasant memories together.",
                  style: w_500,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 28,
              ),
              GradientTxt(
                txt: "NFTwist Values",
                style: w_600.copyWith(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 35,
              ),
              Image.asset(
                "assets/about_us_images/nft-value1 1.png",
                height: 200,
                fit: BoxFit.cover,
                width: 200,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "NFTs to millions",
                style: w_700.copyWith(fontSize: 16),
              ),
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Text(
                  "We aim to bring the real potential of NFT's to life",
                  style: w_500,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 28,
              ),
              Image.asset(
                "assets/about_us_images/nft-value2 1.png",
                height: 200,
                fit: BoxFit.cover,
                width: 200,
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                    "We aim to bring the real potential of NFT's to life",
                    style: w_700.copyWith(fontSize: 16),
                    textAlign: TextAlign.center),
              ),
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Text(
                  "We are utilizing state of the art technologies to insure that our customer's NFT's/ Digital assets are protected",
                  style: w_500,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 28,
              ),
              Image.asset(
                "assets/about_us_images/nft-value3 1.png",
                height: 200,
                fit: BoxFit.cover,
                width: 200,
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text("We embody integrity",
                    style: w_700.copyWith(fontSize: 16),
                    textAlign: TextAlign.center),
              ),
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Text(
                  "By integrating the latest technologies, we have insured that all AML and FATF standards are on an international enterprise level",
                  style: w_500,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 28,
              ),
              Image.asset(
                "assets/about_us_images/nft-value4 1.png",
                height: 200,
                fit: BoxFit.cover,
                width: 200,
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text("We are customer focused",
                    style: w_700.copyWith(fontSize: 16),
                    textAlign: TextAlign.center),
              ),
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Text(
                  "We are driven by the desire to please and empower our customers whether they are business partners or individuals",
                  style: w_500,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          )
        ],
      ),
    );
  }
}
